#!/bin/bash

alias pmsn='sudo pacman -S --noconfirm'
alias pms='sudo pacman -S'
alias ysn='yay -S --noconfirm'
alias ys='yay -S'

rm -rf ~/.config/xfce4/*
mkdir ~/Downloads
cd ~/Downloads

echo 'Установка AUR (yay)'
sudo pacman -Syu
wget git.io/yay-install.sh && sh yay-install.sh --noconfirm

echo 'Создаем нужные директории'
pmsn xdg-user-dirs
xdg-user-dirs-update

echo 'Установка программ'
pmsn firefox firefox-i18n-ru ufw qt4 f2fs-tools dosfstools ntfs-3g alsa-lib alsa-utils pulseaudio file-roller gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs aspell-ru libreoffice libreoffice-fresh-ru gparted qbittorrent speedcrunch gnupg git ffmpeg librsvg thunderbird thunderbird-i18n-ru jre8-openjdk java-openjfx audacity chromium gimp openexr screenfetch guvcview evince vim mplayer
ysn timeshift flameshot-git xflux atom-editor-bin hunspell-ru pamac-aur cherrytree skypeforlinux-stable-bin viber photoqt

echo 'Установка тем'
ysn papirus-maia-icon-theme-git breeze-default-cursor-theme
pmsn capitaine-cursors

echo 'Установка I3WM'
ysn ttf-font-awesome xkblayout-state lxappearance
pmsn i3 feh compton htop lxterminal scrot
ysn i3-gaps polybar rofi clipit

echo 'Качаем и устанавливаем настройки XFCE'
wget https://raw.githubusercontent.com/ISerg999/scripts/master/arch_install/xfce4.tar.gz
sudo rm -rf ~/.config/xfce4/panel/
sudo rm -rf ~/.config/xfce4/*
sudo tar -xzf xfce4.tar.gz -C ~/
echo 'Ставим лого ArchLinux в меню'
wget https://raw.githubusercontent.com/ISerg999/scripts/master/arch_install/archlinux_logo.png
sudo mv -f ~/Downloads/archlinux_logo.png /usr/share/pixmaps/arch_logo.png

#echo 'Ставим обои на рабочий стол'
#wget https://raw.githubusercontent.com/ISerg999/scripts/master/arch_install/bg.jpg
#sudo rm -rf /usr/share/backgrounds/xfce/* #Удаляем стандартрые обои
#sudo mv -f ~/Downloads/bg.jpg /usr/share/backgrounds/xfce/bg.jpg

echo 'Включаем сетевой экран'
sudo ufw enable
echo 'Добавляем в автозагрузку:'
sudo systemctl enable ufw

sudo rm -rf ~/Downloads
sudo rm -rf ~/arch3.sh

echo 'Установка завершена!'

echo 'sudo pacman -S --noconfirm vlc clementine'
echo 'yay -S --noconfirm notepadqq yandex-browser-betta'
