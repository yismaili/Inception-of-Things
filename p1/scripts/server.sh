#!/usr/bin/env bash

sudo apt-get update -y
sudo apt-get install -y curl

curl -sfL https://get.k3s.io | sh -

curl -LO "https://dl.k8s.io/release/v1.27.0/bin/linux/amd64/kubectl" &&
chmod +x ./kubectl &&
sudo mv ./kubectl /usr/local/bin/kubectl

# Configure kubectl
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER ~/.kube/config
sudo chmod 600 ~/.kube/config

export KUBECONFIG=~/.kube/config

# Create directory for systemd service override
sudo mkdir -p /etc/systemd/system/k3s.service.d

sudo tee /etc/systemd/system/k3s.service.d/override.conf > /dev/null <<EOF
[Service]
ExecStart=
ExecStart=/usr/local/bin/k3s server --node-ip=192.168.56.110
EOF

sudo systemctl daemon-reload
sudo systemctl restart k3s
