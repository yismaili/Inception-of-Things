#!/bin/bash

set -ex 

sudo apt-get update -y
sudo apt install curl

# Install Docker
sudo apt-get install -y docker.io
sudo usermod -aG docker ${USER}

# Install k3s and K3d
curl -sfL https://get.k3s.io | sh - 
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | sh
