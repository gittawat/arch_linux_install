#!/bin/bash
set -e

cat << EOF > /etc/mkinitcpio.conf
# vim:set ft=sh:
MODULES=()
BINARIES=()
FILES=()
HOOKS=(base systemd autodetect microcode modconf kms keyboard keymap sd-vconsole sd-encrypt block filesystems fsck)
EOF

cat << EOF > /etc/mkinitcpio.d/linux-lts.preset
# mkinitcpio preset file for the 'linux-lts' package

#ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/boot/vmlinuz-linux-lts"
#ALL_kerneldest="/boot/vmlinuz-linux-lts"

PRESETS=('default')
#PRESETS=('default' 'fallback')

#default_config="/etc/mkinitcpio.conf"
default_image="/boot/initramfs-linux-lts.img"
default_uki="/efi/EFI/Linux/arch-linux-lts.efi"
#default_options="--splash /usr/share/systemd/bootctl/splash-arch.bmp"

#fallback_config="/etc/mkinitcpio.conf"
#fallback_image="/boot/initramfs-linux-lts-fallback.img"
#fallback_uki="/efi/EFI/Linux/arch-linux-lts-fallback.efi"
#fallback_options="-S autodetect"
EOF

cat << EOF > /etc/kernel/cmdline
root=/dev/mapper/unlocked_root rootfstype=ext4 rw
EOF


#Example: unlocked_root UUID=b3202184-c4fa-4ea3-8112-72ac1431c400 none timeout=180,no-read-workqueue,no-write-workqueue
# findmnt -n -o UUID /
cat << EOF > /etc/crypttab.initramfs
unlocked_root UUID=$(findmnt -n -o UUID /) none timeout=180,no-read-workqueue,no-write-workqueue
EOF

mkdir /efi/EFI
mkdir /efi/EFI/Linux #default_uki="/efi/EFI/Linux/arch-linux-lts.efi"

mkinitcpio -P
