##install minio
#!/bin/bash

# ================================
# INSTALL MINIO ON UBUNTU/DEBIAN
# ================================

set -e

echo "🔄 Update package..."
sudo apt update && sudo apt upgrade -y

echo "📦 Install dependency..."
sudo apt install -y wget curl

echo "📥 Download MinIO binary..."
wget https://dl.min.io/server/minio/release/linux-amd64/minio

echo "🔐 Set permission..."
chmod +x minio

echo "📁 Move binary to /usr/local/bin..."
sudo mv minio /usr/local/bin/

echo "👤 Create user minio..."
sudo useradd -r minio-user -s /sbin/nologin || true

echo "📂 Create directory..."
sudo mkdir -p /mnt/data
sudo chown minio-user:minio-user /mnt/data

echo "⚙️ Create config file..."
sudo tee /etc/default/minio > /dev/null <<EOF
MINIO_ROOT_USER=admin
MINIO_ROOT_PASSWORD=password123
MINIO_VOLUMES="/mnt/data"
MINIO_OPTS="--console-address :9001"
EOF

echo "⚙️ Create systemd service..."
sudo tee /etc/systemd/system/minio.service > /dev/null <<EOF
[Unit]
Description=MinIO
Documentation=https://docs.min.io
After=network.target

[Service]
User=minio-user
Group=minio-user
EnvironmentFile=/etc/default/minio
ExecStart=/usr/local/bin/minio server \$MINIO_VOLUMES \$MINIO_OPTS
Restart=always
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

echo "🔄 Reload systemd..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload

echo "🚀 Enable & start MinIO..."
sudo systemctl enable minio
sudo systemctl start minio

echo "✅ Installation complete!"
echo "🌐 Akses MinIO:"
echo "   API    : http://localhost:9000"
echo "   Console: http://localhost:9001"
echo "👤 User   : admin"
echo "🔑 Pass   : password123"