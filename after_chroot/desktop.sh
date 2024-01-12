#!/bin/bash

#reflector -c TH,SG --save /mnt/etc/pacman.d/mirrorlist

#timedatectl set-ntp true
#hwclock --systohc

pacman -S --noconfirm plasma-meta zsh konsole kwrite dolphin ark plasma-wayland-session egl-wayland
pacman -S --noconfirm xorg-server xorg-xinit nvidia-dkms dkms
pacman -S --noconfirm sddm
systemctl enable sddm
