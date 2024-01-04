#!/usr/bin/env bash

# Update package and upgrade list
sudo apt-get update -y
sudo apt-get upgrade -y

# Install curl and wget
sudo apt-get install -y curl wget

# Install Docker
sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" |
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Check Docker status
sudo systemctl status docker

# install kubectl
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

#install k3d 
sudo wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Create a Kubernetes cluster with k3d
sudo k3d cluster create master-cluster -p "8888:3000"

# create namespaces
sudo kubectl create namespace argocd
sudo kubectl create namespace dev

# setup argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

watch kubectl get pods -n argocd

sudo kubectl port-forward svc/argocd-server -n argocd 8080:443

