#!/bin/bash

read -p "Введите имя компьютера: " hostname
read -p "Введите имя пользователя: " username

echo 'Прописываем имя компьютера'
echo $hostname > /etc/hostname
ln -svf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

echo '3.4 Добавляем русскую локаль системы'
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

echo '3.5 Устанавливаем загрузчик'
pacman -Syy
pacman -S grub --noconfirm 
grub-install /dev/sda

echo 'Обновляем grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg

echo 'Ставим программу для Wi-fi'
pacman -S dialog wpa_supplicant --noconfirm 

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
  pacman -S nvidia-390xx nvidia-390xx-settings nvidia-390xx-utils opencl-nvidia-390xx lib32-nvidia-390xx-utils lib32-opencl-nvidia-390xx mesa lib32-mesa --noconfirm
  pacman -S xorg-server xorg-xinit
elif [[ $vm_setting == 1 ]]; then
  pacman -S xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils
fi

echo "Какое DE ставим?"
read -p "1 - XFCE, 2 - KDE: " vm_setting
if [[ $vm_setting == 1 ]]; then
  pacman -S xfce4 xfce4-goodies --noconfirm
elif [[ $vm_setting == 2 ]]; then
  pacman -Sy plasma-meta kdebase --noconfirm
fi

echo "Какой ставим DM ?"
read -p "1 - sddm, 2 - lxdm: " dm_setting
if [[ $dm_setting == 1 ]]; then
  pacman -Sy sddm sddm-kcm --noconfirm
  systemctl enable sddm.service -f
elif [[ $dm_setting == 2 ]]; then
  pacman -S lxdm --noconfirm
  systemctl enable lxdm
fi

echo 'Ставим шрифты'
pacman -S ttf-liberation ttf-dejavu noto-fonts noto-fonts-extra ttf-roboto ttf-droid opendesktop-fonts ttf-arphic-ukai ttf-arphic-uming ttf-bitstream-vera --noconfirm

echo 'Ставим консольные приложения'
pacman -S cabextract cvs p7zip unrar zip unzip unarj atool mc mtools fuse wget exfat-utils --noconfirm

echo 'Ставим сеть'
pacman -S networkmanager network-manager-applet ppp --noconfirm

echo 'Подключаем автозагрузку менеджера входа и интернет'
systemctl enable NetworkManager

echo 'Установка завершена! Перезагрузите систему.'
echo 'Если хотите подключить AUR, установить мои конфиги XFCE, тогда после перезагрзки и входа в систему, установите wget (sudo pacman -S wget) и выполните команду:'
echo 'wget https://raw.githubusercontent.com/ISerg999/scripts/master/arch_install/arch3.sh && sh arch3.sh'
exit
