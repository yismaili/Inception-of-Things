#!/usr/bin/env bash

SERVER_IP="192.168.56.110"

sudo apt-get update -y
sudo apt-get install -y curl

curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --node-ip "$SERVER_IP"

# Configure kubectl
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER ~/.kube/config
sudo chmod 600 ~/.kube/config

export KUBECONFIG=~/.kube/config
