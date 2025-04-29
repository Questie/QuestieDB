import os
import threading
from dotenv import load_dotenv
from urllib.parse import quote
import requests  # For example usage


class SimpleProxyManager:
  """Provides proxies in a simple round-robin fashion."""

  def __init__(self):
    """Initializes the manager, loading configuration and preparing proxy URLs."""
    load_dotenv()
    self.username = os.getenv("PROXY_USERNAME")
    self.password = os.getenv("PROXY_PASSWORD")
    self.proxy_host = os.getenv("PROXY_HOST")

    if not self.username or not self.password or not self.proxy_host:
      print("Error: Please provide PROXY_USERNAME, PROXY_PASSWORD, and PROXY_HOST in .env file or environment variables.")
      exit(1)  # Or raise an exception

    print("Proxy username:", self.username)
    print("Proxy password:", self.password[0] + "********")
    print("Proxy host:", self.proxy_host)

    # Define proxy port ranges
    USProxyPorts = list(range(8001, 8027))  # Ports 8001 to 8026
    GERProxyPorts = list(range(8027, 8033))  # Ports 8027 to 8032
    self.all_ports = USProxyPorts + GERProxyPorts

    # Pre-format all proxy URLs
    self.proxy_urls = []
    encoded_username = quote(self.username)
    encoded_password = quote(self.password)
    for port in self.all_ports:
      url = f"http://{encoded_username}:{encoded_password}@{self.proxy_host}:{port}"
      self.proxy_urls.append(url)

    if not self.proxy_urls:
      print("Error: No proxy ports configured.")
      exit(1)  # Or raise an exception

    # Index for round-robin selection
    self._current_index = 0
    # Lock for thread safety
    self._lock = threading.Lock()

  def get_next_proxy(self) -> str:
    """Returns the next proxy URL using simple round-robin."""
    with self._lock:
      proxy_url = self.proxy_urls[self._current_index]
      self._current_index = (self._current_index + 1) % len(self.proxy_urls)
      return proxy_url

  def get_total_number_of_proxies(self) -> int:
    """Returns the total number of proxies available."""
    return len(self.proxy_urls)


# --- Example Usage ---
if __name__ == "__main__":
  proxy_manager = SimpleProxyManager()

  print("\nGetting proxies in round-robin order:")
  for i in range(len(proxy_manager.proxy_urls) + 2):  # Get a few more to show wrap-around
    next_proxy = proxy_manager.get_next_proxy()
    print(f"Request {i + 1}: Using proxy ...@{next_proxy.split('@')[1]}")

    # Example of using the proxy with the requests library
    proxies = {"http": next_proxy, "https": next_proxy}
    try:
      # Replace with your actual target URL
      response = requests.get("https://oxylabs.io", proxies=proxies, timeout=30)
      print(response.text)
      response.raise_for_status()
      print(f"  -> Response from IP: {response.json().get('origin')}")
    except requests.exceptions.RequestException as e:
      print(f"  -> Error using proxy: {e}")
    except Exception as e:
      print(f"  -> Unexpected Error: {e}")
