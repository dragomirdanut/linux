#!/bin/bash

sudo apt update

# not on Linux Live ?
# sudo apt upgrade -y

sudo apt install -y \
	git colordiff \
	mc gparted bat exa \
	duf ncdu \
	htop neofetch \
	curl wget httpie apt-transport-https gnupg \
	hardinfo
