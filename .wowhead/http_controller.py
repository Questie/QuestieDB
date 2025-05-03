# --- Add HTTP Server imports ---
from http.server import BaseHTTPRequestHandler, HTTPServer
import threading

# -------------------------------

stop_event: threading.Event


# --- HTTP Server Implementation ---
class RequestHandler(BaseHTTPRequestHandler):
  def do_GET(self):
    global stop_event
    if self.path == "/stop":
      print("Stop request received via HTTP.")
      stop_event.set()  # Signal all threads to stop
      self.send_response(200)
      self.send_header("Content-type", "text/plain")
      self.end_headers()
      self.wfile.write(b"Stop request received. Processing will halt gracefully.")
    elif self.path == "/":
      self.send_response(200)
      self.send_header("Content-type", "text/plain")
      self.end_headers()
      self.wfile.write(b"Access /stop to halt processing.")
    else:
      self.send_response(404)
      self.send_header("Content-type", "text/plain")
      self.end_headers()
      self.wfile.write(b"Not Found. Use /stop to halt processing.")


def start_http_server(stopEvent: threading.Event, port=8000):
  global stop_event
  stop_event = stopEvent
  server_address = ("", port)
  httpd = HTTPServer(server_address, RequestHandler)
  print(f"Starting control server on port {port}... Access http://localhost:{port}/stop to stop.")
  # Run the server in a daemon thread so it doesn't block the main script
  server_thread = threading.Thread(target=httpd.serve_forever, daemon=True)
  server_thread.start()
  return httpd  # Return server instance if needed for explicit shutdown later
