# Basics install
sudo apt update
sudo apt upgrade -y
sudo apt install \
  btop \
  micro \
  fastfetch \
  git \
  curl \
  gnupg \
  wget \
  fzf \
  timeshift \
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

# Zed code editor
curl -f https://zed.dev/install.sh | sh

# DBeaver
sudo wget -O /usr/share/keyrings/dbeaver.gpg.key https://dbeaver.io/debs/dbeaver.gpg.key
echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt update
sudo apt install dbeaver-ce

# Copy your custom config files
cp -r ./dotfiles/.config/micro/* ~/.config/micro
cp -r ./dotfiles/.config/fastfetch/ ~/.config/fastfetch
cp -r ./dotfiles/.config/zed ~/.config/zed
cp ./dotfiles/.bashrc ~
cp ./dotfiles/.gitconfig ~


# Flatpak installations
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub com.usebottles.bottles
flatpak install flathub org.raspberrypi.rpi-imager
flatpak install flathub com.dec05eba.gpu_screen_recorder
flatpak install flathub app.zen_browser.zen
flatpak install flathub com.jgraph.drawio.desktop

# Enable fstrim - SSD optimization tool
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer
