#!/bin/bash
## Designed for use with https://github.com/abbbi/virtnbdbackup
# Variables
BACKUP_DIR=/mnt/hd0/backups
CURRENT_DATE=$(date +%Y-%m-%d)
SYSTEM_HOSTNAME=$(hostname)

# Functions
system_hostname () {
    hostnamectl status --static
}

current_month () {
    date +%Y-%m
}


for VM in $(virsh list --all --name); do
    if [ ! -d "$BACKUPDIR/$(hostname)/$VM/$(current_month)" ]; then
        mkdir -p "$BACKUPDIR/$(hostname)/$VM/$(current_month)"
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



