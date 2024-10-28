#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Run this script with root"
  exit
fi

sudo pacman -S --noconfirm hyprland ly kitty git firefox

config_file="$HOME/.config/hypr/hyprland.conf"

if [ -f "$config_file" ]; then
  sed -i '8d' "$config_file"
else
  echo "Config file $config_file not found."
fi

sudo systemctl --now enable ly.service
