#!/usr/bin/env bash

SERVER_IP="192.168.56.110"

sudo apt-get update -y
sudo apt-get install -y curl

sudo curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --node-ip "$SERVER_IP"

# Install Docker
sudo apt-get install -y docker.io

sudo usermod -aG docker ${USER}
su - ${USER}

