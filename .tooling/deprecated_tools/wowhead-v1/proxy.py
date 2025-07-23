import os
import threading
import sqlite3
import time
import datetime
from dotenv import load_dotenv
from urllib.parse import quote
from typing import Optional  # Import Optional for type hinting


class RateLimitedProxyManager:
  """Provides proxies based on least recent usage, respecting a rate limit."""

  def __init__(self, db_path="proxy_usage.db", rate_limit_seconds: float = 1):
    """
    Initializes the manager, loading config, preparing URLs, and setting up SQLite.

    Args:
        db_path (str): Path to the SQLite database file.
        rate_limit_seconds (float): Minimum time interval (in seconds) between uses of the same proxy.
    """
    load_dotenv()
    self.username = os.getenv("PROXY_USERNAME")
    self.password = os.getenv("PROXY_PASSWORD")
    self.proxy_host = os.getenv("PROXY_HOST")
    self.rate_limit_seconds = rate_limit_seconds

    if not self.username or not self.password or not self.proxy_host:
      print("Error: Please provide PROXY_USERNAME, PROXY_PASSWORD, and PROXY_HOST in .env file or environment variables.")
      exit(1)

    print("Proxy username:", self.username)
    print("Proxy password:", self.password[0] + "********")
    print("Proxy host:", self.proxy_host)
    print(f"Rate limit window: {self.rate_limit_seconds} seconds")

    # Define proxy port ranges
    USProxyPorts = list(range(8001, 8027))
    GERProxyPorts = list(range(8027, 8033))
    self.all_ports = USProxyPorts + GERProxyPorts
    self.all_ports_set = set(self.all_ports)  # For faster lookups

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

  def _initialize_db(self):
    """Creates the necessary table if it doesn't exist."""
    if self.conn is None:
      print("Error: Database connection is not established.")
      return
    with self._db_lock:
      self.cursor.execute("""
                CREATE TABLE IF NOT EXISTS proxy_usage (
                    port INTEGER NOT NULL,
                    timestamp TEXT NOT NULL
                )
            """)
      # Index for faster timestamp lookups and ordering
      self.cursor.execute("CREATE INDEX IF NOT EXISTS idx_timestamp ON proxy_usage (timestamp)")
      # Index for potentially faster port-specific lookups
      self.cursor.execute("CREATE INDEX IF NOT EXISTS idx_port_timestamp ON proxy_usage (port, timestamp)")
      self.conn.commit()

  def _cleanup_old_entries(self):
    """Removes entries older than 24 hours from the proxy_usage table."""
    if self.conn is None:
      print("Error: Database connection is not established for cleanup.")
      return
    # No need for separate lock here if called within get_next_proxy's lock
    try:
      cleanup_cutoff_time = datetime.datetime.now() - datetime.timedelta(hours=24)
      cleanup_timestamp_str = cleanup_cutoff_time.isoformat()
      # print(f"Cleaning up entries older than {cleanup_timestamp_str}") # Optional: for debugging
      self.cursor.execute("DELETE FROM proxy_usage WHERE timestamp < ?", (cleanup_timestamp_str,))
      deleted_count = self.cursor.rowcount
      if deleted_count > 0:
        # print(f"Cleaned up {deleted_count} old entries.") # Optional: for debugging
        self.conn.commit()  # Commit only if changes were made
    except sqlite3.Error as e:
      print(f"Error during database cleanup: {e}")
      # Consider rolling back if part of a larger transaction, though commit is safe here.

  def get_next_proxy(self) -> Optional[str]:  # Changed return type hint
    """
    Returns the proxy URL that hasn't been used within the rate limit window
    and was least recently used among the available ones. Cleans up old entries first.
    Returns None if no proxy is available within the rate limit window.
    """
    if self.conn is None:
      print("Error: Database connection is not established.")
      # Consider raising an exception instead of exiting
      # raise ConnectionError("Database connection is not established.")
      exit(1)  # Or return None here as well? Depends on desired behavior.

    with self._db_lock:
      # --- Cleanup old entries ---
      self._cleanup_old_entries()
      # --- End cleanup ---

      cutoff_time = datetime.datetime.now() - datetime.timedelta(seconds=self.rate_limit_seconds)
      cutoff_timestamp_str = cutoff_time.isoformat()

      # Step 1: Find all ports that have NEVER been used
      self.cursor.execute("SELECT DISTINCT port FROM proxy_usage")
      used_ports_ever = {row[0] for row in self.cursor.fetchall()}
      never_used_ports = self.all_ports_set - used_ports_ever

      if never_used_ports:
        # Priority 1: Use a port that has never been used (pick lowest number for consistency)
        selected_port = min(never_used_ports)
      else:
        # Step 2: All ports have been used, find ports outside rate limit window
        self.cursor.execute("SELECT DISTINCT port FROM proxy_usage WHERE timestamp >= ?", (cutoff_timestamp_str,))
        recently_used_ports = {row[0] for row in self.cursor.fetchall()}
        available_ports = self.all_ports_set - recently_used_ports

        if available_ports:
          # Priority 2: Find the least recently used among available ports
          placeholders = ",".join("?" * len(available_ports))
          query = f"""
                        SELECT port, MAX(timestamp) as last_used
                        FROM proxy_usage
                        WHERE port IN ({placeholders})
                        GROUP BY port
                        ORDER BY last_used ASC
                        LIMIT 1
                    """
          self.cursor.execute(query, tuple(available_ports))
          result = self.cursor.fetchone()

          if result:
            selected_port = result[0]
          else:
            # This shouldn't happen if available_ports is not empty
            selected_port = min(available_ports)
        else:
          # No ports available within rate limit
          return None

      # Ensure selected_port is not None
      if selected_port is None:
        print("Error: Could not select a port despite available ports existing.")
        return None

      # Log the usage of the selected port
      current_timestamp_str = datetime.datetime.now().isoformat()
      self.cursor.execute("INSERT INTO proxy_usage (port, timestamp) VALUES (?, ?)", (selected_port, current_timestamp_str))
      self.conn.commit()

      # Return the corresponding URL
      return self.proxy_urls_by_port[selected_port]

  def get_total_number_of_proxies(self) -> int:
    """Returns the total number of proxies available."""
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
  # Example with a 5-second rate limit
  proxy_manager = RateLimitedProxyManager(db_path="proxy_usage-test.db", rate_limit_seconds=1)

  print("\nGetting proxies based on rate limit and least recent use:")

  # --- Rate Calculation Setup ---
  successful_requests = 0
  request_lock = threading.Lock()
  # --- End Rate Calculation Setup ---

  def worker(worker_id):
    global successful_requests  # Allow modification of the global counter
    for i in range(10):  # Each worker makes 10 requests
      next_proxy = None
      while next_proxy is None:  # Loop until a proxy is available
        next_proxy = proxy_manager.get_next_proxy()
        if next_proxy is None:
          # print(f"Worker {worker_id}, Request {i + 1}: No proxy available, waiting...")
          time.sleep(0.5)  # Wait before retrying
      # --- Rate Calculation Increment ---
      with request_lock:
        successful_requests += 1
      end_time = time.monotonic()
      elapsed_time = end_time - start_time
      rate = successful_requests / elapsed_time
      # --- End Rate Calculation Increment ---

      proxy_port = next_proxy.split(":")[-1]
      print(f"Worker {worker_id},\t Request {i + 1}:\t Using proxy port {proxy_port}\t at {datetime.datetime.now().time()}\t Average request rate: {rate:.2f} requests/second")

      # Simulate work/request
      time.sleep(0.5)  # Simulate some delay before next request

      # --- Example requests usage (optional) ---
      # proxies = {"http": next_proxy, "https": next_proxy}
      # try:
      #     response = requests.get("https://httpbin.org/ip", proxies=proxies, timeout=10)
      #     response.raise_for_status()
      #     print(f"  Worker {worker_id} -> Response from IP: {response.json().get('origin')} (Port: {proxy_port})")
      # except requests.exceptions.RequestException as e:
      #     print(f"  Worker {worker_id} -> Error using proxy {proxy_port}: {e}")
      # except Exception as e:
      #     print(f"  Worker {worker_id} -> Unexpected Error with proxy {proxy_port}: {e}")
      # --- End example requests usage ---

  threads = []
  num_workers = 64
  requests_per_worker = 10
  total_expected_requests = num_workers * requests_per_worker

  start_time = time.monotonic()  # Use monotonic clock for measuring intervals

  for i in range(num_workers):  # Start worker threads
    t = threading.Thread(target=worker, args=(i + 1,), daemon=True)
    threads.append(t)
    t.start()
    time.sleep(0.05)  # Stagger thread starts slightly to avoid thundering herd

  for t in threads:
    t.join()

  end_time = time.monotonic()
  elapsed_time = end_time - start_time

  print("\nAll worker threads finished.")

  # --- Rate Calculation Output ---
  print("\n--- Performance Stats ---")
  print(f"Total successful requests: {successful_requests} (Expected: {total_expected_requests})")
  print(f"Total time elapsed: {elapsed_time:.2f} seconds")
  if elapsed_time > 0:
    rate = successful_requests / elapsed_time
    print(f"Average request rate: {rate:.2f} requests/second")
  else:
    print("Elapsed time too short to calculate rate.")
  # --- End Rate Calculation Output ---

  print("\nAll worker threads finished.")
  proxy_manager.close()
