#!/bin/bash
apt update && apt upgrade -y && apt autoremove -y
apt install wget -y
wget -O /usr/share/keyrings/gpg-pub-moritzbunkus.gpg https://mkvtoolnix.download/gpg-pub-moritzbunkus.gpg
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y
apt update && apt install mkvtoolnix mkvtoolnix-gui qbittorrent -y
wget -O /root/freedownloadmanager.deb https://files2.freedownloadmanager.org/fdm6_qt5/freedownloadmanager.deb
apt install xdg-utils ffmpeg -y
dpkg -i /root/freedownloadmanager.deb
rm /root/freedownloadmanager.deb
