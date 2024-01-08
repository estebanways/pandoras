#!/bin/env bash
################################################################################
#                                   Pandoras                                   #
#                                                                              #
# Universal Chroot environment that can be deployed to most Linux distros      #
#                                                                              #
# Change History                                                               #
# 12/11/2023  Esteban Herrera Original code.                                   #
#                           Add new history entries as needed.                 #
#                                                                              #
#                                                                              #
################################################################################
################################################################################
################################################################################
#                                                                              #
#  Copyright (c) 2023-present Esteban Herrera C.                               #
#  stv.herrera@gmail.com                                                       #
#                                                                              #
#  This program is free software; you can redistribute it and/or modify        #
#  it under the terms of the GNU General Public License as published by        #
#  the Free Software Foundation; either version 3 of the License, or           #
#  (at your option) any later version.                                         #
#                                                                              #
#  This program is distributed in the hope that it will be useful,             #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of              #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               #
#  GNU General Public License for more details.                                #
#                                                                              #
#  You should have received a copy of the GNU General Public License           #
#  along with this program; if not, write to the Free Software                 #
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   #

# Starts chroot
start_box() {

  # Path to the env file
  ENV_FILE="../env/.env"

  export dir=/var/pandoras

  sudo bash ./list_boxes.sh
  read -r -p "Type your image name: " image

  # Ask if a custom partition or directory should be added
  read -r -p "Do you want to add a custom partition or directory? (y/n): " add_custom_part

  mount $dir/images/"$image".img $dir/environment

  if [ "$add_custom_part" == "y" ]; then
    # Ask for the device path or directory path
    read -r -p "Type the device or directory path (e.g., /dev/sdXn or /path/to/directory): " custom_part

    # Create the temporary custom mount points file
    echo "$custom_part $dir/environment/$custom_part" > "$dir/images/tmp_mounts.mnt"

    # Check if it's a directory or a device
    if [ -b "$custom_part" ]; then
      # It's a block device (partition)
      mount "$custom_part" $dir/environment/mnt
    elif [ -d "$custom_part" ]; then
      # It's a directory
      mount -o bind "$custom_part" $dir/environment/mnt
    else
      echo "Invalid path or type. Exiting."
      return
    fi
  fi

  # Check if the mount file exists
  if [ ! -f "$dir/images/$image.filesystems.mnt" ]; then
    echo "File not found: $dir/images/$image.filesystems.mnt"
    exit 1
  fi

  # Mount the mount file content
  while IFS= read -r line; do
    # Use cut to extract the first and second fields
    source_point=$(echo "$line" | cut -d' ' -f1)
    target_point=$(echo "$line" | cut -d' ' -f2)

    mount -o bind "$source_point" "$target_point"
  done < "$dir/images/$image.filesystems.mnt"

  # Update the running image name
  sed -i "s/^RUNNING_IMAGE_NAME=.*/RUNNING_IMAGE_NAME=\"$image\"/" $ENV_FILE

  chroot $dir/environment /bin/su -c 'sh /boot/boot.sh'
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  (start_box)
fi
