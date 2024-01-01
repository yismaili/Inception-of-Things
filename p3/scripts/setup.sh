#!/usr/bin/env bash

# Update package and upgrade list
sudo apt-get update -y
sudo apt-get upgrade -y

# Install curl and wget
sudo apt-get install -y curl wget

#install docker
sudo apt install -y docker.io

# start and enable docker
sudo systemctl start docker
sudo systemctl enable docker

#install k3d using the script
sudo wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
sudo k3d --version

# Create a Kubernetes cluster with k3d
sudo k3d cluster create master-cluster



