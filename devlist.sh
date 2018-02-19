#!/usr/bin/env bash

declare -A DEV_DISKS
ddi=0
DEV_DISK_DIR="/dev/disk/by-id"
for i in $( ls $DEV_DISK_DIR);
do
    if [[ $i =~ ST3000DM|Hitachi_HDS5C ]]; then
        DEV_DISK_POSTFIX=$(ls -la ${DEV_DISK_DIR}/$i | awk -F"${DEV_DISK_DIR}/$i -> ../../" '{print $2}')
        if [[ $DEV_DISK_POSTFIX =~ [^0-9]$ ]]; then
            echo "Setup block device for: $i"
            DEV_DISKS[$ddi]=${DEV_DISK_DIR}/$i
            ((ddi++))
        fi
    fi
done

NUM_DDs=${#DEV_DISKS[@]}
echo $NUM_DDs
ind=0
for i in $(seq 1 $NUM_DDs);
do
	DDi=$ind
    DEV_DISK_POSTFIX=$(ls -la ${DEV_DISKS[$DDi]} | awk -F"${DEV_DISKS[$DDi]} -> ../../" '{print $2}')
	   echo ${DEV_DISK_POSTFIX:(-2)}
           echo "Setup block device for: ${DEV_DISKS[$DDi]}"
           echo $DEV_DISK_POSTFIX
#echo "
#p
#o
#p
#w
#" | fdisk /dev/`echo $DEV_DISK_POSTFIX` || exit 1
	((ind++))
done
