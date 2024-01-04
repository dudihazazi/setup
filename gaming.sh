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

# install protonup-qt
echo -e "[*] Install: protonup-qt\n"
sudo flatpak run net.davidotek.pupgui2

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

# Set winetricks
echo -e "[*] Update: winetrikcs win10\n"
winetricks win10

echo -e "[*] Finished\n"