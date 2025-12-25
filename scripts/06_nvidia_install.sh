
nvidia_open_packages=(
	'xorg-server'
	'xorg-xinit'
	'nvidia-open-dkms'
	'dkms'
	'libva-nvidia-driver'
)
pacman --noconfirm -S "${nvidia_open_packages[@]}"
