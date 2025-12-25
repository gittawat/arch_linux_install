desktop_packages=(
	'noto-fonts'
	'plasma-meta'
	'konsole'
	'kate'
	'dolphin'
	'ark'
	'plasma-workspace'
	'xdg-utils'
	'sddm'
)
pacman --noconfirm -S "${desktop_packages[@]}"
systemctl enable sddm
