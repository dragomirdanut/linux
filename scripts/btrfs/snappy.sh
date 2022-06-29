#!/bin/bash

# btrfs subvolume snapshot -r / /.snapshots/2022.06.28-09.19
# btrfs subvolume snapshot -r /home/ /home/.snapshots/2022.06.28-09.19

# ./snappy.sh
#   snapshots -r
#       /           /.snapshots
#       /home       /home/.snapshots
#         YYYY.MM.DD-HH.mm.SS
#
# if message exists

# Color
NC='\033[0m'  # No Color
BLACK='\033[0;30m'
WHITE='\033[1;37m'  # BOLD
GRAY='\033[1;30m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'

clear

# Get the current timestamp - YYYY.MM.DD-HH.mm.SS
TIMESTAMP=$(date +"%Y.%m.%d-%H.%M.%S")
# echo -e "Timestamp: ${TIMESTAMP}"
TIMESTAMP_MESSAGE=${TIMESTAMP}

if [[ ! $# -eq 0 ]]; then
    # echo "Argument exist"
    SEPARATOR="_"
    # ARGUMENTS=("$@")
    # echo -e "Arguments: \"${ARGUMENTS[@]}\""

    OLD_IFS="$IFS"
    IFS="${SEPARATOR}"
    STR_ARG="$*"
    # echo -e "String argument: \"$STR_ARG\""
    IFS=$OLD_IFS
    TIMESTAMP_MESSAGE+=${SEPARATOR}${STR_ARG}
fi
# echo -e "Final Timestamp with message: ${TIMESTAMP_MESSAGE}"

#TODO: Check here is under BTRFS
#TODO: Check if exist /.snapshots
#TODO: Check if exist /home/.snapshots

echo ""
echo -e "Creating two readonly snapshots ${WHITE}/${NC} and ${WHITE}/home${NC} into ${YELLOW}${TIMESTAMP_MESSAGE}${NC}"
echo ""
# echo -e "sudo btrfs subvolume snapshot -r ${WHITE}/${NC} /.snapshots/${YELLOW}${TIMESTAMP_MESSAGE}${NC}"
echo -e "${GRAY}sudo btrfs subvolume snapshot -r / /.snapshots/${TIMESTAMP_MESSAGE}${NC}"
sudo btrfs subvolume snapshot -r / /.snapshots/"${TIMESTAMP_MESSAGE}"
echo -e "Done."
echo ""

# echo -e "Creating a readonly snapshot of ${WHITE}/home${NC} ..."
# echo -e "sudo btrfs subvolume snapshot -r ${WHITE}/home${NC} /home/.snapshots/${YELLOW}${TIMESTAMP_MESSAGE}${NC}"
echo -e "${GRAY}sudo btrfs subvolume snapshot -r /home /home/.snapshots/${TIMESTAMP_MESSAGE}${NC}"
sudo btrfs subvolume snapshot -r /home /home/.snapshots/"${TIMESTAMP_MESSAGE}"
echo -e "Done."
echo ""

echo -e "All done!"

# TODO: Final report for / and /home ?
# sudo btrfs subvolume list | grep ${TIMESTAMP}  ?
# TODO: Delete the oldest snapshot ? By number: 5 of old to delete ?

### Cleanup after some tests:
# btrfs subvolume delete /.snapshots/2022.06.28-*
# btrfs subvolume delete /home/.snapshots/2022.06.28-*