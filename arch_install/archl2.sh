#!/bin/bash

alias pmsn='pacman -S --noconfirm'
alias pms='pacman -S'

read -p "Введите имя компьютера: " hostname
read -p "Введите имя пользователя: " username

echo 'Прописываем имя компьютера'
echo $hostname > /etc/hostname
ln -svf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

echo 'Добавляем русскую локаль системы'
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen 
echo 'Обновим текущую локаль системы'
locale-gen

echo 'Указываем язык системы'
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
echo 'Вписываем KEYMAP=ru FONT=cyr-sun16'
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

echo 'Создадим загрузочный RAM диск'
mkinitcpio -p linux

echo 'Устанавливаем загрузчик'
pacman -Syy
pmsn grub 
grub-install /dev/sda
echo 'Обновляем grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg

echo 'Ставим программу для Wi-fi'
pmsn dialog wpa_supplicant

echo 'Добавляем пользователя'
useradd -m -g users -G wheel -s /bin/bash $username
echo 'Создаем root пароль'
passwd
echo 'Устанавливаем пароль пользователя'
passwd $username

echo 'Устанавливаем SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

echo 'Раскомментируем репозиторий multilib Для работы 32-битных приложений в 64-битной системе.'
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syy

echo "Куда устанавливем Arch Linux на виртуальную машину?"
read -p "1 - Да, 0 - Нет: " vm_setting
echo 'Ставим иксы и драйвера'
if [[ $vm_setting == 0 ]]; then
  pmsn nvidia-390xx nvidia-390xx-settings nvidia-390xx-utils opencl-nvidia-390xx lib32-nvidia-390xx-utils lib32-opencl-nvidia-390xx mesa lib32-mesa
  pms xorg-server xorg-xinit
elif [[ $vm_setting == 1 ]]; then
  pms xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils
fi

echo 'Ставим шрифты'
pmsn ttf-liberation ttf-dejavu noto-fonts noto-fonts-extra ttf-roboto ttf-droid opendesktop-fontsttf-bitstream-vera
echo 'Ставим консольные приложения'
pmsn cabextract cvs p7zip unrar zip unzip unarj atool mc mtools fuse wget exfat-utils
echo 'Ставим сеть'
pmsn networkmanager network-manager-applet ppp
echo 'Подключаем автозагрузку менеджера входа и интернет'
systemctl enable NetworkManager
echo 'Установка завершена! Перезагрузите систему.'
echo 'Если хотите подключить AUR, установить мои конфиги XFCE, тогда после перезагрзки и входа в систему, установите wget (sudo pacman -S wget) и выполните команду:'
echo 'wget https://raw.githubusercontent.com/ISerg999/scripts/master/arch_install/archl3.sh && sh archl3.sh'

echo 'pacman -S --noconfirm xfce4 xfce4-goodies'
exit
