#!/bin/bash

# Our kernels.
KERNEL_LIST=()
FIND="find /boot -maxdepth 1 -name 'vmlinuz-*' -type f -not -name '*.dpkg-tmp' -print0 | sort -Vrz"
# FIND="find /boot -maxdepth 1 -name 'vmlinuz-*' -type f -not -name '*.dpkg-tmp' -print0"
while IFS= read -r -u3 -d $'\0' LINE; do
    # echo ". LINE = ${LINE}"       # LINE     = /boot/vmlinuz-5.15.0-35-generic
    KERNEL=$(basename "${LINE}")  # KERNEL   = vmlinuz-5.15.0-35-generic
    KERNEL_LIST+=("${KERNEL}")      # KERNEL:8 = 5.15.0-37-generic
done 3< <(eval "${FIND}")

echo "KERNEL_LIST = ${KERNEL_LIST[@]}"
# KERNEL_LIST = ( vmlinuz-5.15.0-35-generic vmlinuz-5.15.0-37-generic )


# There has to be at least one kernel.
if [ ${#KERNEL_LIST[@]} -lt 1 ]; then
    echo -e "No kernels found!"
    exit 1
fi

echo -e "\e[2m---\e[0m"
# The latest kernel
LATEST_VERSION="${KERNEL_LIST[@]:0:1}"
echo -e "Latest kernel is: ${LATEST_VERSION}"

echo ""
for FILE in config initrd.img System.map vmlinuz; do
    echo "/boot/${FILE}-${LATEST_VERSION}"
done

echo -e "\e[2m---\e[0m"
# Legacy kernel
if [ ${#KERNEL_LIST[@]} -gt 1 ]; then
    LEGACY_VERSIONS=("${KERNEL_LIST[@]:1}")
    for LEGACY_VERSION in "${LEGACY_VERSIONS[@]}"; do
        echo "Legacy kernel is: ${LEGACY_VERSION}"
        echo ""
        for FILE in config initrd.img Sysstem.map vmlinuz; do
            echo "/boot/${FILE}-${LEGACY_VERSION}"
        done
    done
fi

echo -e "\e[2m---\e[0m"