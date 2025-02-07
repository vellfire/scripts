#!/bin/bash

## Designed for use with https://github.com/abbbi/virtnbdbackup

# Variables
QEMU_URI="qemu:///system"
BACKUP_DIR=/mnt/hd0/backups
CURRENT_MONTH=$(date +%Y-%m)
VM_LIST=$(virsh -c $QEMU_URI list --all --name)
EXCLUDE_LIST=(
    "Deb-Sid"
    "Deb-Testing"
)
VM_BACKUP_LIST=$(echo "$VM_LIST" | grep -vE "$(IFS="|"; echo "${EXCLUDE_LIST[*]}")")

# Make directories and run backups
for VM in $VM_BACKUP_LIST; do
    mkdir -p $BACKUP_DIR/$HOSTNAME/$VM/$CURRENT_MONTH
    virtnbdbackup -U $QEMU_URI -d $VM -l auto -o $BACKUP_DIR/$HOSTNAME/$VM/$CURRENT_MONTH -z
done
