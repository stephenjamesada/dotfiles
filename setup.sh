#!/bin/sh

if [[ $EUID -ne 0 ]]; then
    echo "Run $0 with sudo to use."
    exit 1
fi

# Stowing
stow fish gh git kitty mako scripts sway tmux vim waybar wofi
