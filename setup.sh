#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install \
  btop \
  micro \
  fastfetch \
  git \
  curl \
  fzf \
  lazygit

cp -r ../dotfiles/.config/micro/* ~/.config/micro
cp -r ../dotfiles/.config/fastfetch/ ~/.config/fastfetch
cp ../dotfiles/.bashrc ~
cp ../dotfiles/.gitconfig ~
