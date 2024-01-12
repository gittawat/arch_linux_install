#!/bin/bash

reflector -c TH,SG --save /etc/pacman.d/mirrorlist

if mountpoint -q /mnt; then
	echo "/mnt/ is currently a mountpoint"
else
	echo "/mnt/ is not yet a mountpoint"
	echo "exiting now"
	exit 1
fi

pacstrap -C /etc/pacman.conf -K /mnt \
	base \
	linux \
	linux-firmware \
	intel-ucode \
	--noconfirm

genfstab -U /mnt > /mnt/etc/fstab


#chroot /mnt /bin/bash -c "mkinitcpio -p linux"
cp -r ./after_chroot/ /mnt/root/
