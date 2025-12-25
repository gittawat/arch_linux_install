audio_packages=(
	'sof-firmware'
	'alsa-utils'
	'pipewire'
	'pipewire-alsa'
	'pipewire-pulse'
	'pipewire-jack'
	'gst-plugin-pipewire'
	'libpulse wireplumber'
)

pacman --noconfirm -S "${audio_packages[@]}"
