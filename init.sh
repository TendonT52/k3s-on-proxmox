CONTROLLER="192.168.0.210"
WORKER="192.168.0.211"
POD_CIDR="10.10.0.0/16"
SSH_CERT="proxmox"
USER="tendon"
NETWORK_INTERFACE="eth0"

k3sup install \
  --ip $CONTROLLER \
  --user $USER \
  --cluster \
  --sudo \
  --k3s-extra-args "--flannel-iface=$NETWORK_INTERFACE --node-ip=$CONTROLLER --cluster-cidr=$POD_CIDR" \
  --ssh-key $HOME/.ssh/$SSH_CERT \
  --local-path $HOME/.kube/config \
  --context k3s-proxmox

echo -e " \033[32;5mController node bootstrapped successfully!\033[0m"

k3sup join \
  --ip $WORKER \
  --user $USER \
  --sudo \
  --server-ip $CONTROLLER \
  --ssh-key $HOME/.ssh/$SSH_CERT

echo -e " \033[32;5mWorker node joined successfully!\033[0m"