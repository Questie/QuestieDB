# --- Add HTTP Server imports ---
from http.server import BaseHTTPRequestHandler, HTTPServer
import threading
from typing import Callable, Optional

# -------------------------------

stop_event: threading.Event
progress_function: Optional[Callable[[], str]] = None


# --- HTTP Server Implementation ---
class RequestHandler(BaseHTTPRequestHandler):
  def log_message(self, format: str, *args) -> None:
    """Override to disable HTTP access logging."""
    pass

  def _generate_html_page(self) -> str:
    """Generate HTML page with progress info and stop button."""
    progress_info = ""
    if progress_function:
      progress_info = progress_function()

    html = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>QuestieDB Processing Control</title>
        <meta charset="utf-8">
        <style>
            body {{ font-family: Arial, sans-serif; margin: 20px; }}
            .container {{ max-width: 800px; margin: 0 auto; min-width: 800px; }}
            .progress {{ background: #f0f0f0; padding: 15px; margin: 20px 0; border-radius: 5px; }}
            .stop-button {{
                background: #dc3545;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                margin: 10px 0;
            }}
            .stop-button:hover {{ background: #c82333; }}
            .refresh-button {{
                background: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                margin: 10px 5px;
            }}
            .refresh-button:hover {{ background: #0056b3; }}
            pre {{ background: #f8f9fa; padding: 10px; border-radius: 3px; }}
        </style>
    </head>
    <body>
        <div class="container">
            <h1>QuestieDB WowHead Processing Control Panel</h1>

            <div class="progress">
                <h2>Current Progress:</h2>
                <pre>{progress_info if progress_info else "Progress information not available."}</pre>
            </div>

            <div id="control-buttons">
              <button class="stop-button" onclick="stopProcessing()">Stop Processing</button>
              <button class="refresh-button" onclick="refreshProgress()">Refresh Progress</button>

              <div style="margin-top: 15px; font-size: 14px; color: #666;">
                  Auto-refresh: <span id="auto-refresh-status">Enabled (5s)</span> |
                  <button onclick="toggleAutoRefresh()" id="toggle-auto-refresh" style="background: #28a745; color: white; border: none; padding: 5px 10px; border-radius: 3px; cursor: pointer;">Disable</button>
              </div>
            </div>

            <script>
                let autoRefreshInterval = null;
                let isAutoRefreshEnabled = true;
                let failingRefreshCount = 0;
                const maxFailingRefreshCount = 10;  // Maximum allowed failed refresh attempts

                function updateProgress(isManual = false) {{
                    // Skip failure count check for manual refreshes
                    if (!isManual && failingRefreshCount > maxFailingRefreshCount) {{
                        document.querySelector('.progress pre').textContent = 'Too many failed refresh attempts. Please refresh the page manually.';
                        clearInterval(autoRefreshInterval);
                        autoRefreshInterval = null;
                        isAutoRefreshEnabled = false;
                        // Disable all buttons
                        document.querySelector('.stop-button').disabled = true;
                        document.querySelector('.refresh-button').disabled = true;
                        document.getElementById('toggle-auto-refresh').disabled = true;
                        // Hide control buttons
                        document.getElementById('control-buttons').style.display = 'none';

                        return;
                    }}

                    fetch('/progress')
                        .then(response => response.text())
                        .then(data => {{
                            document.querySelector('.progress pre').textContent = data;
                            failingRefreshCount = 0;  // Reset the count after a successful refresh
                        }})
                        .catch(error => {{
                            console.error('Error fetching progress:', error);
                            document.querySelector('.progress pre').textContent = 'Error loading progress information: ' + failingRefreshCount + '/' + maxFailingRefreshCount + ' failed attempts.';

                            // Only increment failure count for automatic refreshes
                            if (!isManual) {{
                                failingRefreshCount++;
                            }}
                        }});
                }}

                function refreshProgress() {{
                    updateProgress(true);  // Pass true to indicate manual refresh
                }}

                function toggleAutoRefresh() {{
                    const toggleButton = document.getElementById('toggle-auto-refresh');
                    const statusSpan = document.getElementById('auto-refresh-status');

                    if (isAutoRefreshEnabled) {{
                        clearInterval(autoRefreshInterval);
                        autoRefreshInterval = null;
                        isAutoRefreshEnabled = false;
                        toggleButton.textContent = 'Enable';
                        toggleButton.style.background = '#dc3545';
                        statusSpan.textContent = 'Disabled';
                    }} else {{
                        startAutoRefresh();
                        failingRefreshCount = 0;  // Reset failure count when re-enabling
                        isAutoRefreshEnabled = true;
                        toggleButton.textContent = 'Disable';
                        toggleButton.style.background = '#28a745';
                        statusSpan.textContent = 'Enabled (5s)';
                    }}
                }}

                function startAutoRefresh() {{
                    autoRefreshInterval = setInterval(updateProgress, 5000);
                }}

                function stopProcessing() {{
                    if (confirm('Are you sure you want to stop the processing?')) {{
                        fetch('/stop')
                            .then(response => response.text())
                            .then(data => {{
                                // Update progress info with response
                                document.querySelector('.progress pre').textContent = data;

                                // Stop auto-refresh when processing is stopped
                                if (autoRefreshInterval) {{
                                    clearInterval(autoRefreshInterval);
                                    autoRefreshInterval = null;
                                    isAutoRefreshEnabled = false;

                                    document.getElementById('toggle-auto-refresh').disabled = true;
                                    document.getElementById('toggle-auto-refresh').style.display = 'none';
                                    document.getElementById('auto-refresh-status').textContent = 'Disabled (Stopped)';
                                }}

                                // Change the Refresh button to "Refresh page"
                                const refreshButton = document.querySelector('.refresh-button');
                                refreshButton.textContent = 'Refresh Page';
                                refreshButton.onclick = function() {{
                                    window.location.reload();
                                }};

                                // Disable stop button and change its text
                                document.querySelector('.stop-button').disabled = true;
                                document.querySelector('.stop-button').textContent = 'Stop Request Sent';
                                document.querySelector('.stop-button').style.background = '#6c757d';
                            }})
                            .catch(error => {{
                                alert('Error sending stop request: ' + error);
                            }});
                    }}
                }}

                // Start auto-refresh when page loads
                document.addEventListener('DOMContentLoaded', function() {{
                    startAutoRefresh();
                }});
            </script>
        </div>
    </body>
    </html>
    """
    return html

  def do_GET(self):
    global stop_event, progress_function
    if self.path == "/stop":
      print("Stop request received via HTTP.")
      stop_event.set()  # Signal all threads to stop
      self.send_response(200)
      self.send_header("Content-type", "text/plain")
      self.end_headers()
      self.wfile.write(b"Stop request received. Processing will halt gracefully.")
    elif self.path == "/progress":
      self.send_response(200)
      self.send_header("Content-type", "text/plain")
      self.end_headers()
      if progress_function:
        progress_info = progress_function()
        self.wfile.write(progress_info.encode("utf-8"))
      else:
        self.wfile.write(b"Progress information not available.")
    elif self.path == "/":
      self.send_response(200)
      self.send_header("Content-type", "text/html")
      self.end_headers()
      html_content = self._generate_html_page()
      self.wfile.write(html_content.encode("utf-8"))
    else:
      self.send_response(404)
      self.send_header("Content-type", "text/plain")
      self.end_headers()
      self.wfile.write(b"Not Found. Use /stop to halt processing or /progress to see current progress.")


def start_http_server(stopEvent: threading.Event, monitoringDataInformationFunction: Optional[Callable[[], str]] = None, port: int = 8000) -> HTTPServer:
  global stop_event, progress_function
  stop_event = stopEvent
  progress_function = monitoringDataInformationFunction
  server_address = ("", port)
  httpd = HTTPServer(server_address, RequestHandler)
  print(f"Starting control server on port {port}... Access http://localhost:{port} to interact with the scraper.")
  # Run the server in a daemon thread so it doesn't block the main script
  server_thread = threading.Thread(target=httpd.serve_forever, daemon=True)
  server_thread.start()
  return httpd  # Return server instance if needed for explicit shutdown later
