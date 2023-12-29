#!/usr/bin/env bash

# Exit on error
set -e

# Enable passwordless SSH
# mkdir -p ~/.ssh
# chmod 700 ~/.ssh
# ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""
# cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
# chmod 600 ~/.ssh/authorized_keys

# Update package and upgrade list
sudo apt-get update -y
sudo apt-get upgrade -y

# Install curl and wget
sudo apt-get install -y curl wget

# Install K3s
# curl -sfL https://get.k3s.io | sh -s - --flannel-iface eth1

# curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="--flannel-iface eth1" sh -

# sleep 20

sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo mkdir ~/.kube/
sudo cp -r /shared/confs/kubeconfig ~/.kube/config
sudo cp -r ~/.kube /home/vagrant/
sudo chown -R vagrant:vagrant /home/vagrant/.kube/
# Check K3s status
sudo systemctl status k3s

# Configure Kubectl
# mkdir -p ~/.kube
# sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
# sudo chown $USER ~/.kube/config
# sudo chmod 600 ~/.kube/config
# export KUBECONFIG=~/.kube/config

# # Create a swap file (adjust the size as needed)
# sudo fallocate -l 2G /swapfile

# # Set up the swap file
# sudo chmod 600 /swapfile
# sudo mkswap /swapfile
# sudo swapon /swapfile

# # Make the change permanent by adding an entry to /etc/fstab
# echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Install Docker
# sudo apt-get update -y
# sudo apt-get upgrade -y
sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

sudo apt update
sudo apt-cache policy docker-ce
sudo apt install -y docker-ce
sudo systemctl status docker

