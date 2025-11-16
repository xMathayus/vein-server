from flask import Flask, render_template, jsonify, request, Response
import subprocess
import threading
import time
import os
from datetime import datetime
from collections import deque

app = Flask(__name__)

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
SERVER_DIR = os.path.join(BASE_DIR, "vein-server")

LOG_FILE_PATH = os.path.join(SERVER_DIR, "Vein", "Saved", "Logs", "Vein.log")
SERVER_COMMAND = ["cmd.exe", "/c", "Start-VeinServer.bat"]
SERVER_WORKING_DIR = SERVER_DIR
SERVER_PROCESS_NAMES = ["VeinServer.exe", "VeinServer-Win64-Test.exe"]

display_logs = deque(maxlen=800)
full_logs = deque()
service_status = {"status": "unknown", "message": ""}
action_status = {"action": "none", "status": "none", "message": ""}
service_info = {"uptime": "Unknown", "started_at": "Unknown", "status": "unknown"}

server_process = None
server_started_at = None

log_thread = None
log_file_position = 0


def is_server_running():
    if os.name != "nt":
        return False
    try:
        result = subprocess.run(["tasklist"], capture_output=True, text=True)
        if result.returncode != 0:
            return False
        text = result.stdout.lower()
        for name in SERVER_PROCESS_NAMES:
            if name and name.lower() in text:
                return True
        return False
    except Exception:
        return False


def start_server_process():
    global server_process, server_started_at, service_status
    if is_server_running():
        service_status = {"status": "running", "message": "Server already running"}
        return
    creationflags = 0
    if os.name == "nt":
        creationflags = subprocess.CREATE_NEW_PROCESS_GROUP
    try:
        server_process = subprocess.Popen(
            SERVER_COMMAND,
            cwd=SERVER_WORKING_DIR if SERVER_WORKING_DIR else None,
            creationflags=creationflags,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        server_started_at = datetime.now()
        service_status = {"status": "running", "message": "Server process started"}
    except Exception as e:
        service_status = {"status": "stopped", "message": f"Failed to start server: {e}"}


def stop_server_process():
    global server_process, server_started_at, service_status
    if not is_server_running():
        service_status = {"status": "stopped", "message": "Server is not running"}
        return
    try:
        for name in SERVER_PROCESS_NAMES:
            if not name:
                continue
            try:
                subprocess.run(
                    ["taskkill", "/F", "/T", "/IM", name],
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.DEVNULL,
                )
            except Exception:
                pass
        if server_process is not None and server_process.poll() is None:
            try:
                server_process.terminate()
            except Exception:
                pass
        server_started_at = None
        service_status = {"status": "stopped", "message": "Server stopped"}
    except Exception as e:
        service_status = {"status": "unknown", "message": f"Failed to stop server: {e}"}


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/restart-service", methods=["POST"])
def restart_service():
    global action_status
    action_status = {"action": "restart", "status": "running", "message": "Restarting VEIN server"}

    def run_restart():
        global action_status
        try:
            stop_server_process()
            time.sleep(2)
            start_server_process()
            if is_server_running():
                action_status = {"action": "restart", "status": "success", "message": "Server restarted"}
            else:
                action_status = {"action": "restart", "status": "error", "message": "Server did not start after restart"}
        except Exception as e:
            action_status = {"action": "restart", "status": "error", "message": f"Error restarting server: {e}"}

    thread = threading.Thread(target=run_restart)
    thread.daemon = True
    thread.start()
    return jsonify({"message": "Restart initiated"})


@app.route("/start-service", methods=["POST"])
def start_service():
    global action_status
    action_status = {"action": "start", "status": "running", "message": "Starting VEIN server"}

    def run_start():
        global action_status
        try:
            start_server_process()
            if is_server_running():
                action_status = {"action": "start", "status": "success", "message": "Server started"}
            else:
                action_status = {"action": "start", "status": "error", "message": "Server did not start"}
        except Exception as e:
            action_status = {"action": "start", "status": "error", "message": f"Error starting server: {e}"}

    thread = threading.Thread(target=run_start)
    thread.daemon = True
    thread.start()
    return jsonify({"message": "Start initiated"})


@app.route("/stop-service", methods=["POST"])
def stop_service():
    global action_status
    action_status = {"action": "stop", "status": "running", "message": "Stopping VEIN server"}

    def run_stop():
        global action_status
        try:
            stop_server_process()
            action_status = {"action": "stop", "status": "success", "message": "Server stopped"}
        except Exception as e:
            action_status = {"action": "stop", "status": "error", "message": f"Error stopping server: {e}"}

    thread = threading.Thread(target=run_stop)
    thread.daemon = True
    thread.start()
    return jsonify({"message": "Stop initiated"})


@app.route("/get-logs", methods=["GET"])
def get_logs():
    return jsonify({"logs": list(display_logs)})


@app.route("/get-action-status", methods=["GET"])
def get_action_status():
    return jsonify(action_status)


@app.route("/get-service-status", methods=["GET"])
def get_service_status_route():
    check_service_status()
    return jsonify(service_status)


@app.route("/get-service-info", methods=["GET"])
def get_service_info_route():
    update_service_info()
    return jsonify(service_info)


@app.route("/download-logs", methods=["GET"])
def download_logs():
    now = datetime.now()
    date_str = now.strftime("%Y%m%d_%H%M%S")
    filename = f"vein_server_logs_{date_str}.txt"
    log_content = "\n".join(full_logs)
    response = Response(log_content)
    response.headers["Content-Disposition"] = f"attachment; filename={filename}"
    response.headers["Content-Type"] = "text/plain"
    return response


def update_service_info():
    global service_info
    if is_server_running() and server_started_at:
        delta = datetime.now() - server_started_at
        days = delta.days
        hours, rem = divmod(delta.seconds, 3600)
        minutes, seconds = divmod(rem, 60)
        if days > 0:
            uptime_str = f"{days}d {hours}h {minutes}m {seconds}s"
        elif hours > 0:
            uptime_str = f"{hours}h {minutes}m {seconds}s"
        elif minutes > 0:
            uptime_str = f"{minutes}m {seconds}s"
        else:
            uptime_str = f"{seconds}s"
        service_info = {
            "uptime": uptime_str,
            "started_at": server_started_at.strftime("%Y-%m-%d %H:%M:%S"),
            "status": "running",
        }
    else:
        service_info = {
            "uptime": "Not running",
            "started_at": "Not running",
            "status": "stopped",
        }


def check_service_status():
    global service_status
    if is_server_running():
        service_status = {"status": "running", "message": "Server is running"}
    else:
        if service_status["status"] == "unknown":
            msg = "Server not started yet"
        else:
            msg = "Server is not running"
        service_status = {"status": "stopped", "message": msg}


def initialize_logs():
    global display_logs, full_logs, log_file_position
    if not os.path.exists(LOG_FILE_PATH):
        msg = f"Log file not found: {LOG_FILE_PATH}"
        display_logs.append(msg)
        full_logs.append(msg)
        log_file_position = 0
        return
    try:
        with open(LOG_FILE_PATH, "r", encoding="utf-8", errors="ignore") as f:
            lines = f.readlines()
        if len(lines) > 800:
            lines = lines[-800:]
        for line in lines:
            line = line.rstrip("\n")
            if line:
                display_logs.append(line)
                full_logs.append(line)
        log_file_position = os.path.getsize(LOG_FILE_PATH)
    except Exception as e:
        msg = f"Error initializing logs: {e}"
        display_logs.append(msg)
        full_logs.append(msg)
        log_file_position = 0


def watch_logs():
    global log_file_position, display_logs, full_logs
    while True:
        try:
            if os.path.exists(LOG_FILE_PATH):
                with open(LOG_FILE_PATH, "r", encoding="utf-8", errors="ignore") as f:
                    f.seek(log_file_position)
                    new_lines = f.readlines()
                    log_file_position = f.tell()
                for line in new_lines:
                    line = line.rstrip("\n")
                    if line:
                        display_logs.append(line)
                        full_logs.append(line)
            time.sleep(1)
        except Exception as e:
            msg = f"Error in log watcher: {e}"
            display_logs.append(msg)
            full_logs.append(msg)
            time.sleep(5)


@app.route("/clear-logs", methods=["POST"])
def clear_logs():
    global display_logs, full_logs
    display_logs.clear()
    full_logs.clear()
    return jsonify({"message": "Logs cleared"})


@app.route("/restart-log-watcher", methods=["POST"])
def restart_log_watcher_endpoint():
    global log_file_position
    if os.path.exists(LOG_FILE_PATH):
        log_file_position = os.path.getsize(LOG_FILE_PATH)
    msg = f"Log watcher reset at {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
    display_logs.append(msg)
    full_logs.append(msg)
    return jsonify({"message": "Log watcher reset"})


def cleanup():
    stop_server_process()


if __name__ == "__main__":
    import atexit
    atexit.register(cleanup)
    check_service_status()
    update_service_info()
    initialize_logs()
    log_thread = threading.Thread(target=watch_logs)
    log_thread.daemon = True
    log_thread.start()
    app.run(host="0.0.0.0", port=5000, debug=True)
