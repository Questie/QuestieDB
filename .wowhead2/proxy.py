import os
import threading
import sqlite3
import time
import datetime
from dotenv import load_dotenv
from urllib.parse import quote
from typing import Optional, Dict, Set, List, Tuple, Any


# Ports for US and GER proxies
USProxyPorts: List[int] = list(range(8001, 8027))  # US proxy ports
GERProxyPorts: List[int] = list(range(8027, 8033))  # GER proxy ports


class RateLimitedProxyManager:
  """
  Provides proxies based on least recent usage, respecting a rate limit.
  Can also function as a simple rate limiter if proxy credentials are not provided.

  ARCHITECTURE OVERVIEW:
  =====================
  This class solves the "thundering herd" problem that occurs when many workers
  compete for a limited number of rate-limited resources (proxy slots).

  Traditional approach problems:
  - All workers calculate when the next slot becomes available
  - Everyone gets the same tiny wait time (e.g., 0.01 seconds)
  - All workers wake up simultaneously
  - Only one succeeds, others repeat the cycle
  - Creates database contention and poor performance

  Our queue-aware solution:
  - Tracks how many workers are currently waiting (_waiting_count)
  - Distributes wait times based on queue position
  - Workers wake up in staggered batches instead of all at once
  - Reduces database contention and improves overall throughput

  Key components:
  - SQLite database tracks last usage time for each slot/proxy
  - _waiting_count tracks current queue length
  - Queue-aware algorithm calculates realistic wait times
  - Graceful fallback when slots become available
  """

  # Type hints for instance attributes
  username: Optional[str]
  password: Optional[str]
  proxy_host: Optional[str]
  rate_limit_seconds: float
  proxy_enabled: bool
  all_ports: List[int]
  proxy_urls_by_port: Dict[int, str]
  all_ports_set: Set[int]
  db_path: str
  conn: Optional[sqlite3.Connection]
  cursor: Optional[sqlite3.Cursor]
  _db_lock: threading.Lock
  _waiting_count: int
  _waiting_lock: threading.Lock

  # Add context manager support for better resource cleanup
  def __enter__(self) -> "RateLimitedProxyManager":
    return self

  def __exit__(self, exc_type: Optional[type], exc_val: Optional[Exception], exc_tb: Optional[Any]) -> None:
    self.close()

  def __init__(self, ports_or_slot: list[int] = (USProxyPorts + GERProxyPorts), db_path: str = "rate_usage.db", rate_limit_seconds: float = 1) -> None:
    """
    Initializes the manager. If proxy environment variables are set, it manages proxy URLs.
    If not, it functions as a simple concurrency/rate limiter using abstract IDs.

    Args:
        ports_or_slot (Optional[List[int]]): A list of proxy ports or, if proxies are disabled,
                           a list whose length determines the number of concurrent slots.
        db_path (str): Path to the SQLite database file.
        rate_limit_seconds (float): Minimum time interval (in seconds) between uses of the same proxy/slot.
    """
    if ports_or_slot is None:
      ports_or_slot = USProxyPorts + GERProxyPorts

    # Validate configuration
    if rate_limit_seconds <= 0:
      raise ValueError("rate_limit_seconds must be positive")

    if not ports_or_slot:
      raise ValueError("ports list cannot be empty")

    if len(set(ports_or_slot)) != len(ports_or_slot):
      raise ValueError("ports list contains duplicates")

    load_dotenv()
    self.username = os.getenv("PROXY_USERNAME") or None
    self.password = os.getenv("PROXY_PASSWORD") or None
    self.proxy_host = os.getenv("PROXY_HOST") or None
    self.rate_limit_seconds = rate_limit_seconds
    self.proxy_enabled = False  # Default to disabled

    if not self.username or not self.password or not self.proxy_host:
      print("Warning: Proxy environment variables not found. Running in rate-limiter-only mode.")
      self.proxy_enabled = False
      # In rate-limiter mode, ports are just abstract IDs.
      # Replace the list of actual ports with a list of simple integers.
      self.all_ports = list(range(1, len(ports_or_slot) + 1))
      self.proxy_urls_by_port = {}
    else:
      self.proxy_enabled = True
      print("Proxy support enabled.")
      print("Proxy username:", self.username)
      print("Proxy password:", self.password[0] + "********")
      print("Proxy host:", self.proxy_host)
      # In proxy mode, use the provided ports
      self.all_ports = ports_or_slot
      # Pre-format all proxy URLs keyed by port
      self.proxy_urls_by_port = {}
      encoded_username = quote(self.username)
      encoded_password = quote(self.password)
      for port in self.all_ports:
        url = f"http://{encoded_username}:{encoded_password}@{self.proxy_host}:{port}"
        self.proxy_urls_by_port[port] = url

      if not self.proxy_urls_by_port:
        print("Error: No proxy ports configured.")
        exit(1)

    print(f"Rate limit window: {self.rate_limit_seconds} seconds")
    print(f"Number of concurrent slots/proxies: {len(self.all_ports)}")

    self.all_ports_set = set(self.all_ports)  # For faster lookups

    # --- SQLite Setup ---
    self.db_path = db_path
    # Use check_same_thread=False with external locking
    self.conn = sqlite3.connect(self.db_path, check_same_thread=False)
    if self.conn is None:
      print("Error: Unable to connect to the SQLite database.")
      exit(1)
    self.cursor = self.conn.cursor()
    self._db_lock = threading.Lock()  # Lock for database operations

    self._waiting_count = 0  # Track how many are waiting
    self._waiting_lock = threading.Lock()  # Separate lock for waiting counter

    self._initialize_db()

  def is_enabled(self) -> bool:
    """Returns True if proxy support is enabled, False otherwise."""
    return self.proxy_enabled

  def _initialize_db(self) -> None:
    """Creates the necessary table if it doesn't exist."""
    if self.conn is None:
      print("Error: Database connection is not established.")
      return
    if self.cursor is None:
      print("Error: Database cursor is not initialized.")
      return
    with self._db_lock:
      # PERFORMANCE OPTIMIZATIONS FOR RATE LIMITING
      # ===========================================
      # Since losing a few rate limit entries isn't critical for a scraper,
      # we can trade durability for significant performance gains.

      # WAL mode: Allows concurrent readers while writing
      # self.cursor.execute("PRAGMA journal_mode=WAL")

      # # Aggressive synchronization settings for maximum speed
      # # NORMAL: Only sync at critical moments (WAL checkpoints)
      # # OFF: Never sync (fastest, but risk of corruption on crash)
      # self.cursor.execute("PRAGMA synchronous=NORMAL")  # Change to OFF for maximum speed

      # # Keep more data in memory before writing to disk
      self.cursor.execute("PRAGMA cache_size=-64000")  # 64MB cache (negative = KB)

      # # Faster temporary storage (uses memory for temp tables/indexes)
      self.cursor.execute("PRAGMA temp_store=MEMORY")

      # # Optimize for our specific use case: many small transactions
      # # This reduces the number of page locks needed
      self.cursor.execute("PRAGMA locking_mode=NORMAL")  # Keep NORMAL for concurrent access

      # # Memory-mapped I/O for faster access (256MB mmap)
      # # This maps database pages directly into memory
      self.cursor.execute("PRAGMA mmap_size=268435456")

      self.cursor.execute("""
                CREATE TABLE IF NOT EXISTS rate_usage (
                    port_or_slot INTEGER NOT NULL,
                    timestamp TEXT NOT NULL
                )
            """)
      # Index for faster timestamp lookups and ordering
      self.cursor.execute("CREATE INDEX IF NOT EXISTS idx_timestamp ON rate_usage (timestamp)")
      # Index for potentially faster port-specific lookups
      self.cursor.execute("CREATE INDEX IF NOT EXISTS idx_port_timestamp ON rate_usage (port_or_slot, timestamp)")
      self.conn.commit()

  def _cleanup_old_entries(self) -> None:
    """Removes entries older than 24 hours from the rate_usage table."""
    if self.conn is None:
      print("Error: Database connection is not established for cleanup.")
      return
    if self.cursor is None:
      print("Error: Database cursor is not initialized for cleanup.")
      return
    # No need for separate lock here if called within a locked method
    try:
      cleanup_cutoff_time = datetime.datetime.now() - datetime.timedelta(hours=24)
      cleanup_timestamp_str = cleanup_cutoff_time.isoformat()
      self.cursor.execute("DELETE FROM rate_usage WHERE timestamp < ?", (cleanup_timestamp_str,))
      self.conn.commit()
    except sqlite3.Error as e:
      print(f"Error during database cleanup: {e}")

  def _get_next_available_slot(self) -> Tuple[Optional[int], float]:
    """
    Internal method to find the next available port/slot and estimate wait time.
    Must be called within a _db_lock.

    WAIT TIME CALCULATION STRATEGY:
    ===============================
    The goal is to provide realistic wait times that account for multiple workers
    competing for the same limited slots. Without this queue-aware calculation,
    all workers would get very short wait times (e.g., 0.01 seconds) because they're
    all calculating when the NEXT slot becomes available. This leads to a "thundering
    herd" effect where everyone wakes up at once and only one succeeds.

    Our solution tracks how many workers are currently waiting and distributes
    the wait times based on queue position, ensuring workers don't all wake up
    simultaneously and create database contention.
    """
    self._cleanup_old_entries()

    now = datetime.datetime.now()
    cutoff_time = now - datetime.timedelta(seconds=self.rate_limit_seconds)
    if self.cursor is None:
      print("Error: Database cursor is not initialized.")
      return None, self.rate_limit_seconds
    if self.conn is None:
      print("Error: Database connection is not initialized.")
      return None, self.rate_limit_seconds

    # Step 1: Find all ports_or_slots that have NEVER been used
    # These are immediately available with no wait time
    self.cursor.execute("SELECT DISTINCT port_or_slot FROM rate_usage")
    used_ports_ever = {row[0] for row in self.cursor.fetchall()}
    never_used_ports = self.all_ports_set - used_ports_ever

    if never_used_ports:
      return min(never_used_ports), 0.0

    # Step 2: Find when slots will become available based on rate limiting
    # Order by last_used ASC so the earliest-available slots come first
    self.cursor.execute(
      """
        SELECT port_or_slot, MAX(timestamp) as last_used
        FROM rate_usage
        GROUP BY port_or_slot
        ORDER BY last_used ASC
        """
    )
    results = self.cursor.fetchall()

    available_slots = []
    for port, last_used_str in results:
      last_used_time = datetime.datetime.fromisoformat(last_used_str)
      if last_used_time < cutoff_time:
        # This slot is available RIGHT NOW (rate limit window has passed)
        return port, 0.0
      else:
        # Calculate when this specific slot will become available
        available_time = last_used_time + datetime.timedelta(seconds=self.rate_limit_seconds)
        wait_duration = (available_time - now).total_seconds()
        available_slots.append((port, wait_duration))

    if not available_slots:
      # Fallback: if we somehow have no slots, wait the full rate limit period
      return None, self.rate_limit_seconds

    # Sort by availability time (shortest wait first)
    available_slots.sort(key=lambda x: x[1])

    # QUEUE-AWARE WAIT TIME CALCULATION
    # =================================
    # Problem: If 100 workers all ask for the next available slot, they'll all get
    # the same short wait time (e.g., when slot #1 becomes free in 0.01 seconds).
    # When they all wake up, only 1 gets the slot, and the other 99 repeat the cycle.
    #
    # Solution: Distribute workers across time by considering their queue position.
    with self._waiting_lock:
      queue_position = self._waiting_count  # How many workers are ahead of us

      # How many slots will become available in the next "batch"?
      # This is limited by either available slots or our total concurrency
      waiting_batch_size = min(len(available_slots), self.concurrency_count())

      # Which "batch" does this worker fall into?
      # Batch 0 = workers 0-7 (if batch size is 8)
      # Batch 1 = workers 8-15, etc.
      batch_number = queue_position // waiting_batch_size
      slot_in_batch = queue_position % waiting_batch_size

      # Calculate base wait time for this worker's position
      if slot_in_batch < len(available_slots):
        # This worker gets one of the slots in the current batch
        # Wait for the slot at their specific position to become available
        base_wait = available_slots[slot_in_batch][1]
      else:
        # This worker needs to wait for the next full cycle
        # (more workers than available slots in this batch)
        base_wait = available_slots[-1][1] + self.rate_limit_seconds

      # Add additional wait time for workers in later batches
      # Each batch must wait an additional rate_limit_seconds beyond the previous batch
      total_wait = base_wait + (batch_number * self.rate_limit_seconds)

      # Example with 8 slots, 20 workers, 1s rate limit:
      # Workers 0-7 (batch 0): Wait 0.01s, 0.02s, 0.03s, etc. (base times)
      # Workers 8-15 (batch 1): Wait base_times + 1s
      # Workers 16-19 (batch 2): Wait base_times + 2s

      # Simple cap to prevent astronomical wait times
      max_wait = self.rate_limit_seconds * 5  # Never wait more than 5x rate limit

      return None, max(0, min(total_wait, max_wait))

  def get_next_slot(self) -> Tuple[Optional[int], float]:
    """
    Checks for an available concurrency slot with queue-aware wait times.

    WAITING COUNTER MANAGEMENT:
    ==========================
    We track _waiting_count to know how many workers are currently waiting for slots.
    This counter is used in _get_next_available_slot() to calculate realistic wait times.

    - INCREMENT when we return None (worker is about to wait)
    - DECREMENT when we return a slot (worker is no longer waiting)

    This prevents the "thundering herd" problem where all workers get tiny wait times
    and wake up simultaneously, creating database contention.
    """
    if self.conn is None or self.cursor is None:
      print("Error: Database connection not initialized.")
      return None, self.rate_limit_seconds

    with self._db_lock:
      selected_port, wait_time = self._get_next_available_slot()

      if selected_port is not None:
        # SUCCESS: We got a slot immediately
        # Log the usage to track this slot's last-used time
        current_timestamp_str = datetime.datetime.now().isoformat()
        self.cursor.execute("INSERT INTO rate_usage (port_or_slot, timestamp) VALUES (?, ?)", (selected_port, current_timestamp_str))
        self.conn.commit()

        # Decrement waiting count since we're no longer waiting
        # (Important: this worker was counted in _get_next_available_slot())
        with self._waiting_lock:
          if self._waiting_count > 0:
            self._waiting_count -= 1

        return selected_port, 0.0
      else:
        # NO SLOT AVAILABLE: Worker will need to wait
        # Increment waiting count since this worker is about to sleep
        # (This count will be used by future calls to calculate queue position)
        with self._waiting_lock:
          self._waiting_count += 1

        return None, wait_time

  def get_next_proxy(self) -> Tuple[Optional[str], float]:
    """
    Returns the next available proxy URL and an estimated wait time.

    If a proxy is available, returns its URL and a wait time of 0.
    If not, returns None and the estimated time in seconds until the
    next proxy is free. Returns (None, 0.0) if proxy support is disabled.

    Uses the same queue-aware wait time calculation as get_next_slot() to prevent
    the "thundering herd" effect when many workers compete for limited proxy slots.
    """
    if not self.proxy_enabled:
      return None, 0.0

    if self.conn is None or self.cursor is None:
      print("Error: Database connection not initialized.")
      return None, self.rate_limit_seconds

    with self._db_lock:
      selected_port, wait_time = self._get_next_available_slot()

      if selected_port is not None:
        # SUCCESS: We got a proxy slot immediately
        # Log the usage of the selected port to track its last-used time
        current_timestamp_str = datetime.datetime.now().isoformat()
        self.cursor.execute("INSERT INTO rate_usage (port_or_slot, timestamp) VALUES (?, ?)", (selected_port, current_timestamp_str))
        self.conn.commit()

        # Decrement waiting count since we're no longer waiting
        # (Important: this worker was counted in _get_next_available_slot())
        with self._waiting_lock:
          if self._waiting_count > 0:
            self._waiting_count -= 1

        # Return the corresponding proxy URL
        return self.proxy_urls_by_port.get(selected_port), 0.0
      else:
        # NO PROXY AVAILABLE: Worker will need to wait
        # Increment waiting count since this worker is about to sleep
        # (This count will be used by future calls to calculate queue position)
        with self._waiting_lock:
          self._waiting_count += 1

        # Return calculated wait time (includes queue-aware distribution)
        return None, wait_time

  def concurrency_count(self) -> int:
    """Returns the total number of concurrency slots available."""
    return len(self.all_ports)

  def close(self) -> None:
    """Properly close the database connection and clean up WAL files."""
    if self.conn is not None:
      try:
        with self._db_lock:
          # Force WAL checkpoint to merge WAL back into main database
          # This is crucial for cleaning up .db-wal and .db-shm files
          # if self.cursor is not None:
          #   print("Performing WAL checkpoint to clean up WAL files...")
          #   self.cursor.execute("PRAGMA wal_checkpoint(TRUNCATE)")

          # Commit any pending transactions
          self.conn.commit()

          # Close cursor first
          if self.cursor is not None:
            self.cursor.close()
            self.cursor = None

          # Close connection
          self.conn.close()
          self.conn = None

          print("Database connection closed and WAL files cleaned up.")

      except sqlite3.Error as e:
        print(f"Error during database cleanup: {e}")
        # Force close even if there's an error
        if self.conn is not None:
          self.conn.close()
          self.conn = None


