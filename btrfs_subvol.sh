#!/bin/bash

# Check if an argument is provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <device_path>"
    exit 1
fi

devPath="$1"
if mount -t btrfs $devPath /mnt; then
	echo "$devPath is mounted"
else
	echo "cannot mount $devPath"
	exit 1
fi

btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
umount -R /mnt
mount -t btrfs -o defaults,x-mount.mkdir,compress=zstd,ssd,noatime,subvol=@root $devPath /mnt
mount -t btrfs -o defaults,x-mount.mkdir,compress=zstd,ssd,noatime,subvol=@home $devPath /mnt/home
mount -t btrfs -o defaults,x-mount.mkdir,compress=zstd,ssd,noatime,subvol=@snapshots $devPath /mnt/snapshot
mount -t vfat -o  x-mount.mkdir,rw,relatime,fmask=0077,dmask=0077 LABEL=USB_EFI /mnt/efi 
