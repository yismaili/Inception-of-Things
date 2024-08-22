#!/usr/bin/env bash
SERVER_IP="192.168.56.111"
K3S_SERVER_IP="192.168.56.110"

sudo apt-get update
sudo apt-get install -y curl

K3S_TOKEN=$(cat /vagrant/k3s_token.txt)

# Install K3s Agent
curl -sfL https://get.k3s.io | K3S_URL="https://$K3S_SERVER_IP:6443" K3S_TOKEN="$K3S_TOKEN" sh -s - --node-ip "$SERVER_IP"
