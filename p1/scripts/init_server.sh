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

sucsess_message "INFO: RUNNING P1 SERVER CONFIG SCRIPT"

# --bind-address=192.168.56.110 sets the ip address the k3s will bind to for internal services
if export INSTALL_K3S_EXEC="--node-external-ip=192.168.56.110 --bind-address=192.168.56.110 --flannel-iface=eth1"; then
  sucsess_message "INSTALL_K3S_EXEC env set successfully"
else
  err_message "Error: Can't set INSTALL_K3S_EXEC env"
fi


if curl -sfL https://get.k3s.io | sh -; then
  sucsess_message "Successfully installed k3s server"
else
  err_message "Error: Failed to install k3s server"
fi


if sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/token.txt; then
  sucsess_message "Server token saved"
else
  err_message "Error: Failed to save server token"
fi




