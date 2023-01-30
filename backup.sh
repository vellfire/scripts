#!/bin/bash

# Variables
BACKUPDIR=/mnt/backups
IMAGEDIR=/mnt/mx500_raid1/libvirt/images
PHOSTNAME=$(hostnamectl status | grep -w "Pretty hostname:" | awk '{print $3}')
CDATE=$(date +"%Y%m%dT%H%M")

state () {
    JOBSTATE=$(virsh domjobinfo "${VM}" | grep -w "Job type:" | awk '{print $3}')
}

for VM in $(virsh list --all --name); do

if [ ! -d "$BACKUPDIR/$PHOSTNAME/$VM" ]; then
    mkdir -p "$BACKUPDIR/$PHOSTNAME/$VM"
fi

done

for VM in $(virsh list --all --name); do
JOBSTATE=$(virsh domjobinfo "${VM}" | grep -w "Job type:" | awk '{print $3}') 
if [ "$JOBSTATE" == "None" ];  then
    unset UT
    virsh dumpxml "${VM}" > "$BACKUPDIR/$PHOSTNAME/${VM}/${VM}_${CDATE}.xml";
    export UT=$(date +%s); virsh backup-begin "${VM}"
    sleep 3
    state
    while [ "$JOBSTATE" == "Unbounded" ]; do
        sleep 5
        state
    done
    mv $IMAGEDIR/"${VM}.qcow2.${UT}" "$BACKUPDIR/$PHOSTNAME/${VM}/${VM}_${CDATE}.qcow2"
elif [ ! -f "$IMAGEDIR/${VM}.qcow2" ]; then
    virsh dumpxml "${VM}" > "$BACKUPDIR/$PHOSTNAME/${VM}/${VM}_${CDATE}.xml"
fi
done