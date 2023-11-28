

cd /var/lib/vz/template/iso/
wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
apt install libguestfs-tools -y
virt-customize -a noble-server-cloudimg-amd64.img --install qemu-guest-agent
qm create 9999 --memory 2048 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr0
qm importdisk 9999  noble-server-cloudimg-amd64.img local-lvm
qm set 9999 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9999-disk-0
qm set 9999 --scsi1 local-lvm:cloudinit
qm set 9999 --boot c --bootdisk scsi0
qm set 9999 --serial0 socket --vga serial0
qm template 9999