import os
import threading
import sqlite3
import time
import datetime
from dotenv import load_dotenv
from urllib.parse import quote
from typing import Optional


# Ports for US and GER proxies
USProxyPorts = list(range(8001, 8027))  # US proxy ports
GERProxyPorts = list(range(8027, 8033))  # GER proxy ports


class RateLimitedProxyManager:
  """
  Provides proxies based on least recent usage, respecting a rate limit.
  Can also function as a simple rate limiter if proxy credentials are not provided.
  """

  def __init__(self, ports: list[int] = (USProxyPorts + GERProxyPorts), db_path="rate_usage.db", rate_limit_seconds: float = 1):
    """
    Initializes the manager. If proxy environment variables are set, it manages proxy URLs.
    If not, it functions as a simple concurrency/rate limiter using abstract IDs.

    Args:
        ports (list[int]): A list of proxy ports or, if proxies are disabled,
                           a list whose length determines the number of concurrent slots.
        db_path (str): Path to the SQLite database file.
        rate_limit_seconds (float): Minimum time interval (in seconds) between uses of the same proxy/slot.
    """
    load_dotenv()
    self.username = os.getenv("PROXY_USERNAME")
    self.password = os.getenv("PROXY_PASSWORD")
    self.proxy_host = os.getenv("PROXY_HOST")
    self.rate_limit_seconds = rate_limit_seconds
    self.proxy_enabled = False  # Default to disabled

    if not self.username or not self.password or not self.proxy_host:
      print("Warning: Proxy environment variables not found. Running in rate-limiter-only mode.")
      self.proxy_enabled = False
      # In rate-limiter mode, ports are just abstract IDs.
      # Replace the list of actual ports with a list of simple integers.
      self.all_ports = list(range(1, len(ports) + 1))
      self.proxy_urls_by_port = {}
    else:
      self.proxy_enabled = True
      print("Proxy support enabled.")
      print("Proxy username:", self.username)
      print("Proxy password:", self.password[0] + "********")
      print("Proxy host:", self.proxy_host)
      # In proxy mode, use the provided ports
      self.all_ports = ports
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

    self._initialize_db()

  def is_enabled(self) -> bool:
    """Returns True if proxy support is enabled, False otherwise."""
    return self.proxy_enabled

  def _initialize_db(self):
    """Creates the necessary table if it doesn't exist."""
    if self.conn is None:
      print("Error: Database connection is not established.")
      return
    if self.cursor is None:
      print("Error: Database cursor is not initialized.")
      return
    with self._db_lock:
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

  def _cleanup_old_entries(self):
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

  def _get_next_available_slot(self) -> Optional[int]:
    """
    Internal method to find the next available port/slot.
    This contains the core logic shared by get_next_proxy and get_next_slot.
    Must be called within a _db_lock.
    """
    # --- Cleanup old entries ---
    self._cleanup_old_entries()
    # --- End cleanup ---

    cutoff_time = datetime.datetime.now() - datetime.timedelta(seconds=self.rate_limit_seconds)
    cutoff_timestamp_str = cutoff_time.isoformat()

    # Step 1: Find all ports_or_slots that have NEVER been used
    self.cursor.execute("SELECT DISTINCT port_or_slot FROM rate_usage")
    used_ports_ever = {row[0] for row in self.cursor.fetchall()}
    never_used_ports = self.all_ports_set - used_ports_ever

    selected_port = None
    if never_used_ports:
      # Priority 1: Use a port that has never been used (pick lowest number for consistency)
      selected_port = min(never_used_ports)
    else:
      # Step 2: All ports have been used, find ports outside rate limit window
      self.cursor.execute("SELECT DISTINCT port_or_slot FROM rate_usage WHERE timestamp >= ?", (cutoff_timestamp_str,))
      recently_used_ports = {row[0] for row in self.cursor.fetchall()}
      available_ports = self.all_ports_set - recently_used_ports

      if available_ports:
        # Priority 2: Find the least recently used among available ports
        placeholders = ",".join("?" * len(available_ports))
        query = f"""
                    SELECT port_or_slot, MAX(timestamp) as last_used
                    FROM rate_usage
                    WHERE port_or_slot IN ({placeholders})
                    GROUP BY port_or_slot
                    ORDER BY last_used ASC
                    LIMIT 1
                """
        self.cursor.execute(query, tuple(available_ports))
        result = self.cursor.fetchone()

        if result:
          selected_port = result[0]
        else:
          # This case should ideally not be reached if available_ports is not empty,
          # but as a fallback, we can select the minimum available port.
          selected_port = min(available_ports)

    return selected_port

  def get_next_slot(self) -> Optional[int]:
    """
    Checks if a concurrency slot is available based on the rate limit.
    If a slot is available, it's marked as used and the method returns the slot number.
    Otherwise, it returns None.
    """
    if self.conn is None or self.cursor is None:
      print("Error: Database connection not initialized.")
      return None

    with self._db_lock:
      selected_port = self._get_next_available_slot()

      if selected_port is not None:
        # Log the usage of the selected port/slot
        current_timestamp_str = datetime.datetime.now().isoformat()
        self.cursor.execute("INSERT INTO rate_usage (port_or_slot, timestamp) VALUES (?, ?)", (selected_port, current_timestamp_str))
        self.conn.commit()
        return selected_port
      else:
        # No slot available within the rate limit
        return None

  def get_next_proxy(self) -> Optional[str]:
    """
    Returns the proxy URL that hasn't been used within the rate limit window
    and was least recently used. Returns None if proxy support is disabled or
    no proxy is available.
    """
    if not self.proxy_enabled:
      return None

    if self.conn is None or self.cursor is None:
      print("Error: Database connection not initialized.")
      return None

    with self._db_lock:
      selected_port = self._get_next_available_slot()

      if selected_port is not None:
        # Log the usage of the selected port
        current_timestamp_str = datetime.datetime.now().isoformat()
        self.cursor.execute("INSERT INTO rate_usage (port_or_slot, timestamp) VALUES (?, ?)", (selected_port, current_timestamp_str))
        self.conn.commit()
        # Return the corresponding URL
        return self.proxy_urls_by_port.get(selected_port)
      else:
        # No proxy available within the rate limit
        return None

  def concurrency_count(self) -> int:
    """Returns the total number of concurrency slots available."""
    return len(self.all_ports)

  def close(self):
    """Closes the database connection."""
    with self._db_lock:
      if self.conn:
        self.conn.close()
        self.conn = None
        print("Database connection closed.")


