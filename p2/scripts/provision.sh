#!/usr/bin/env bash

# Enable passwordless SSH
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# Update package and upgrade list
sudo apt-get update -y
sudo apt-get upgrade -y

# Install curl and wget
sudo apt-get install -y curl wget

# Install K3s
curl -sfL https://get.k3s.io | sh -

# Check K3s status
sudo systemctl status k3s

# Configure Kubectl
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER ~/.kube/config
sudo chmod 600 ~/.kube/config
export KUBECONFIG=~/.kube/config

# install docker 

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

sudo apt update
sudo apt-cache policy docker-ce
sudo apt install docker-ce
sudo systemctl status docker


