cat << EOF > /etc/X11/xorg.conf.d/20-nvidia.conf
Section "ServerLayout"
    Identifier "layout"
    Screen 0 "nvidia"
    Inactive "intel"
EndSection

Section "Device"
    Identifier "nvidia"
    Driver "nvidia"
    BusID "PCI:1:0:0"
EndSection

Section "Screen"
    Identifier "nvidia"
    Device "nvidia"
    Option "AllowEmptyInitialConfiguration"
EndSection

Section "Device"
    Identifier "intel"
    Driver "modesetting"
    BusID "PCI:0:2:0"
EndSection

Section "Screen"
    Identifier "intel"
    Device "intel"
EndSection
EOF

cat << EOF > /usr/share/sddm/scripts/Xsetup
#!/bin/sh
# Xsetup - run as root before the login dialog appears
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
EOF
