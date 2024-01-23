#!/usr/bin/env bash

# update installed packages
echo -e "[*] Updating: packages\n"
sudo apt update
sudo apt upgrade -yqq

# update drivers
echo -e "[*] Updating: drivers\n"
sudo ubuntu-drivers install

# install essentials packages
echo -e "[*] Installing: essentials packages\n"
sudo apt install -yqq gpg wget curl git apt-transport-https micro dconf-cli dirmngr ca-certificates software-properties-common

# install eza, replacement to ls
echo -e "[*] Installing: eza\n"
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -yqq eza

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
sudo mkdir -p ~/.local/share/fonts/MesloLGS
wget -q --show-progress "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf" -P ~/.local/share/fonts/MesloLGS
wget -q --show-progress "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf" -P ~/.local/share/fonts/MesloLGS
wget -q --show-progress "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf" -P ~/.local/share/fonts/MesloLGS
wget -q --show-progress "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf" -P ~/.local/share/fonts/MesloLGS
fc-cache -fv ~/.local/share/fonts/MesloLGS

# install powerlevel10k theme for zsh
echo -e "[*] Installing: powerlevel10k theme for zsh\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# install dracula theme for gnome terminal
echo -e "[*] Installing: dracula theme for gnome terminal\n"
git clone https://github.com/dracula/gnome-terminal
sudo sh ./gnome-terminal/install.sh
sudo rm -rf ./gnome-terminal

# update dotfiles
echo -e "[*] Updating: dotfiles\n"
sudo cp ./dotfiles/.bashrc ~/.bashrc
sudo cp ./dotfiles/.zshrc ~/.zshrc
sudo cp ./dotfiles/.p10k.zsh ~/.p10k.zsh
sudo cp ./dotfiles/.gitconfig ~/.gitconfig

# install gh cli
echo -e "[*] Installing: gh CLI\n"
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install -yqq gh

# generate ssh key
echo -e "[*] Updating: SSH key\n"
ssh-keygen -t ed25519 -C "hazazi.dudi@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# register ssh key to github
echo -e "[*] Updating: GH Auth\n"
gh auth login

# install fnm
sudo curl -fsSL https://fnm.vercel.app/install | bash

# install conda
echo -e "[*] Installing: Conda\n"
curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | sudo gpg --dearmor > conda.gpg
install -o root -g root -m 644 conda.gpg /usr/share/keyrings/conda-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" | sudo tee -a /etc/apt/sources.list.d/conda.list
sudo apt update
sudo apt install -yqq conda

# install vscode
echo -e "[*] Installing: VSCode\n"
curl -fSsL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -yqq code

# install BitWarden
echo -e "[*] Installing: BitWarden\n"
wget -q --show-progress "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb" -O "./bitwarden.deb"
sudo apt install -yqq ./bitwarden.deb
rm -f ./bitwarden.deb

# install Zoom
echo -e "[*] Installing: Zoom\n"
sudo apt install libegl1-mesa libxcb-cursor0 libxcb-xtest0
wget -q --show-progress "https://zoom.us/client/latest/zoom_amd64.deb" -O "./zoom.deb"
sudo apt install -yqq ./zoom.deb
rm -f ./zoom.deb

# install freedownloadmanager
echo -e "[*] Installing: FDM\n"
wget -q --show-progress "https://files2.freedownloadmanager.org/6/latest/freedownloadmanager.deb" -O "./fdm.deb"
sudo apt install -yqq ./fdm.deb
rm -f ./fdm.deb

# install spotify
echo -e "[*] Installing: spotify + spicetify\n"
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install -yqq spotify-client

sudo chmod a+wr /usr/share/spotify
sudo chmod a+wr /usr/share/spotify/Apps -R

curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh | sh
spicetify backup apply

# install VPN. currently use surfshark
echo -e "[*] Installing: surfshark\n"
curl -f https://downloads.surfshark.com/linux/debian-install.sh --output surfshark-install.sh
sudo sh surfshark-install.sh
rm -f surfshark-install.sh

# install Apps
echo -e "[*] Installing: Multiple Apps\n"
sudo apt install -yqq chromium-browser
sudo apt install -yqq vlc
sudo apt install -yqq gparted
sudo apt install -yqq pavucontrol
sudo apt install -yqq unrar

# change default shell to zsh
echo -e "[*] Updating: default shell to zsh\n"
sudo chsh -s $(which zsh)

# clean apt
sudo apt autoclean
sudo apt autoremove
echo -e "[*] Setup Finished\n"