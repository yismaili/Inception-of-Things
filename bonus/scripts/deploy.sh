#!/bin/bash

set -ex 

sudo apt-get update -y
k3d cluster create wil42

kubectl create namespace argocd
kubectl create namespace dev
kubectl create namespace gitlab

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

while [[ $(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath="{.items[0].status.phase}") != "Running" ]]; do
    echo "Waiting for argocd-server pod to be ready..."
    sleep 10
done

kubectl apply -f ../confs/gitlab-deployment.yaml
kubectl apply -f ../confs/gitlab-service.yaml
# kubectl port-forward --address 0.0.0.0 svc/gitlab-service -n gitlab 8081:80

kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d >> password.txt
# kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
# kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:80