#!/bin/bash
set -e

echo "Enter hostname:"
read -r inputHostname
echo "Enter username:"
read -r inputUsername 

echo "Enter password:"
read -s -r password
echo
echo "Re-enter password:"
read -s -r re_password
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

ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
locale-gen
chmod 700 /root # seem nesessary but i do not know where else to put this
systemctl enable systemd-timesyncd

useradd -m -G wheel "$inputUsername"
echo "$inputUsername":"$password" | chpasswd

echo "$inputUsername ALL=(ALL) ALL" > /etc/sudoers.d/00_"$inputUsername"
