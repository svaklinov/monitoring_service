function fetchData() {
    fetch('/api/resources')
        .then(response => response.json())
        .then(data => {
            document.getElementById('cpu-usage').textContent = data['CPU Usage'];
            document.getElementById('memory-usage').textContent = data['Memory Usage'];
            document.getElementById('disk-usage').textContent = data['Disk Usage'];
            document.getElementById('network-sent').textContent = data['Network Sent'];
            document.getElementById('network-received').textContent = data['Network Received'];
        })
        .catch(error => console.error('Error fetching data:', error));
}

function updateStats() {
    fetchData();
    setInterval(fetchData, 5000); // Update every 5 seconds
}

document.addEventListener('DOMContentLoaded', updateStats);