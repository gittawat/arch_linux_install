additional=('rsync'
	'reflector'
	'sbctl'
	'efibootmgr'
	'neovim'
	'firefox'
	'zsh'
	'grml-zsh-config'
	'reflector'
)
pacman --noconfirm -S "${additional[@]}"
systemctl enable reflector.timer
