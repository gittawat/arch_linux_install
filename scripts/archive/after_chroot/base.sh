#!/bin/bash
set -e

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
else
    echo "Passwords do not match. Please try again."
    exit 1
fi

echo "en_SG.UTF-8 UTF-8" > /etc/locale.gen
echo "LANG=en_SG.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf
echo "$inputHostname" > /etc/hostname
echo "127.0.0.1 localhost" > /etc/hosts
echo "::1       localhost" >> /etc/hosts
#echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
locale-gen
chmod 700 /root
systemctl enable systemd-timesyncd

cat << EOF > /etc/mkinitcpio.conf
MODULES=()
BINARIES=()
COMPRESSION="zstd"
#FILES=(/crypto_keyfile.bin)
HOOKS=(base systemd autodetect keyboard keymap modconf block sd-encrypt btrfs filesystems fsck)
EOF

mkinitcpio -P

pacman -S --noconfirm sbctl efibootmgr 
pacman -S --noconfirm linux-headers git dialog base-devel 

pacman -S --noconfirm \
	networkmanager \
	network-manager-applet \
	openssh \
	htop \
	wget \
	iwd \
	wireless_tools \
	smartmontools \
	wpa_supplicant \
	firewalld \
	rsync \
	reflector \
	inetutils \
	nss-mdns

pacman -S --noconfirm alsa-utils \
	pipewire pipewire-alsa \
	pipewire-pulse pipewire-jack \
	sof-firmware gst-plugin-pipewire \
	libpulse wireplumber

pacman -S --noconfirm xdg-utils neovim firefox

#echo root:password | chpasswd

useradd -m -G wheel $inputUsername
echo $inputUsername:$password | chpasswd
usermod -a -G uucp $inputUsername
#usermod -a -G libvirt $inputUsername

systemctl enable NetworkManager
systemctl enable reflector.timer
systemctl enable fstrim.timer
#systemctl enable libvirtd
systemctl enable firewalld
su - $inputUsername -c "systemctl enable --user pipewire-pulse.service"

echo "$inputUsername ALL=(ALL) ALL" > /etc/sudoers.d/00_$inputUsername

printf "\e[1;32mbase installation Done!\e[0m\n"
