#!/bin/bash

# Variables
BACKUPDIR=/mnt/backups
IMAGEDIR=/mnt/mx500_raid1/libvirt/images

## Functions
# Full VM backup for VMs with virtual disks
full_backup () {
    virsh dumpxml $VM > $BACKUPDIR/$HOSTNAME/$VM/$VM_$(date +"%Y-%m-%d").xml
    zstd -z -10 -T0 $IMAGEDIR/$VM.qcow2 -o $BACKUPDIR/$HOSTNAME/$VM/$VM_$(date +"%Y-%m-%d").zst
}
dom_backup () {
    virsh dumpxml $VM > $BACKUPDIR/$HOSTNAME/$VM/$VM_$(date +"%Y-%m-%d").xml
}

## Prerequisite
# Check if directory does not exist then create it


for VM in $(virsh list --all --name); do

if [ ! -d "$BACKUPDIR/$HOSTNAME/$VM" ]; then
    mkdir -p $BACKUPDIR/$HOSTNAME/$VM
fi

done

for VM in $(virsh list --all --name); do
STATE=$(virsh dominfo $VM | grep -w "State:" | awk '{ print $2}')
if [ $STATE == "shut" ]; then
    full_backup
elif [ ! -f "$IMAGEDIR/$VM.qcow2" ]; then
    dom_backup
else
    echo shutdown
    virsh shutdown $VM
    while ([ "$STATE" != "" ] && [ "$STATE" == "running" ]); do
        sleep 10
        STATE=$(virsh dominfo $VM | grep -w "State:" | awk '{ print $2}')
    done;
    full_backup
    virsh start $VM
fi
done
