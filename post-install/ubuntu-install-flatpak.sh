#!/bin/bash

# Update...
sudo apt update && sudo apt upgrade -y

# Install Flatpak
sudo apt install -y \
	flatpak \
	gnome-software-plugin-flatpak \
	gnome-software

# Add Flathub url
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
