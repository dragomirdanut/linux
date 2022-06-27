#!/bin/bash

# TARGET_DIR="/mnt/ubuntu3"
TARGET_DIR=$1

# condition for param
if [[ $# -le 0 ]]; then
	echo -e "No parameter for path to unmount. Exit."
	exit 0
fi

echo -e "Unmounting ${TARGET_DIR} ..."

if [[ ! ${TARGET_DIR} =~ "btrfs" ]]; then
	for i in ${TARGET_DIR}/sys/firmware/efi/efivars ${TARGET_DIR}/sys ${TARGET_DIR}/run ${TARGET_DIR}/proc ${TARGET_DIR}/dev/pts ${TARGET_DIR}/dev; 
	do
		echo " >> Umounting $i"
		sudo umount $i
	done
	echo -e "Done."
fi

echo -e "Final umount the target directory: ${TARGET_DIR}"
sudo umount ${TARGET_DIR}
echo -e "Done."

exit 0