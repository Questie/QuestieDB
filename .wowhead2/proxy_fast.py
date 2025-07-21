"""Simplified, high-performance proxy manager for maximum throughput."""

from __future__ import annotations
import threading
import time
from typing import Optional, List, Tuple
from collections import deque
import os
from dotenv import load_dotenv
from urllib.parse import quote


class FastProxyManager:
  """
  High-performance proxy manager optimized for throughput.

  Uses in-memory circular buffer instead of SQLite for rate limiting.
  Designed to minimize contention and maximize requests per second.
  """

  def __init__(self, rate_limit_seconds: float = 0.1):
    load_dotenv()
    self.rate_limit_seconds = rate_limit_seconds

    # Proxy configuration
    self.username = os.getenv("PROXY_USERNAME")
    self.password = os.getenv("PROXY_PASSWORD")
    self.proxy_host = os.getenv("PROXY_HOST")

    # Set up proxy ports
    us_ports = list(range(8001, 8027))  # 26 ports
    ger_ports = list(range(8027, 8033))  # 6 ports
    self.all_ports = us_ports + ger_ports

    self.proxy_enabled = bool(self.username and self.password and self.proxy_host)

    if self.proxy_enabled:
      encoded_username = quote(self.username.encode("utf-8")) if self.username else ""
      encoded_password = quote(self.password.encode("utf-8")) if self.password else ""
      self.proxy_urls = {port: f"http://{encoded_username}:{encoded_password}@{self.proxy_host}:{port}" for port in self.all_ports}
    else:
      self.proxy_urls = {}
      print("Proxy credentials not found - running without proxies")

    # High-performance rate limiting using circular buffers
    # Each proxy gets its own last_used timestamp
    self._last_used = {port: 0.0 for port in self.all_ports}
    self._port_queue = deque(self.all_ports)  # Round-robin queue
    self._lock = threading.Lock()  # Single lock for minimal contention

    print(f"FastProxyManager initialized:")
    print(f"  - {len(self.all_ports)} proxy ports")
    print(f"  - {rate_limit_seconds}s rate limit per port")
    print(f"  - Theoretical max: {len(self.all_ports) / rate_limit_seconds:.1f} req/s")
    print(f"  - Proxy enabled: {self.proxy_enabled}")

  def get_next_proxy(self) -> Tuple[Optional[str], float]:
    """Get next available proxy with minimal overhead."""
    if not self.proxy_enabled:
      return None, 0.0

    current_time = time.time()

    with self._lock:
      # Find first available port (round-robin with rate limiting)
      for _ in range(len(self.all_ports)):
        port = self._port_queue.popleft()
        self._port_queue.append(port)  # Move to end of queue

        time_since_last_use = current_time - self._last_used[port]

        if time_since_last_use >= self.rate_limit_seconds:
          # Port is available
          self._last_used[port] = current_time
          return self.proxy_urls[port], 0.0

      # All ports are rate-limited, calculate minimum wait time
      min_wait = float("inf")
      for port in self.all_ports:
        time_since_use = current_time - self._last_used[port]
        wait_time = self.rate_limit_seconds - time_since_use
        if wait_time > 0:
          min_wait = min(min_wait, wait_time)

      return None, max(0.0, min_wait)

  def get_concurrency_limit(self) -> int:
    """Return the number of concurrent slots available."""
    return len(self.all_ports)