# ! Below is just test code for the class, not part of the class itself
# --- Example Usage ---
if __name__ == "__main__":
  # --- Test Configuration ---
  # Set to True to test proxy mode, False to test rate-limiter-only mode.
  # For proxy mode to work, you must have a .env file with proxy credentials.
  TEST_PROXY_MODE: bool = False  # os.path.exists('.env')
  DB_PATH: str = "ratelimit-test.db" if not TEST_PROXY_MODE else "rate_usage-test.db"
  # --- End Test Configuration ---

  # Clean up old database file before test
  if os.path.exists(DB_PATH):
    os.remove(DB_PATH)
    print(f"Removed old database file: {DB_PATH}")

  if TEST_PROXY_MODE:
    print("--- TESTING PROXY MANAGER MODE ---")
    # Example with a 1-second rate limit in proxy mode
    manager = RateLimitedProxyManager(db_path=DB_PATH, rate_limit_seconds=1)
  else:
    print("--- TESTING RATE-LIMITER-ONLY MODE ---")
    manager = RateLimitedProxyManager(
      ports_or_slot=(USProxyPorts + GERProxyPorts),
      db_path=DB_PATH,
      rate_limit_seconds=1,
    )

  if not manager.is_enabled() and TEST_PROXY_MODE:
    print("\nProxy support is not configured. Cannot run proxy mode test.")
    manager.close()
    exit()

  print(f"\nTotal available slots/proxies: {manager.concurrency_count()}")
  print("\nStarting workers to request access...")

  successful_requests: int = 0
  request_lock: threading.Lock = threading.Lock()

  def worker(worker_id: int) -> None:
    global successful_requests
    for i in range(10):  # Each worker makes 10 requests
      if manager.is_enabled():  # Proxy mode test
        next_proxy: Optional[str] = None
        wait_time: float = 0
        while next_proxy is None:
          if wait_time > 0:
            # print(f"Sleeping for {wait_time}")
            time.sleep(wait_time)
          next_proxy, wait_time = manager.get_next_proxy()
        with request_lock:
          successful_requests += 1
        proxy_port: str = next_proxy.split(":")[-1]
        print(f"Worker {worker_id},\t Request {i + 1}:\t Using proxy port {proxy_port}\t at {datetime.datetime.now().time()}")
      else:  # Rate-limiter mode test
        can_proceed: Optional[int] = None
        wait_time = 0
        while can_proceed is None:
          if wait_time > 0:
            # print(f"Sleeping for {wait_time}")
            time.sleep(wait_time)
          can_proceed, wait_time = manager.get_next_slot()
        with request_lock:
          successful_requests += 1
        print(f"Worker {worker_id},\t Request {i + 1}:\t Concurrency slot {can_proceed} granted\t at {datetime.datetime.now().time()}")

      # Simulate work
      time.sleep(0.5)

  threads: List[threading.Thread] = []
  num_workers: int = int(32 / manager.rate_limit_seconds)  # Number of workers based on rate limit
  start_time: float = time.monotonic()

  for i in range(num_workers):
    t = threading.Thread(target=worker, args=(i + 1,), daemon=True)
    threads.append(t)
    t.start()
    time.sleep(0.05)

  for t in threads:
    t.join()

  end_time: float = time.monotonic()
  elapsed_time: float = end_time - start_time

  print("\nAll worker threads finished.")
  print("\n--- Performance Stats ---")
  print(f"Total available slots/proxies: {manager.concurrency_count()}")
  print(f"Total successful requests: {successful_requests}")
  print(f"Total time elapsed: {elapsed_time:.2f} seconds")
  if elapsed_time > 0:
    rate: float = successful_requests / elapsed_time
    print(f"Average request rate: {rate:.2f} requests/second")

  # --- Verification Step ---
  print("\n--- Verification ---")
  db_path_to_verify: str = manager.db_path
  total_slots_available: int = manager.concurrency_count()
  all_slots_in_manager: Set[int] = set(manager.all_ports)

  manager.close()  # Close the manager's connection to ensure all data is flushed

  print(f"Verifying database: {db_path_to_verify}")
  try:
    conn_verify: sqlite3.Connection = sqlite3.connect(db_path_to_verify)
    cursor_verify: sqlite3.Cursor = conn_verify.cursor()
    cursor_verify.execute("SELECT DISTINCT port_or_slot FROM rate_usage")
    used_ports: Set[int] = {row[0] for row in cursor_verify.fetchall()}
    conn_verify.commit()
    cursor_verify.close()
    conn_verify.close()

    used_ports_count: int = len(used_ports)
    print(f"Total slots available in manager: {total_slots_available}")
    print(f"Unique slots used in test: {used_ports_count}")

    if used_ports_count == total_slots_available:
      print("✅ Success: All available slots were utilized during the test.")
    else:
      print(f"❌ Failure: Expected {total_slots_available} slots to be used, but only {used_ports_count} were.")
      missed_slots: Set[int] = all_slots_in_manager - used_ports
      if missed_slots:
        print(f"   Missed slots: {sorted(list(missed_slots))}")
  except sqlite3.Error as e:
    print(f"Error during verification: {e}")
