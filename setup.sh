USER="tendon"
WORKER="192.168.0.211"
SSH_CERT="proxmox"
COMMANDS="
devices=(\"vda\" \"vdb\" \"vdc\");
for device in \${devices[@]};
do
  sudo mkfs -t ext4 /dev/\${device};
  sudo mkdir -p /mnt/\${device};
  sudo mount -t ext4 /dev/\${device} /mnt/\${device};
  echo \"/dev/\${device} /mnt/\${device} ext4 defaults 0 0\" | sudo tee -a /etc/fstab;
done
"

trap "kill 0" SIGINT
ssh -o StrictHostKeyChecking=no -i $HOME/.ssh/$SSH_CERT ${USER}@${WORKER} "${COMMANDS}" &
wait