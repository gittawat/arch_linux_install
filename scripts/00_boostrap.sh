#!/bin/bash
set -e
hostname=$(cat /etc/hostname)
#hostname="archiso"
if [ "$hostname" = "archiso" ]; then 
	reflector -c TH,SG --sort rate --save /etc/pacman.d/mirrorlist
else
	echo "please run this on official archiso"
	exit 1
fi

if mountpoint -q /mnt; then
	echo "/mnt/ is currently a mountpoint"
else
	echo "/mnt/ is not yet a mountpoint"
	echo "exiting now"
	exit 1
fi

pacstrap -C /etc/pacman.conf -K /mnt \
	base \
	base-devel \
	linux-lts \
	linux-lts-headers\
	linux-firmware \
	amd-ucode \
	--noconfirm

genfstab -U /mnt >> /mnt/etc/fstab
#mkdir /mnt/efi/EFI
#mkdir /mnt/efi/EFI/Linux #default_uki="/efi/EFI/Linux/arch-linux-lts.efi"

cp -r ./ /mnt/root/
