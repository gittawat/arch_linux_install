#!/bin/bash

if mountpoint -q /mnt; then
	echo "/mnt/ is currently a mountpoint"
else
	echo "/mnt/ is not yet a mountpoint"
	echo "exiting now"
	exit 1
fi
pacstrap /mnt base linux linux-firmware git neovim intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab

#chroot /mnt /bin/bash -c "mkinitcpio -p linux"
cp ./base.sh /mnt/root/
cp ./boot_loader.sh /mnt/root/
