#!/bin/bash

set -ex 
sudo apt-get update -y
k3d cluster create wil42

kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

while [[ $(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath="{.items[0].status.phase}") != "Running" ]]; do
    echo "Waiting for argocd-server pod to be ready..."
    sleep 10
done

kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d > password.txt
kubectl apply -f ../confs/argocd-app.yaml
# kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl port-forward svc/argocd-server -n argocd 8080:443