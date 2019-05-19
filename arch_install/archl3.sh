#!/bin/bash

alias spmsn='sudo pacman -S --noconfirm'
alias spms='sudo pacman -S'
alias ysn='yay -S --noconfirm'
alias ys='yay -S'

sudo chown -R $USER:users $HOME/.config

rm -rf ~/.config/xfce4/*
mkdir ~/Downloads
cd ~/Downloads

echo 'Установка AUR (yay)'
sudo pacman -Syu
wget git.io/yay-install.sh && sh yay-install.sh --noconfirm

echo 'Создаем нужные директории'
spmsn xdg-user-dirs
xdg-user-dirs-update

echo 'Установка программ'
spmsn firefox firefox-i18n-ru pulseaudio file-roller gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs aspell-ru libreoffice libreoffice-fresh-ru gparted qbittorrent speedcrunch thunderbird thunderbird-i18n-ru jre8-openjdk java-openjfx audacity chromium gimp screenfetch guvcview evince deadbeef vlc youtube-dl intellij-idea-comunity pycharm-community-edition wine winetricks playonlinux mpd mpc steam wmctrl
ysn timeshift flameshot-git xflux atom-editor-bin hunspell-ru pamac-aur cherrytree skypeforlinux-stable-bin viber photoqt keepassx2 peco

echo 'Установка тем'
ysn papirus-maia-icon-theme-git breeze-default-cursor-theme
spmsn capitaine-cursors

echo 'Установка I3WM'
ysn ttf-font-awesome xkblayout-state lxappearance
# dunst - уведомления рабочего стола
spmsn i3 feh lxterminal scrot lxrandr
ysn i3-gaps polybar rofi clipit redshift-gtk-git

echo 'Качаем и устанавливаем настройки XFCE'
wget https://raw.githubusercontent.com/ISerg999/scripts/master/arch_install/xfce4.tar.gz
sudo rm -rf ~/.config/xfce4/panel/
sudo rm -rf ~/.config/xfce4/*
sudo tar -xzf xfce4.tar.gz -C ~/
echo 'Ставим лого ArchLinux в меню'
wget https://raw.githubusercontent.com/ISerg999/scripts/master/arch_install/archlinux_logo.png
sudo mv -f ~/Downloads/archlinux_logo.png /usr/share/pixmaps/arch_logo.png

echo 'Ставим обои на рабочий стол'
wget https://raw.githubusercontent.com/ISerg999/scripts/master/arch_install/bg.jpg
sudo rm -rf /usr/share/backgrounds/xfce/* #Удаляем стандартрые обои
sudo mv -f ~/Downloads/bg.jpg /usr/share/backgrounds/xfce/bg.jpg

echo 'Включаем сетевой экран'
sudo ufw enable
echo 'Добавляем в автозагрузку:'
sudo systemctl enable ufw

sudo rm -rf ~/Downloads
sudo rm -rf ~/arch3.sh

echo 'Установка завершена!'
