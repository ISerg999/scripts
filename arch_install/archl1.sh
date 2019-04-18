#!/bin/bash

# Arch Linux Fast Install - Быстрая установка Arch Linux https://github.com/ordanax/arch2018
# Цель скрипта - быстрое развертывание системы с вашими персональными настройками (конфиг XFCE, темы, программы и т.д.).
# Облегчённый вариант

loadkeys ru
setfont cyr-sun16
echo 'Скрипт сделан на основе чеклиста Бойко Алексея по Установке ArchLinux'
echo 'Ссылка на чек лист есть в группе vk.com/arch4u'

echo 'Синхронизация системных часов'
timedatectl set-ntp true

echo 'Форматирование дисков'
mkfs.ext2  /dev/sda2 -L boot
mkfs.ext3  /dev/sda3 -L root
# mkswap /dev/sda1 -L swap
# mkfs.ext4  /dev/sda4 -L home

echo 'Монтирование дисков'
mount /dev/sda3 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda2 /mnt/boot
swapon /dev/sda1
mount /dev/sda4 /mnt/home

echo 'Выбор зеркал для загрузки. Ставим зеркало от Яндекс'
echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

echo 'Установка основных пакетов'
pacstrap /mnt base base-devel

echo 'Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

arch-chroot /mnt sh -c "$(curl -fsSL https://raw.githubusercontent.com/ISerg999/scripts/master/arch_install/archl2.sh)"
