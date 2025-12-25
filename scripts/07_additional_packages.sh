
additional=('rsync'
	'reflector'
	'sbctl'
	'efibootmgr'
	'neovim'
	'firefox'
	'zsh'
	'grml-zsh-config'
)
pacman --noconfirm -S "${additional[@]}"
