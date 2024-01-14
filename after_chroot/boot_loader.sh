#!/bin/bash

# Check if an argument is provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <device_path>"
    exit 1
fi

printf "\e[1;32m installing boot loader\e[0m\n"
bootctl install --esp-path=/efi

cryptDevPath="$1"

echo "You entered: $cryptDevPath"


# Extract PARTUUID using awk
cryptroot_uuid=$(blkid -s UUID -o value $cryptDevPath)

# Print the extracted PARTUUID
echo "UUID: $cryptroot_uuid"


#initrd=\intel-ucode.img initrd=\initramfs-linux.img cryptdevice=PARTUUID=$root_partuuid:luksdev root=/dev/mapper/luksdev rootflags=subvol=@root,rw rootfstype=btrfs
cat << EOF > /etc/kernel/cmdline
initrd=\intel-ucode.img initrd=\initramfs-linux.img rd.luks.uuid=$cryptroot_uuid:decryptroot root=/dev/mapper/luksdev rootflags=subvol=@root,rw rootfstype=btrfs
EOF

sbctl bundle \
	--cmdline /etc/kernel/cmdline \
	--esp /efi \
	--initramfs /boot/initramfs-linux.img \
	--kernel-img /boot/vmlinuz-linux \
	--save /efi/EFI/Linux/archlinux-kernel-latest.efi
