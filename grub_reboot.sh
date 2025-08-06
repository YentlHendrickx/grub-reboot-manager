#!/bin/bash

OK='\033[0;32m' # Green
WRN='\033[0;33m' # Yellow
ERR='\033[0;31m' # Red
CLR='\033[0m' # No Color

if [ "$(id -u)" -ne 0 ]; then
    echo -e "${WRN}This script must be run as root. Attempting to escalate privileges...\n${CLR}"
    exec sudo "$0" "$@"
fi

# Check if grub-reboot is available
if ! command -v grub-reboot &> /dev/null; then
    echo -e "${ERR}grub-reboot command not found. Please install GRUB tools.\n${CLR}"
    exit 1
fi

echo "Available GRUB menu entries:"

# Extracts only names of menu entries from grub.cfg, print in numbered list format
awk -F"'" '/menuentry / {gsub(/^[ \t]+|[ \t]+$/,"",$2); print $2}' /boot/grub/grub.cfg | nl -w2 -s'. '
echo ""

# Read and validate user input
while true; do
    read -ep "Enter the menu entry number: " entry_number

    if [[ "$entry_number" =~ ^[0-9]+$ ]]; then
			# Check if the entry number is valid
			total_entries=$(grep -c 'menuentry ' /boot/grub/grub.cfg)

			if [ "$entry_number" -ge 1 ] && [ "$entry_number" -le "$total_entries" ]; then
				selected_entry=$(awk -F"'" '/menuentry / {gsub(/^[ \t]+|[ \t]+$/,"",$2); print $2}' /boot/grub/grub.cfg | sed -n "${entry_number}p")
				break
			else
				echo -e "${ERR}Invalid entry number. Please try again.${CLR}"
			fi
    else
			echo -e "${ERR}Please enter a valid number.${CLR}"
    fi
done

echo -e "\n${OK}Setting GRUB to boot into entry number $entry_number: $selected_entry ${CLR}"
grub-reboot "$entry_number"
if [ $? -ne 0 ]; then
    echo -e "${ERR}Failed to set GRUB to boot into entry number $entry_number.${CLR}"
    exit 1
fi

read -p "Do you want to reboot now? (y/n): " confirm_reboot
if [[ "$confirm_reboot" =~ ^[Yy]$ ]]; then
    echo -e "${OK}Rebooting now...${CLR}"
    reboot
else
    echo -e "${WRN}You can reboot later to apply the changes.${CLR}"
fi
