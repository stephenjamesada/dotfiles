#!/bin/sh

if [[ $EUID -ne 0 ]]; then
    echo "Run $0 with sudo to use."
    exit 1
fi

# Installing Programs (excluding externally managed applications)
# ex. by pip, cargo, homebrew, etc.
apt-get install -y vim kitty git gh fish mako sway tmux waybar wofi

# Stowing
stow fish gh git kitty mako scripts sway tmux vim waybar wofi
