#!/bin/bash

# mount-and-chroot /source /target mount_options
# mount-and-chroot /dev/sda3 /mnt/ubuntu1 subvol=/ubuntu/@,ssd,noatime,space_cache=v2,commit=120,compress=zstd,autodefrag

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

src_dev=$1
target_dir=$2
mnt_params=$3

# CONDITION: if not contain 'subvolid' then you can use 'subvol'
mnt_params_danut_default="subvol=${target_dir}/@,ssd,noatime,space_cache=v2,commit=120,compress=zstd,discard=async,autodefrag"

echo -e "Source to mount device: \"${src_dev}\""
echo -e "Target directory: \"${target_dir}\""
echo -e "Mount parameters: \"${mnt_params}\""
echo ""

if [[ -e ${target_dir} ]]; then
	# target_dir="/mnt/ubuntu1"
	# echo "Target directory exists, generate an alternative directory ${target_dir} (TEMPORARY)"
	echo "Directory exists. Exit."
	exit 0  # tmp ?
else
	echo "Directory does not exists. Creating a new directory ${target_dir}"
	sudo mkdir -pv ${target_dir}
fi
echo -e "Final target directory is: \"${target_dir}\""

echo -e "Mounting device ${src_dev} with parameters: ${mnt_params}"
echo -e ">> sudo mount -v ${src_dev} ${target_dir} -o ${mnt_params}"
sudo mount -v ${src_dev} ${target_dir} -o ${mnt_params}

# If mnt_params contain "subvolid" = skip below! exit 0 (no error)
if [[ $mnt_params =~ "subvolid" ]]; then
	echo -e "Done. (shorter for subvolid)"
	exit 0
fi

for i in /dev /dev/pts /proc /run /sys /sys/firmware/efi/efivars; 
do
	echo " >> sudo mount -B  $i  ${target_dir}  => to:  ${target_dir}$i"
	sudo mount -B $i ${target_dir}$i
done
echo -e "Done."

echo -e "chroot ${target_dir} ..."
sudo chroot ${target_dir}

echo -e "Done."