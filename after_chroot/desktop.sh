#!/bin/bash

pacman -S --noconfirm plasma-meta zsh konsole kwrite dolphin ark plasma-wayland-session egl-wayland
pacman -S --noconfirm xorg-server xorg-xinit nvidia-dkms dkms
pacman -S --noconfirm sddm
systemctl enable sddm