# ! Below is just test code for the class, not part of the class itself
# --- Example Usage ---
if __name__ == "__main__":
  # --- Test Configuration ---
  # Set to True to test proxy mode, False to test rate-limiter-only mode.
  # For proxy mode to work, you must have a .env file with proxy credentials.
  TEST_PROXY_MODE = False  # os.path.exists('.env')
  DB_PATH = "ratelimit-test.db" if not TEST_PROXY_MODE else "rate_usage-test.db"
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
      ports=(USProxyPorts + GERProxyPorts),
      db_path=DB_PATH,
      rate_limit_seconds=1,
    )

  if not manager.is_enabled() and TEST_PROXY_MODE:
    print("\nProxy support is not configured. Cannot run proxy mode test.")
    manager.close()
    exit()

  print(f"\nTotal available slots/proxies: {manager.concurrency_count()}")
  print("\nStarting workers to request access...")

  successful_requests = 0
  request_lock = threading.Lock()

  def worker(worker_id):
    global successful_requests
    for i in range(10):  # Each worker makes 10 requests
      if manager.is_enabled():  # Proxy mode test
        next_proxy = None
        while next_proxy is None:
          next_proxy = manager.get_next_proxy()
          if next_proxy is None:
            time.sleep(0.5)
        with request_lock:
          successful_requests += 1
        proxy_port = next_proxy.split(":")[-1]
        print(f"Worker {worker_id},\t Request {i + 1}:\t Using proxy port {proxy_port}\t at {datetime.datetime.now().time()}")
      else:  # Rate-limiter mode test
        can_proceed = None
        while can_proceed is None:
          can_proceed = manager.get_next_slot()
          if can_proceed is None:
            time.sleep(0.5)
        with request_lock:
          successful_requests += 1
        print(f"Worker {worker_id},\t Request {i + 1}:\t Concurrency slot {can_proceed} granted\t at {datetime.datetime.now().time()}")

      # Simulate work
      time.sleep(0.5)

  threads = []
  num_workers = 64
  start_time = time.monotonic()

  for i in range(num_workers):
    t = threading.Thread(target=worker, args=(i + 1,), daemon=True)
    threads.append(t)
    t.start()
    time.sleep(0.05)

  for t in threads:
    t.join()

  end_time = time.monotonic()
  elapsed_time = end_time - start_time

  print("\nAll worker threads finished.")
  print("\n--- Performance Stats ---")
  print(f"Total available slots/proxies: {manager.concurrency_count()}")
  print(f"Total successful requests: {successful_requests}")
  print(f"Total time elapsed: {elapsed_time:.2f} seconds")
  if elapsed_time > 0:
    rate = successful_requests / elapsed_time
    print(f"Average request rate: {rate:.2f} requests/second")

  # --- Verification Step ---
  print("\n--- Verification ---")
  db_path_to_verify = manager.db_path
  total_slots_available = manager.concurrency_count()
  all_slots_in_manager = set(manager.all_ports)

  manager.close()  # Close the manager's connection to ensure all data is flushed

  print(f"Verifying database: {db_path_to_verify}")
  try:
    conn_verify = sqlite3.connect(db_path_to_verify)
    cursor_verify = conn_verify.cursor()
    cursor_verify.execute("SELECT DISTINCT port_or_slot FROM rate_usage")
    used_ports = {row[0] for row in cursor_verify.fetchall()}
    conn_verify.close()

    used_ports_count = len(used_ports)
    print(f"Total slots available in manager: {total_slots_available}")
    print(f"Unique slots used in test: {used_ports_count}")

    if used_ports_count == total_slots_available:
      print("✅ Success: All available slots were utilized during the test.")
    else:
      print(f"❌ Failure: Expected {total_slots_available} slots to be used, but only {used_ports_count} were.")
      missed_slots = all_slots_in_manager - used_ports
      if missed_slots:
        print(f"   Missed slots: {sorted(list(missed_slots))}")
  except sqlite3.Error as e:
    print(f"Error during verification: {e}")
