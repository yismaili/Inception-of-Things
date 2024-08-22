#!/usr/bin/env bash

SERVER_IP="192.168.56.110"

sudo apt-get update -y
sudo apt-get install -y curl

# Install k3s and set IP address
sudo curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --node-ip "$SERVER_IP"

# Install Docker
# sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
# curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" |
# sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get install -y docker.io

sudo usermod -aG docker ${USER}
su - ${USER}
id -nG

# Check Docker status
sudo systemctl status docker --no-pager
