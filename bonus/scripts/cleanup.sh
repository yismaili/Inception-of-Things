#!/bin/bash

kubectl delete namespace dev
kubectl delete namespace argocd
sudo rm -f /usr/local/bin/kubectl

k3d cluster list
k3d cluster delete wil42
sudo rm /usr/local/bin/k3d
rm -rf ~/.k3d

docker images | grep k3d | awk '{print $3}' | xargs docker rmi
docker volume prune -y
docker network prune -y
which k3d

sudo apt-get update 
sudo apt-get remove --purge docker.io
sudo apt-get autoremove
sudo rm -rf /var/lib/docker
docker --version