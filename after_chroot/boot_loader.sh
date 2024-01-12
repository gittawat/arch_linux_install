#!/bin/bash

# Check if an argument is provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

printf "\e[1;32m installing boot loader\e[0m\n"
bootctl install --esp-path=/efi

devPath="$1"

echo "You entered: $devPath"


# Run blkid and store the output in a variable
blkid_output=$(blkid $devPath)

# Extract PARTUUID using awk
root_partuuid=$(echo "$blkid_output" | awk -F'PARTUUID=' '{print $2}' | awk -F'"' '{print $2}')

# Print the extracted PARTUUID
echo "PARTUUID: $root_partuuid"

cat << EOF > /etc/kernel/cmdline
initrd=\intel-ucode.img initrd=\initramfs-linux.img cryptdevice=PARTUUID=$root_partuuid:luksdev root=/dev/mapper/luksdev rw  rootfstype=ext4
EOF

sbctl bundle --cmdline /etc/kernel/cmdline --esp /efi --initramfs /boot/initramfs-linux.img --kernel-img /boot/vmlinuz-linux --save /efi/EFI/Linux/archlinux-kernel-latest.efi
