#!/usr/bin/env bash

# Enable passwordless SSH
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# Update package  and upgrade list
sudo apt-get update -y
sudo apt upgrade -y

# innstall curl wget 
sudo apt install -y curl wget

# install k3s

curl -sfL https://get.k3s.io | sh –

sudo systemctl status k3s

# Configure Kubectl

mkdir ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config && sudo chown $USER ~/.kube/config
sudo chmod 600 ~/.kube/config && export KUBECONFIG=~/.kube/config





