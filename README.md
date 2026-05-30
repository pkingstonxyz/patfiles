# patfiles, or, Patrick's dotfiles

My dotfiles, intended for use with gnu stow, and with guix!

TODO:

| sym | meaning |
| --- | ------- |
| [ ] | not done |
| [~] | working, but unstyled |
| [+] | done |

- [~] - zsh
- [~] - sway
  - [+] - waybar
  - [~] - wofi
  - [~] - mako
  - [+] - grim/slurp
  - [ ] - background
  - [+] - Waybar clock  # TODO: make it look fancier
- [+] - kitty
- [+] - neovim
- [~] - wlgreet/greetd
- [~] - emacs

| program   | file           | tested on |
| -------   | ----           | --------- |
| zsh       | .zshrc         | guix      |
| zsh       | .zprofile      | ^         |
| sway      | config         | guix      |
| waybar    | config.jsonc   | guix      |
| waybar    | styles.css     | guix      |
| waybar    | scripts/analog_clock.sh   | guix |
| fastfetch | config.jsonc   | only guix |
| emacs     | init.el        | guix, fedora |
| emacs-stow* | init.el        | guix, fedora |


# Intended packages

These dotfiles assume you're using:

- zsh
- neovim
- kitty
- sway
- waybar
- wofi
- mako
- grim/slurp
- wlgreet/greetd
- emacs

# Notes

The emacs-stow thing is, I admit, pretty hacky. I'm shocked there's no way home-emacs-service-type on guix where I can just hand it a file the way zsh is, but whatever.  The way it is *now* is that guix manages emacs and puts the early-init.el in.  Then, it runs a stow service to properly stow the *real* emacs file
