PROMPT='%F{magenta}%n@%m %~ %# %f'

if [ -d /etc/guix ]; then
	export GBM_BACKEND=nvidia-drm
	export __GLX_VENDOR_LIBRARY_NAME=nvidia
  export CC=gcc
  alias ls='ls --ignore *-guix-home-legacy-configs-backup --color=auto'
fi
