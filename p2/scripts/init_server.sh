#!/bin/bash

err_message() {
  local RED="\033[32m"
  local RESET="\033[0m"
  echo -e "${RED}$1${RESET}"
  exit 1
}

sucsess_message() {
  local GREEN="\033[32m"
  local RESET="\033[0m"
  echo -e "${GREEN}$1${RESET}"
}

sucsess_message "INFO: RUNNING P2 SERVER CONFIG SCRIPT"

if export INSTALL_K3S_EXEC="--node-external-ip=192.168.56.110 --bind-address=192.168.56.110 --flannel-iface=eth1"; then
  sucsess_message "INSTALL_K3S_EXEC env set successfully"
else
  err_message "Error: Can't set INSTALL_K3S_EXEC env"
fi


if curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644; then
  sucsess_message "Successfully installed k3s server"
else
  err_message "Error: Failed to install k3s server"
fi

if kubectl apply -f /vagrant/confs/app1/config.yaml; then
  sucsess_message "app1 deployed"
else
  err_message "Error: Failed deploy app1"
fi

if kubectl apply -f /vagrant/confs/app2/config.yaml; then
  sucsess_message "app2 deployed"
else
  err_message "Error: Failed deploy app2"
fi

if kubectl apply -f /vagrant/confs/app3/config.yaml; then
  sucsess_message "app3 deployed"
else
  err_message "Error: Failed deploy app3"
fi
