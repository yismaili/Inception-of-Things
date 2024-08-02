# #!/usr/bin/env bash

SERVER_IP="192.168.56.110"

sudo apt-get update -y
sudo apt-get install -y curl

curl -sfL https://get.k3s.io | K3S_URL=http://$SERVER_IP:6443 K3S_TOKEN=$(ssh -o StrictHostKeyChecking=no vagrant@$SERVER_IP sudo cat /var/lib/rancher/k3s/server/node-token) sh -

# curl -LO "https://dl.k8s.io/release/v1.27.0/bin/linux/amd64/kubectl"
# sleep 20
# chmod +x ./kubectl
# sudo mv ./kubectl /usr/local/bin/kubectl

# Download and install kubectl
echo "Downloading and installing kubectl..."
curl -LO "https://dl.k8s.io/release/v1.27.0/bin/linux/amd64/kubectl"
if [ $? -ne 0 ]; then
    echo "Failed to download kubectl. Exiting..."
    exit 1
fi

chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
if [ $? -ne 0 ]; then
    echo "Failed to move kubectl to /usr/local/bin. Exiting..."
    exit 1
fi
echo "k3s and kubectl installation complete."
