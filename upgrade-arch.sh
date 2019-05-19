#!/bin/bash

sudo pacman -Syu --noconfirm
yay -Syu --noconfirm && sudo pacman -Sc --noconfirm && sync

