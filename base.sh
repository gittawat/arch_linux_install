#!/bin/bash

echo "Enter hostname:"
read inputHostname
echo "Enter username:"
read inputUsername 

echo "Enter password:"
read -s password
echo

echo "Re-enter password:"
read -s re_password
echo

# Compare passwords
if [ "$password" = "$re_password" ]; then
    echo "Passwords match!"
    # Now you can use $password1 for further processing
else
    echo "Passwords do not match. Please try again."
    exit 1
fi


cat << EOF > /etc/mkinitcpio.conf
MODULES=()
BINARIES=()
COMPRESSION="zstd"
#FILES=(/crypto_keyfile.bin)
HOOKS=(base udev autodetect keyboard keymap modconf block encrypt filesystems fsck)
EOF

mkinitcpio -p linux

echo "en_SG.UTF-8 UTF-8" > /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf
echo "$inputHostname" > /etc/hostname
echo "127.0.0.1 localhost" > /etc/hosts
echo "::1       localhost" >> /etc/hosts
#echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
hwclock --systohc
locale-gen



pacman -S efibootmgr networkmanager network-manager-applet dialog wpa_supplicant base-devel linux-headers avahi xdg-user-dirs inetutils bluez cups alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack openssh rsync reflector virt-manager qemu-desktop edk2-ovmf bridge-utils dnsmasq vde2 iptables-nft firewalld flatpak sof-firmware nss-mdns


systemctl enable NetworkManager
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld

#echo root:password | chpasswd

useradd -m $inputUsername
echo $inputUsername:password | chpasswd
usermod -a -G wheel $inputUsername
usermod -a -G uucp $inputUsername
usermod -a -G libvirt $inputUsername

echo "gttwt ALL=(ALL) ALL" >> /etc/sudoers.d/00_gttwt

printf "\e[1;32m base installation Done!\e[0m\n"
