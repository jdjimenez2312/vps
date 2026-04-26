#!/bin/bash

set -e

VERSION="1.8.2"
ARCHIVE="node_exporter-${VERSION}.linux-arm64.tar.gz"
FOLDER="node_exporter-${VERSION}.linux-arm64"
URL="https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/${ARCHIVE}"

echo "[1/6] Descargando node-exporter para ARM64..."
cd /tmp
wget -O "${ARCHIVE}" "${URL}"

echo "[2/6] Extrayendo e instalando binario..."
tar xvf "${ARCHIVE}"
sudo mv "${FOLDER}/node_exporter" /usr/local/bin/
sudo chmod +x /usr/local/bin/node_exporter

echo "[3/6] Creando usuario dedicado (si no existe)..."
if ! id -u node_exporter >/dev/null 2>&1; then
		sudo useradd --no-create-home --shell /bin/false node_exporter
fi

echo "[4/6] Creando servicio systemd..."
sudo tee /etc/systemd/system/node_exporter.service > /dev/null << 'EOF'
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter \
	--web.listen-address=0.0.0.0:9100 \
	--collector.filesystem.mount-points-exclude=^/(sys|proc|dev|host|etc)($|/)
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

echo "[5/6] Recargando, habilitando e iniciando servicio..."
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl restart node_exporter

echo "[6/6] Verificando estado y métricas..."
sudo systemctl status node_exporter --no-pager
curl -fsSL http://127.0.0.1:9100/metrics | head -3
