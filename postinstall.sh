#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Run this script with root"
  exit
fi

sudo pacman -S --noconfirm hyprland ly kitty git firefox
sudo pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-firacode-nerd
sudo fc-cache -fv

sudo systemctl --now enable ly.service
