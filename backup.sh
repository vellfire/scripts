#!/bin/bash

## Designed for use with https://github.com/abbbi/virtnbdbackup

# Variables
BACKUP_DIR=/mnt/hd0/backups
CURRENT_MONTH=$(date +%Y-%m)
VM_LIST=$(virsh list --all --name)
EXCLUDE_LIST=(
    "Deb-Sid"
    "Deb-Testing"
    "SSG"
    "SSG-Deb"
)

VM_BACKUP_LIST=$(echo "$VM_LIST" | grep -vE "$(IFS="|"; echo "${EXCLUDE_LIST[*]}")")

for VM in $VM_BACKUP_LIST; do
    mkdir -p "$BACKUP_DIR/$HOSTNAME/$VM/$CURRENT_MONTH"
    virtnbdbackup -d "$VM" -l auto -o "$BACKUP_DIR/$HOSTNAME/$VM/$CURRENT_MONTH" -z
done