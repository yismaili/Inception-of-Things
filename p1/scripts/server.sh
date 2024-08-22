#!/usr/bin/env bash

SERVER_IP="192.168.56.110"

sudo apt-get update
sudo apt-get install -y curl

# Install K3s Server
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --node-ip "$SERVER_IP"

sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/k3s_token.txt
