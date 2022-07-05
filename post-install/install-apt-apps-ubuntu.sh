#!/bin/bash

# Update and Upgrade
sudo apt update && sudo apt upgrade -y

# Install via aptitude
sudo apt install -y \
	git colordiff bat ripgrep \
	gparted dosfstools mtools btrfs-progs xfsprogs \
	htop bpytop duf ncdu mc \
	rar unrar zstd p7zip-full p7zip-rar \
	neofetch screenfetch \
	cowsay xsnow sl tldr \
	# Ubuntu's addons
	ubuntu-restricted-extras ubuntu-restricted-addons \
	ttf-mscorefonts-installer \
	libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi \
	software-properties-common \
	gdebi dconf-editor aptitude \
	# GNOME
	gnome-tweaks gnome-weather \
	nautilus-admin hardinfo \
	qt5-style-plugins mpv \
	# Build essentials
	dkms build-essential linux-headers-$(uname -r) cmake \
	os-prober \
	curl wget httpie apt-transport-https gnupg \
	net-tools \
	autossh openvpn \
	speedtest-cli

# NOT FOUND:
	# filezilla
	# ponysay
	# chromium
	# thunar
