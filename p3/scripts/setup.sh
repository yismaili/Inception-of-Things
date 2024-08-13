#!/bin/bash

sudo apt-get update -y

# Install Docker
sudo apt-get install -y docker.io

sudo usermod -aG docker ${USER}
su - ${USER}
id -nG
# Install k3d
curl -sfL https://get.k3s.io | sh -
# Install kubectl

curl -LO "https://dl.k8s.io/release/v1.27.0/bin/linux/amd64/kubectl" &&
chmod +x ./kubectl &&
sudo mv ./kubectl /usr/local/bin/kubectl
# Create a K3D cluster
k3d cluster create mycluster
# Install K3D
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

echo "Installation complete!"

kubectl create namespace argocd
kubectl create namespace dev

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# Wait for the cluster to be ready
until sudo kubectl get nodes &> /dev/null; do
    echo "Waiting for the cluster to be ready..."
    sleep 5
done
# sleep 100
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d >> password.txt
kubectl port-forward svc/argocd-server -n argocd 8080:443

kubectl apply -f app.yaml

