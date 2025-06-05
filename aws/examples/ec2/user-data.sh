#!/bin/bash

yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OpenTofu EC2 Demo</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            min-height: 100vh;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 20px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 40px;
        }
        .header h1 {
            font-size: 3em;
            margin: 0;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        .header p {
            font-size: 1.2em;
            opacity: 0.9;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .info-card {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .info-card h3 {
            margin: 0 0 10px 0;
            color: #ffd700;
        }
        .info-card p {
            margin: 5px 0;
            font-family: 'Courier New', monospace;
        }
        .loading {
            color: #ffd700;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }
        .footer {
            text-align: center;
            margin-top: 40px;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 Hello from ${server_name}!</h1>
            <p>Your OpenTofu EC2 instance is running successfully</p>
        </div>
        
        <div class="info-grid">
            <div class="info-card">
                <h3>📍 Instance Information</h3>
                <p><strong>Instance ID:</strong> <span id="instance-id" class="loading">Loading...</span></p>
                <p><strong>Availability Zone:</strong> <span id="az" class="loading">Loading...</span></p>
                <p><strong>Instance Type:</strong> <span id="instance-type" class="loading">Loading...</span></p>
            </div>
            
            <div class="info-card">
                <h3>🛠️ Infrastructure Details</h3>
                <p><strong>Created with:</strong> OpenTofu</p>
                <p><strong>Server Name:</strong> ${server_name}</p>
                <p><strong>Web Server:</strong> Apache HTTP Server</p>
            </div>
            
            <div class="info-card">
                <h3>🕒 System Information</h3>
                <p><strong>Page loaded:</strong> <span id="current-time"></span></p>
                <p><strong>Server uptime:</strong> <span id="uptime" class="loading">Loading...</span></p>
            </div>
        </div>
        
        <div class="footer">
            <p>✨ This page was generated automatically during instance launch</p>
        </div>
    </div>
    
    <script>
        // Fetch instance metadata
        async function fetchMetadata(endpoint, elementId) {
            try {
                const response = await fetch(`http://169.254.169.254/latest/meta-data/$${endpoint}`);
                const data = await response.text();
                document.getElementById(elementId).textContent = data;
                document.getElementById(elementId).classList.remove('loading');
            } catch (error) {
                document.getElementById(elementId).textContent = 'N/A';
                document.getElementById(elementId).classList.remove('loading');
            }
        }
        
        // Load instance information
        fetchMetadata('instance-id', 'instance-id');
        fetchMetadata('placement/availability-zone', 'az');
        fetchMetadata('instance-type', 'instance-type');
        
        // Show current time
        document.getElementById('current-time').textContent = new Date().toLocaleString();
        
        // Fetch system uptime
        fetch('/cgi-bin/uptime')
            .then(response => response.text())
            .then(data => {
                document.getElementById('uptime').textContent = data || 'N/A';
                document.getElementById('uptime').classList.remove('loading');
            })
            .catch(() => {
                document.getElementById('uptime').textContent = 'N/A';
                document.getElementById('uptime').classList.remove('loading');
            });
    </script>
</body>
</html>
EOF

chown apache:apache /var/www/html/index.html
chmod 644 /var/www/html/index.html

mkdir -p /var/www/cgi-bin
cat > /var/www/cgi-bin/uptime << 'EOF'
#!/bin/bash
echo "Content-Type: text/plain"
echo ""
uptime | cut -d',' -f1 | cut -d' ' -f4-
EOF

chmod +x /var/www/cgi-bin/uptime
chown apache:apache /var/www/cgi-bin/uptime

echo "LoadModule cgi_module modules/mod_cgi.so" >> /etc/httpd/conf/httpd.conf
echo "ScriptAlias /cgi-bin/ /var/www/cgi-bin/" >> /etc/httpd/conf/httpd.conf

systemctl restart httpd
