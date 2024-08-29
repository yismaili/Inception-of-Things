#!/bin/bash

# set -x

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

sucsess_message "INFO: RUNNING P1 WORKER CONFIG SCRIPT"

if export INSTALL_K3S_EXEC="agent --server https://192.168.56.110:6443 -t $(cat /vagrant/token.txt) --node-ip=192.168.56.111 --flannel-iface=eth1"; then
  sucsess_message "INSTALL_K3S_EXEC env set successfully"
else
  err_message "Error: Can't set INSTALL_K3S_EXEC env"
fi


if curl -sfL https://get.k3s.io | sh -; then
  sucsess_message "Successfully installed k3s worker"
else
  err_message "Error: Failed to install k3s worker"
fi

rm /vagrant/token.txt

# if systemctl enable --now k3s-agent; then
#   sucsess_message "Successfully enabled k3s-agent"
# else
#   err_message "Error: Failed to enable k3s-egent"
# fi

