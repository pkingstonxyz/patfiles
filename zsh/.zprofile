# Setup terminal
export TERMINAL=kitty

# For sourcing and updating guix profile after pull and upgrade
if [ -f "$HOME/.guix-profile/etc/profile" ]; then
	GUIX_PROFILE="$HOME/.guix-profile"
	. "$HOME/.guix-profile/etc/profile"
fi
if [ -f "$HOME/.config/guix/current/etc/profile" ]; then
	. "$HOME/.config/guix/current/etc/profile"
fi

