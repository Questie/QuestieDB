"""HTTP Controller for monitoring and controlling the WowheadFetcher.

This module provides a web interface to monitor fetching progress and
gracefully stop the fetcher when needed.
"""

from __future__ import annotations

import threading
import time
from http.server import BaseHTTPRequestHandler, HTTPServer
from typing import Optional, TYPE_CHECKING, Callable

if TYPE_CHECKING:
  from wowhead_fetcher import WowheadFetcher
  from sitemap_types import VersionSlug, EntityType, Locale


class FetcherControlHandler(BaseHTTPRequestHandler):
  """HTTP request handler for fetcher control and monitoring."""

  def log_message(self, format: str, *args) -> None:
    """Override to disable HTTP access logging."""
    pass

  def _generate_html_page(self) -> str:
    """Generate HTML page with progress info and stop button."""
    fetcher: WowheadFetcher = getattr(self.server, "fetcher", None)  # type: ignore
    default_refresh_ms: int = getattr(self.server, "default_refresh_ms", 2000)  # type: ignore

    progress_info = ""
    status = "Unknown"

    if fetcher:
      if fetcher.is_stopped():
        status = "Stopped"
        progress_info = "Fetcher has been stopped."
      elif fetcher.is_running():
        status = "Running"
        progress_info = fetcher.get_progress_info()
      else:
        status = "Idle"
        progress_info = "Fetcher is idle and ready to start."

    # Generate frequency options with the default selected
    frequency_options = [(1000, "1 second"), (2000, "2 seconds"), (5000, "5 seconds"), (10000, "10 seconds"), (30000, "30 seconds"), (60000, "1 minute")]

    options_html = ""
    default_label = "2s"  # Default fallback
    for value, label in frequency_options:
      selected = "selected" if value == default_refresh_ms else ""
      if value == default_refresh_ms:
        if value < 1000:
          default_label = f"{value}ms"
        elif value < 60000:
          default_label = f"{value // 1000}s"
        else:
          default_label = f"{value // 60000}m"
      options_html += f'<option value="{value}" {selected}>{label}</option>'

    html = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8">
        <title>Wowhead Fetcher Controller</title>
        <style>
            body {{ font-family: Arial, sans-serif; margin: 20px; }}
            .container {{ max-width: 1200px; margin: 0 auto; }}
            .status {{ font-size: 18px; margin: 20px 0; }}
            .running {{ color: green; }}
            .stopped {{ color: red; }}
            .idle {{ color: blue; }}

            .main-content {{ display: flex; gap: 20px; }}
            .operations-panel {{ flex: 0 0 350px; }}
            .progress-panel {{ flex: 1; }}

            .operations {{
                background: #f8f9fa; padding: 15px; border-radius: 5px;
                height: 680px; overflow-y: auto;
            }}
            .operations h3 {{ margin-top: 0; }}
            .operations ul {{ list-style: none; padding: 0; margin: 0; }}
            .operations li {{
                padding: 8px; margin: 2px 0; border-radius: 3px;
                font-size: 14px; display: flex; align-items: center;
            }}
            .operations .status-icon {{ margin-right: 8px; font-size: 16px; }}
            .operation.pending {{ background: #fff3cd; border-left: 4px solid #ffc107; }}
            .operation.active {{ background: #d1ecf1; border-left: 4px solid #17a2b8; animation: pulse 2s infinite; }}
            .operation.completed {{ background: #d4edda; border-left: 4px solid #28a745; }}

            @keyframes pulse {{
                0% {{ opacity: 1; }}
                50% {{ opacity: 0.7; }}
                100% {{ opacity: 1; }}
            }}

            .progress {{ background: #f0f0f0; padding: 20px; margin: 20px 0; border-radius: 5px; }}
            .button {{
                color: white; padding: 10px 20px;
                border: none; font-size: 16px; cursor: pointer; margin: 10px 5px;
                border-radius: 5px;
            }}
            .stop-button {{ background: #dc3545; }}
            .stop-button:hover {{ background: #c82333; }}
            .stop-button:disabled {{ background: #6c757d; cursor: not-allowed; }}
            .refresh-button {{ background: #007bff; }}
            .refresh-button:hover {{ background: #0056b3; }}
            .info {{ background: #e8f4f8; padding: 15px; margin: 20px 0; border-radius: 5px; }}
            pre {{ background: #f8f9fa; padding: 10px; border-radius: 3px; white-space: pre-wrap; }}
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Wowhead Fetcher Controller</h1>

            <div class="status {status.lower()}">
                Status: <strong id="status-text">{status}</strong>
            </div>

            <div class="main-content">
                <div class="operations-panel">
                    <div class="operations">
                        <h3>Operations Queue (<span id="operations-count">0</span>)</h3>
                        <ul id="operations-list">
                            <li>Loading operations...</li>
                        </ul>
                    </div>
                </div>

                <div class="progress-panel">
                    <div class="progress">
                        <h3>Progress Information:</h3>
                        <pre id="progress-info">{progress_info}</pre>
                        <div style="color: #666; font-size: 12px;">
                          Last updated: <span id="last-updated">{time.strftime("%Y-%m-%d %H:%M:%S")}</span>
                        </div>
                    </div>
                    <div id="control-buttons">
                        <button class="button stop-button" id="stop-btn" onclick="stopFetcher()">Stop Fetcher</button>
                        <button class="button refresh-button" onclick="refreshProgress()">Refresh Progress</button>

                        <div style="margin-top: 15px; font-size: 14px; color: #666;">
                            Auto-refresh: <span id="auto-refresh-status">Enabled ({default_label})</span> |
                            <button onclick="toggleAutoRefresh()" id="toggle-auto-refresh" style="background: #28a745; color: white; border: none; padding: 5px 10px; border-radius: 3px; cursor: pointer;">Disable</button>
                            <br><br>
                            <label for="refresh-frequency">Update Frequency:</label>
                            <select id="refresh-frequency" onchange="changeRefreshFrequency()" style="margin-left: 10px; padding: 5px;">
                                {options_html}
                            </select>
                        </div>
                    </div>

                    <div class="info">
                        <h3>Instructions:</h3>
                        <ul>
                            <li>Operations list on the left shows all planned tasks</li>
                            <li>&#x1F504; = Currently running, &#x2705; = Completed, &#x23F3; = Pending</li>
                            <li>Progress updates automatically based on selected frequency</li>
                            <li>Click "Stop Fetcher" to gracefully stop the current operation</li>
                            <li>The fetcher will finish current requests before stopping</li>
                            <li>Use Ctrl+C in the terminal as a backup stop method</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <script>
            let autoRefreshInterval = null;
            let isAutoRefreshEnabled = true;
            let failureCount = 0;
            const maxFailures = 10;
            let currentRefreshFrequency = {default_refresh_ms}; // Configurable default

            function updateProgress(isManual = false) {{
                // Don't auto-update if page is not visible (saves resources)
                if (!isManual && !document.hasFocus() && document.hidden) {{
                    return;
                }}

                if (!isManual && failureCount > maxFailures) {{
                    document.getElementById('progress-info').textContent = 'Too many failed refresh attempts. Please refresh page manually.';
                    clearInterval(autoRefreshInterval);
                    autoRefreshInterval = null;
                    isAutoRefreshEnabled = false;
                    return;
                }}

                // Add timeout to prevent hanging requests
                const controller = new AbortController();
                const timeoutId = setTimeout(() => controller.abort(), 8000); // 8 second timeout

                const progressRequest = fetch('/progress', {{ signal: controller.signal }});
                const statusRequest = fetch('/status_check', {{ signal: controller.signal }});
                const operationsRequest = fetch('/current_index', {{ signal: controller.signal }});

                Promise.all([progressRequest, statusRequest, operationsRequest])
                    .then(async ([progressResponse, statusResponse, operationsResponse]) => {{
                        clearTimeout(timeoutId);

                        const progressData = await progressResponse.text();
                        const statusData = await statusResponse.text();
                        const operationsData = await operationsResponse.json();

                        document.getElementById('progress-info').textContent = progressData;
                        document.getElementById('status-text').textContent = statusData;
                        document.getElementById('last-updated').textContent = new Date().toLocaleString();

                        const statusContainer = document.getElementById('status-text').parentElement;
                        statusContainer.className = 'status ' + statusData.toLowerCase();

                        // Update operations list
                        updateOperationsList(operationsData);

                        failureCount = 0;
                    }})
                    .catch(error => {{
                        clearTimeout(timeoutId);
                        console.error('Error fetching data:', error);

                        let errorMessage = 'Error loading data: ';
                        if (error.name === 'AbortError') {{
                            errorMessage += 'Request timed out after 8 seconds';
                        }} else if (error.message.includes('Failed to fetch')) {{
                            errorMessage += 'Server unavailable or network error';
                        }} else {{
                            errorMessage += error.message;
                        }}

                        document.getElementById('progress-info').textContent = errorMessage;

                        if (!isManual) {{
                            failureCount++;
                        }}
                    }});
            }}

            function updateOperationsList(operationsData) {{
                const operationsList = document.getElementById('operations-list');
                const operationsCount = document.getElementById('operations-count');

                if (!operationsData || operationsData.error) {{
                    operationsList.innerHTML = '<li>Operations data not available</li>';
                    operationsCount.textContent = '0';
                    return;
                }}

                operationsCount.textContent = operationsData.total_operations;

                if (operationsData.operations && operationsData.operations.length > 0) {{
                    let html = '';
                    operationsData.operations.forEach(op => {{
                        let icon = '&#x23F3;'; // Pending (hourglass)
                        let statusClass = 'pending';

                        if (op.status === 'completed') {{
                            icon = '&#x2705;'; // Completed (checkmark)
                            statusClass = 'completed';
                        }} else if (op.status === 'active') {{
                            icon = '&#x1F504;'; // Active (rotating arrows)
                            statusClass = 'active';
                        }}

                        const limitText = op.limit ? ' (' + op.limit + ')' : '';
                        html += '<li class="operation ' + statusClass + '">' +
                            '<span class="status-icon">' + icon + '</span>' +
                            '<span>' + op.version + ' ' + op.entity_type + limitText + ' [' + op.locale + ']</span>' +
                        '</li>';
                    }});
                    operationsList.innerHTML = html;
                }} else {{
                    operationsList.innerHTML = '<li>No operations defined</li>';
                }}
            }}

            function refreshProgress() {{
                updateProgress(true);
            }}

            function getFrequencyLabel(ms) {{
                if (ms < 1000) return ms + 'ms';
                if (ms < 60000) return (ms / 1000) + 's';
                return (ms / 60000) + 'm';
            }}

            function changeRefreshFrequency() {{
                const select = document.getElementById('refresh-frequency');
                const newFrequency = parseInt(select.value);
                currentRefreshFrequency = newFrequency;

                // Update status display
                const statusSpan = document.getElementById('auto-refresh-status');
                const frequencyLabel = getFrequencyLabel(newFrequency);

                if (isAutoRefreshEnabled) {{
                    statusSpan.textContent = `Enabled (${{frequencyLabel}})`;
                    // Restart auto-refresh with new frequency
                    startAutoRefresh();
                }}

                console.log(`Refresh frequency changed to ${{frequencyLabel}}`);
            }}

            function toggleAutoRefresh() {{
                const toggleButton = document.getElementById('toggle-auto-refresh');
                const statusSpan = document.getElementById('auto-refresh-status');
                const frequencyLabel = getFrequencyLabel(currentRefreshFrequency);

                if (isAutoRefreshEnabled) {{
                    clearInterval(autoRefreshInterval);
                    autoRefreshInterval = null;
                    isAutoRefreshEnabled = false;
                    toggleButton.textContent = 'Enable';
                    toggleButton.style.background = '#dc3545';
                    statusSpan.textContent = 'Disabled';
                }} else {{
                    startAutoRefresh();
                    failureCount = 0;
                    isAutoRefreshEnabled = true;
                    toggleButton.textContent = 'Disable';
                    toggleButton.style.background = '#28a745';
                    statusSpan.textContent = `Enabled (${{frequencyLabel}})`;
                }}
            }}

            function startAutoRefresh() {{
                // Clear any existing interval
                if (autoRefreshInterval) {{
                    clearInterval(autoRefreshInterval);
                }}
                // Start new interval with current frequency
                autoRefreshInterval = setInterval(updateProgress, currentRefreshFrequency);
            }}

            function stopFetcher() {{
                if (confirm('Are you sure you want to stop the fetcher?')) {{
                    const stopBtn = document.getElementById('stop-btn');
                    stopBtn.disabled = true;
                    stopBtn.textContent = 'Stopping...';

                    // Add timeout for stop request too
                    const controller = new AbortController();
                    const timeoutId = setTimeout(() => controller.abort(), 10000); // 10 second timeout for stop

                    fetch('/stop', {{ signal: controller.signal }})
                        .then(response => response.text())
                        .then(data => {{
                            clearTimeout(timeoutId);
                            document.getElementById('progress-info').textContent = data;
                            stopBtn.textContent = 'Stop Request Sent';
                            stopBtn.style.background = '#6c757d';

                            // Stop auto-refresh when processing is stopped
                            if (autoRefreshInterval) {{
                                clearInterval(autoRefreshInterval);
                                autoRefreshInterval = null;
                                isAutoRefreshEnabled = false;
                                document.getElementById('toggle-auto-refresh').disabled = true;
                                document.getElementById('auto-refresh-status').textContent = 'Disabled (Stopped)';
                                document.getElementById('refresh-frequency').disabled = true;
                            }}
                        }})
                        .catch(error => {{
                            clearTimeout(timeoutId);
                            let errorMsg = 'Error sending stop request: ';
                            if (error.name === 'AbortError') {{
                                errorMsg += 'Request timed out';
                            }} else {{
                                errorMsg += error.message;
                            }}
                            alert(errorMsg);
                            stopBtn.disabled = false;
                            stopBtn.textContent = 'Stop Fetcher';
                        }});
                }}
            }}

            // Handle page visibility changes to save resources
            document.addEventListener('visibilitychange', function() {{
                if (document.hidden && autoRefreshInterval) {{
                    // Pause auto-refresh when page is hidden
                    clearInterval(autoRefreshInterval);
                    autoRefreshInterval = null;
                    console.log('Auto-refresh paused (page hidden)');
                }} else if (!document.hidden && isAutoRefreshEnabled && !autoRefreshInterval) {{
                    // Resume auto-refresh when page becomes visible
                    startAutoRefresh();
                    console.log('Auto-refresh resumed (page visible)');
                }}
            }});

            // Start auto-refresh when page loads
            document.addEventListener('DOMContentLoaded', function() {{
                startAutoRefresh();
                updateProgress(true); // Load initial data including operations list
            }});
        </script>
    </body>
    </html>
    """
    return html

  def do_GET(self) -> None:
    """Handle GET requests."""
    fetcher: WowheadFetcher = getattr(self.server, "fetcher", None)  # type: ignore
    get_current_running_index: Optional[Callable[[], int]] = getattr(self.server, "get_current_running_index", None)  # type: ignore

    if self.path == "/" or self.path.startswith("/?"):
      self.send_response(200)
      self.send_header("Content-type", "text/html")
      self.end_headers()
      self.wfile.write(self._generate_html_page().encode())

    elif self.path == "/progress":
      self.send_response(200)
      self.send_header("Content-type", "text/plain")
      self.end_headers()
      if fetcher:
        progress_info = fetcher.get_progress_info()
        self.wfile.write(progress_info.encode("utf-8"))
      else:
        self.wfile.write(b"Progress information not available.")

    elif self.path == "/current_index":
      self.send_response(200)
      self.send_header("Content-type", "application/json")
      self.end_headers()

      operations = getattr(self.server, "operations", [])  # type: ignore
      if get_current_running_index and operations:
        import json

        current_index = get_current_running_index()

        # Build response with operations status
        response_data = {"current_index": current_index, "total_operations": len(operations), "operations": []}

        for i, (version, entity_type, limit, locale) in enumerate(operations):
          if i < current_index:
            status = "completed"
          elif i == current_index:
            status = "active"
          else:
            status = "pending"

          response_data["operations"].append({"index": i, "version": version.value, "entity_type": entity_type, "limit": limit, "locale": locale.value, "status": status})

        self.wfile.write(json.dumps(response_data).encode("utf-8"))
      else:
        import json

        self.wfile.write(json.dumps({"error": "Operations data not available"}).encode("utf-8"))

    elif self.path == "/status_check":
      self.send_response(200)
      self.send_header("Content-type", "text/plain")
      self.end_headers()
      if fetcher:
        if fetcher.is_stopped():
          status = "Stopped"
        elif fetcher.is_running():
          status = "Running"
        else:
          status = "Idle"
        self.wfile.write(status.encode("utf-8"))
      else:
        self.wfile.write(b"Unknown")

    elif self.path == "/stop":
      # Handle stop via GET for fetch API
      if fetcher:
        print("HTTP Controller: Received stop request")
        fetcher.request_stop()
        message = "Stop request sent. The fetcher will finish current operations and stop gracefully."
      else:
        message = "No fetcher instance available."

      self.send_response(200)
      self.send_header("Content-type", "text/plain")
      self.end_headers()
      self.wfile.write(message.encode("utf-8"))

    else:
      self.send_response(404)
      self.end_headers()


class FetcherControlServer:
  """HTTP server for controlling and monitoring WowheadFetcher."""

  def __init__(
    self,
    fetcher: WowheadFetcher,
    port: int = 8000,
    default_refresh_ms: int = 2000,
    get_current_running_index: Optional[Callable[[], int]] = None,
    operations: Optional[list[tuple[VersionSlug, EntityType, int | None, Locale]]] = None,
  ) -> None:
    self.fetcher = fetcher
    self.port = port
    self.default_refresh_ms = default_refresh_ms
    self.server: Optional[HTTPServer] = None
    self.server_thread: Optional[threading.Thread] = None
    self.get_current_running_index = get_current_running_index
    self.operations = operations or []

  def start(self) -> None:
    """Start the HTTP control server."""
    if self.server is not None:
      print("Control server is already running")
      return

    try:
      self.server = HTTPServer(("", self.port), FetcherControlHandler)
      # Attach the fetcher, operations, and default refresh frequency to the server so handlers can access it
      setattr(self.server, "fetcher", self.fetcher)
      setattr(self.server, "default_refresh_ms", self.default_refresh_ms)
      setattr(self.server, "get_current_running_index", self.get_current_running_index)
      setattr(self.server, "operations", self.operations)

      self.server_thread = threading.Thread(target=self.server.serve_forever, daemon=True)
      self.server_thread.start()

      print(f"Fetcher control server started on port {self.port}")
      print(f"Access http://localhost:{self.port} to monitor and control the fetcher")

    except OSError as e:
      print(f"Failed to start control server on port {self.port}: {e}")
      self.server = None
      self.server_thread = None

  def stop(self) -> None:
    """Stop the HTTP control server."""
    if self.server is not None:
      print("Shutting down control server...")
      self.server.shutdown()
      self.server.server_close()
      self.server = None

    if self.server_thread is not None:
      self.server_thread.join(timeout=5.0)
      self.server_thread = None
