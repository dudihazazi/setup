#!/bin/bash

# update installed packages
echo -e "[*] Updating: packages\n"
sudo apt update
sudo apt upgrade -yqq

# update drivers
echo -e "[*] Updating: drivers\n"
sudo ubuntu-drivers install

# install essentials packages
echo -e "[*] Installing: wget, curl, git, apt-transport-https\n"
sudo apt install -yqq wget curl git apt-transport-https

# install zsh and oh-my-zsh
echo -e "[*] Installing: zsh\n"
sudo apt install -yqq zsh
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# install zsh plugins
echo -e "[*] Installing: zsh plugins\n"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install font for powerlevel10k
echo -e "[*] Installing: MesloLGS fonts\n"
mkdir -p ~/.local/share/fonts/MesloLGS
wget -q --show-progress "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf" -P ~/.local/share/fonts/MesloLGS
wget -q --show-progress "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf" -P ~/.local/share/fonts/MesloLGS
wget -q --show-progress "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf" -P ~/.local/share/fonts/MesloLGS
wget -q --show-progress "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf" -P ~/.local/share/fonts/MesloLGS
fc-cache -fv ~/.local/share/fonts/MesloLGS

# install powerlevel10k theme for zsh
echo -e "[*] Installing: powerlevel10k theme\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# update zsh config
echo -e "[*] Updating: zsh config\n"
cp ./dotfiles/.zshrc ~/.zshrc
cp ./dotfiles/.p10k.zsh ~/.p10k.zsh

# change default shell to zsh
echo -e "[*] Updating: default shell to zsh\n"
sudo chsh -s $(which zsh)