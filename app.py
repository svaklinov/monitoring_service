from flask import Flask, render_template, jsonify
import psutil

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/resources')
def resources():
    # Get CPU usage
    cpu_usage = psutil.cpu_percent(interval=1)
    
    # Get memory usage
    memory = psutil.virtual_memory()
    memory_used = memory.used / (1024 ** 3)  # Convert bytes to GB
    memory_total = memory.total / (1024 ** 3)  # Convert bytes to GB
    
    # Get disk usage
    disk = psutil.disk_usage('/')
    disk_used = disk.used / (1024 ** 3)  # Convert bytes to GB
    disk_total = disk.total / (1024 ** 3)  # Convert bytes to GB
    
    # Get network statistics
    net_io = psutil.net_io_counters()
    bytes_sent = net_io.bytes_sent / (1024 ** 2)  # Convert bytes to MB
    bytes_recv = net_io.bytes_recv / (1024 ** 2)  # Convert bytes to MB
    
    # Create a response dictionary
    response = {
        "CPU Usage": f"{cpu_usage}%",
        "Memory Usage": f"{memory_used:.2f} GB / {memory_total:.2f} GB",
        "Disk Usage": f"{disk_used:.2f} GB / {disk_total:.2f} GB",
        "Network Sent": f"{bytes_sent:.2f} MB",
        "Network Received": f"{bytes_recv:.2f} MB"
    }
    
    return jsonify(response)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
