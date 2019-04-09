#!/bin/bash
rm -rf ~/.config/xfce4/*
mkdir ~/Downloads
cd ~/Downloads

echo 'Установка AUR (yay)'
sudo pacman -Syu
wget git.io/yay-install.sh && sh yay-install.sh --noconfirm

echo 'Создаем нужные директории'
sudo pacman -S xdg-user-dirs --noconfirm
xdg-user-dirs-update

echo 'Установка программ'
# ufw - файревол
# f2fs-tools, dosfstools, ntfs-3g - утилиты дл яработы с дисками
# alsa-lib alsa-utils pulseaudio - драйвера и утилиты для работы со звуком
# file-roller - оконный архиватор
# gvfs - утилиты для автомонтирования внешних устройств
# aspell-ru - утилита для проверки орфографии
# libreoffice - оффис
# vlc - плеер видео
# clementine - плеер аудио
# gparted - утилита для разбивки дисков
# qbittorrent - закачка торрентов
# speedcrunch - калькулятор навароченный
# cherrytree - древовидный блокнот
# gnupg - шифрование
# eog - просмотр картинок
# git - программа для контроля версий
# ffmpeg - кодеки для видео
# librsvg - библиотека для просмотра svg графики
# thunderbird - для работы с почтой
# jre8-openjdk java-openjfx - для Java
# audacity - запись звуков
# chromium - дополнительный браузер
# gimp - графический редактор
# openexr - библиотека для грфических файлов с высоким динамическим диапазоном .exr
# screenfetch - терминальная утилита для вывода информации о системе
# guvcview - для работы с веб-камерой
# evince - приложение для просмотра документов (pdf, djvu, ...)
# * freemind - приложение для создания диаграмм связей
# * pavucontrol - утилита для регулировки звука
sudo pacman -S firefox firefox-i18n-ru ufw qt4 f2fs-tools dosfstools ntfs-3g alsa-lib alsa-utils pulseaudio file-roller gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs aspell-ru libreoffice libreoffice-fresh-ru vlc clementine gparted qbittorrent speedcrunch cherrytree gnupg eog git ffmpeg librsvg thunderbird thunderbird-i18n-ru jre8-openjdk java-openjfx audacity chromium gimp openexr screenfetch guvcview evince --noconfirm

# timeshift - резервное копирование системы
# flameshot-git - для создания и редактирования скриншотов
# xflux - утилита автоматического изменение цветности экрана в зависимости от времени суток
# sublime-text-dev - текстовый редактор
# hunspell-ru - программа для проверки орфографии
# pamac-aur - оконная программа для установки и удаления приложений
# notepadqq - клон текстового редактора notepad++
# yandex-browser-betta - Yandex браузер (пока нужен)
# * dropbox - облачное хранение
# * skypeforlinux-stable-bin - skype
# * viber - Viber
yay -S timeshift flameshot-git xflux sublime-text-dev hunspell-ru pamac-aur notepadqq yandex-browser-betta --noconfirm

echo 'Установить i3wm?'
read -p "1 - Да, 0 - Нет: " i3wm_set
if [[ $i3wm_set == 1 ]]; then
	# lxappearance - настройка тем
	# polybar - статус-бар
	# rofi - замена dmenu
	# compton - композитный менеджер для графического X-сервера
	# htop - для просмотра и останоки процессов в консоли
	# lxterminal - легкий терминал
	# scrot - создание снимков экрана из консоли
	# feh - легкий просмотрщик изображений, также позволяет задавать background
	# --- sudo pacman -S dmenu --noconfirm --- 
	# * thunar - файловый графический менеджер (если xfce4 не установлен)
	# yay -S ttf-font-awesome terminus-ttf xkblayout-state lxappearance --noconfirm
	# sudo pacman -S i3 --noconfirm
	# yay -S i3-gaps polybar rofi --noconfirm
	# sudo pacman -S compton htop lxterminal scrot --noconfirm
elif [[ $i3wm_set == 0 ]]; then
	echo 'Установка i3wm пропущена.'
fi

echo 'Установка тем'
yay -S osx-arc-shadow papirus-maia-icon-theme-git breeze-default-cursor-theme --noconfirm
sudo pacman -S capitaine-cursors

echo 'Скачать и установить конфиг и темы для XFCE?'
read -p "1 - Да, 0 - Нет: " xfce_set
if [[ $xfce_set == 1 ]]; then
  echo 'Качаем и устанавливаем настройки Xfce'
  # Чтобы сделать копию ваших настоек XFCE перейдите в домашнюю директорию ~/username открйте в этой категории терминал и выполните команду ниже.
  # tar -czf xfce4.tar.gz .config/xfce4
  # Выгрузите архив в интернет и скорректируйте ссылку на XFCE файл заменив ссылку на свою.
  wget https://raw.githubusercontent.com/ISerg999/scripts/master/arch_install/xfce4.tar.gz
  sudo rm -rf ~/.config/xfce4/panel/
  sudo rm -rf ~/.config/xfce4/*
  sudo tar -xzf xfce4.tar.gz -C ~/
  
  echo 'Ставим лого ArchLinux в меню'
  wget https://raw.githubusercontent.com/ISerg999/scripts/master/arch_install/arch_logo.png
  sudo mv -f ~/Downloads/arch_logo.png /usr/share/pixmaps/arch_logo.png

  echo 'Ставим обои на рабочий стол'
  wget https://raw.githubusercontent.com/ISerg999/scripts/master/arch_install/bg.jpg
  sudo rm -rf /usr/share/backgrounds/xfce/* #Удаляем стандартрые обои
  sudo mv -f ~/Downloads/bg.jpg /usr/share/backgrounds/xfce/bg.jpg
elif [[ $xfce_set == 0 ]]; then
  echo 'Скачивание и установка конфига XFCE пропущена.'
fi

echo 'Установить conky?'
read -p "1 - Да, 0 - Нет: " conky_set
if [[ $conky_set == 1 ]]; then
  sudo pacman -S conky conky-manager --noconfirm
  wget https://raw.githubusercontent.com/ISerg999/scripts/master/arch_install/conky.tar.gz
  tar -xzf conky.tar.gz -C $HOME/
elif [[ $conky_set == 0 ]]; then
  echo 'Установка conky пропущена.'
fi

echo 'Включаем сетевой экран'
sudo ufw enable

echo 'Добавляем в автозагрузку:'
sudo systemctl enable ufw

sudo rm -rf ~/Downloads
sudo rm -rf ~/arch3.sh

echo 'Установка завершена!'
