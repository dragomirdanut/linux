#!/bin/bash

# target_dir="/mnt/ubuntu3"
target_dir=$1

# condition for param
if [[ $# -le 0 ]]; then
	echo -e "No parameter for path to unmount. Exit."
	exit 0
fi

echo -e "Unmounting ${target_dir}"

# If mnt_params contain "subvolid" = skip below! exit 0 (no error)
if [[ ! $mnt_params =~ "btrfs" ]]; then
	# invert orders
	for i in ${target_dir}/sys/firmware/efi/efivars ${target_dir}/sys ${target_dir}/run ${target_dir}/proc ${target_dir}/dev/pts ${target_dir}/dev; 
	do
		echo " >> Umounting $i"
		sudo umount $i
	done
	echo -e "Done."
fi

echo -e "Final umount the target directory: ${target_dir}"
sudo umount ${target_dir}
echo -e "Done."

exit 0