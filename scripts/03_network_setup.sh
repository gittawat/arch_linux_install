#!/bin/bash
network_packages=(
	'iptables-nft'
	'networkmanager'
	'network-manager-applet'
	'iwd'
	'wireless_tools'
	'smartmontools'
	'wpa_supplicant'
	'firewalld'
	'inetutils'
)
pacman --noconfirm -S "${network_packages[@]}"
systemctl enable NetworkManager
systemctl enable firewalld
