#!/usr/bin/env bash

# install wine
echo -e "[*] Install: wine\n"
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

sudo wget -nc -P /etc/apt/sources.list.d/ "https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources"
sudo apt update
sudo apt install -y --install-recommends winehq-stable

# install winetricks
echo -e "[*] Install: winetricks\n"
sudo apt install -yqq winetricks
sudo winetricks --self-update

# install lutris
echo -e "[*] Install: lutris\n"
sudo add-apt-repository -y ppa:lutris-team/lutris
sudo apt update
sudo apt install -yqq lutris

# install steam
echo -e "[*] Install: steam\n"
curl -s http://repo.steampowered.com/steam/archive/stable/steam.gpg | sudo tee /usr/share/keyrings/steam.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/steam.gpg] http://repo.steampowered.com/steam/ stable steam" | sudo tee /etc/apt/sources.list.d/steam.list
sudo apt update
sudo apt install -yqq libgl1-mesa-dri:amd64 libgl1-mesa-dri:i386 libgl1-mesa-glx:amd64 libgl1-mesa-glx:i386 steam-launcher

# install protonup-qt
echo -e "[*] Install: protonup-qt\n"
sudo flatpak install -y flathub net.davidotek.pupgui2

# install gamemode
echo -e "[*] Install: gamemode\n"
sudo apt install -yqq meson libsystemd-dev pkg-config ninja-build libdbus-1-dev libinih-dev build-essential
git clone https://github.com/FeralInteractive/gamemode.git
cd ./gamemode
latestVersion=$(git ls-remote --tags https://github.com/FeralInteractive/gamemode.git | tail -n 1 | cut -d/ -f3-);
git checkout $latestVersion
sudo sh ./bootstrap.sh
cd ..
rm -rf ./gamemode

# install other deps
echo -e "[*] Install: other deps\n"
sudo apt install -yqq libvulkan1 libvulkan1:i386

# Set winetricks
echo -e "[*] Update: winetrikcs win10\n"
winetricks win10

# install xpad for joystick
echo -e "[*] Install: xpad driver\n"
sudo git clone https://github.com/paroj/xpad.git /usr/src/xpad-0.4
sudo dkms install -m xpad -v 0.4

echo -e "[*] Finished\n"