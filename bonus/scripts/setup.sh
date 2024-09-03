#!/bin/bash

set -ex 

sudo apt-get update -y
sudo apt install curl 

# Install Docker
sudo apt-get install -y docker.io
sudo usermod -aG docker ${USER}

# Install kubectl
curl -LO "https://dl.k8s.io/release/v1.27.0/bin/linux/amd64/kubectl" &&
chmod +x ./kubectl &&
sudo mv ./kubectl /usr/local/bin/kubectl

# Install k3d and kubectl
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash