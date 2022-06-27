#!/bin/bash

# ./mount-and-chroot /source /target mount_options
# ./mount-and-chroot /dev/sda3 /mnt/ubuntu1 subvol=/ubuntu/@,ssd,noatime,space_cache=v2,commit=120,compress=zstd,autodefrag

clear

NC='\033[0m'  # No Color
BLACK='\033[0;30m'
WHITE='\033[1;37m'  # BOLD
GRAY='\033[1;30m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'

if [[ $# -le 2 ]]; then
	echo -e "Mount and chroot on your linux. Create a new target directory if not exists."
	echo -e ""
	echo -e "Usage:"
	echo -e " $0 ${YELLOW}/source ${WHITE}/target ${GREEN}mount_parameters${NC}"
	echo -e ""
	echo -e "Examples:"
	echo -e " $0 ${YELLOW}/dev/sda4 ${WHITE}/mnt/ubuntu ${GREEN}subvol=${WHITE}/target${GREEN}/@,defaults${NC}"
	echo -e " $0 ${YELLOW}/dev/nvme0n1 ${WHITE}/mnt/btrfs ${GREEN}subvolid=5${NC}"
	echo -e ""
	echo -e "Danut's default for BTRFS:"
	echo -e " $0 ${YELLOW}/dev/mapper/LinuxCrypt ${WHITE}/mnt/ubuntu-lts ${GREEN}subvol=${WHITE}/ubuntu-lts${GREEN}/@,ssd,noatime,space_cache=v2,commit=120,compress=zstd:15,discard=async,autodefrag${NC}"
	echo -e ""
	echo -e "Tips: Your subvol better same with the ${WHITE}/target${NC} directory."
	echo -e ""
	echo -e "Source:"
	lsblk -f /dev/sda
	# lsblk -f /dev/nvme0n1
	echo -e ""
	exit 0
fi

SRC_DEV=$1
TARGET_DIR=$2
MNT_PARAMS=$3

# CONDITION: if not contain 'subvolid' then you can use 'subvol'
MNT_PARAMS_DANUT_DEFAULT="subvol=${TARGET_DIR}/@,ssd,noatime,space_cache=v2,commit=120,compress=zstd,discard=async,autodefrag"

echo -e "Source to mount device: \"${SRC_DEV}\""   # /dev/mapper/LinuxCrypt
echo -e "Target directory: \"${TARGET_DIR}\""      # /mnt/ubuntu-lts
echo -e "Mount parameters: \"${MNT_PARAMS}\""      # subvolid=5  or  subvol=/ubuntu-lts/@
echo ""

if [[ -e ${TARGET_DIR} ]]; then
	# TARGET_DIR="/mnt/ubuntu1"
	# echo "Target directory exists, generate an alternative directory ${TARGET_DIR} (TEMPORARY)"
	
	echo "Directory exists."
	# echo "Directory exists. Exit."
	# exit 0  # tmp ?
else
	echo "Directory does not exists. Creating a new directory ${TARGET_DIR}"
	sudo mkdir -pv ${TARGET_DIR}
fi
echo -e "Final, target directory is: \"${TARGET_DIR}\""

echo -e "Preparing for mount device ${SRC_DEV} with parameters: ${MNT_PARAMS}"
if [[ $(findmnt -M ${TARGET_DIR}) ]]; then
	echo "Already mounted."
else
	echo -e ">> Mounting... sudo mount -v ${SRC_DEV} ${TARGET_DIR} -o ${MNT_PARAMS}"
	sudo mount -v ${SRC_DEV} ${TARGET_DIR} -o ${MNT_PARAMS}
fi

# If MNT_PARAMS contain "subvolid" = skip below! exit 0 (no error)
if [[ $MNT_PARAMS =~ "subvolid" ]]; then
	echo -e "Done. (shorter for BTRFS subvolid)"
	exit 0
fi

for i in /dev /dev/pts /proc /run /sys /sys/firmware/efi/efivars; 
do
	# echo "Checking for already mount..."
	# if [[ $(findmnt -M ${TARGET_DIR}) ]]; then
		# echo "Already mounted."
	# else
		# echo "Not mounted.  >> sudo mount -B  $i  ${TARGET_DIR}  => to:  ${TARGET_DIR}$i"
		sudo mount -vB $i ${TARGET_DIR}$i
	# fi
done
echo -e "Done."

echo -e "chroot ${TARGET_DIR} ..."
sudo chroot ${TARGET_DIR}

echo -e "Done."