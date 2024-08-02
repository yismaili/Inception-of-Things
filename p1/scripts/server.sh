#!/usr/bin/env bash
sudo apt-get update -y
sudo apt-get install -y curl scurl

curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644

# scurl -LO "https://dl.k8s.io/release/v1.27.0/bin/linux/amd64/kubectl"
# sleep 20
# chmod +x ./kubectl
# sudo mv ./kubectl /usr/local/bin/kubectl

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
