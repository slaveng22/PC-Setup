#!/bin/bash

# Basics install
sudo apt update
sudo apt upgrade -y
sudo apt install \
  btop \
  micro \
  fastfetch \
  git \
  curl \
  wget \
  fzf \
  timeshift \
  flatpak \
  vlc \
  kdeconnect \
  thunderbird

# Install additional software
# Signal
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop

# Viber
wget -c https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
sudo dpkg -i viber.deb
rm viber.deb

# Fastfetch
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch

# TLP Battery optimization
sudo apt install tlp

# VSCodium
curl -fSsL https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscodium.gpg >/dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/vscodium.gpg] https://download.vscodium.com/debs vscodium main" | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update
sudo apt install codium

# DBeaver
sudo wget -O /usr/share/keyrings/dbeaver.gpg.key https://dbeaver.io/debs/dbeaver.gpg.key
echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt update
sudo apt install dbeaver-ce

# Copy your custom config files
cp -r ../dotfiles/.config/micro/* ~/.config/micro
cp -r ../dotfiles/.config/fastfetch/ ~/.config/fastfetch
cp ../dotfiles/.bashrc ~
cp ../dotfiles/.gitconfig ~
cat ~/dotfiles/.vscodium/extensions.txt | xargs -n 1 codium --install-extension
cp ~/dotfiles/.vscodium/settings.json ~/.config/Code/User/


# Flatpak installations
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub com.usebottles.bottles
flatpak install flathub org.raspberrypi.rpi-imager
flatpak install flathub com.dec05eba.gpu_screen_recorder

# Enable fstrim - SSD optimization tool
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer