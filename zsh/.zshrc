PROMPT='%F{magenta}%n@%m %~ %# %f'

if [ -d /etc/guix ]; then
	export GBM_BACKEND=nvidia-drm
	export __GLX_VENDOR_LIBRARY_NAME=nvidia
  export CC=gcc
  alias ls='ls --ignore *-guix-home-legacy-configs-backup --color=auto'
fi

# Ansible test shell debug mode
alias atsd='PYTHONPATH="$PWD/lib:$PWD/test/lib:$PWD" python -m debugpy --connect 5678 "$(which ansible-test)" shell --dev-debug-on-demand'

# Make emacs client easier
alias ec=emacsclient

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec sway --unsupported-gpu
fi

