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

  # Path to the .env file
  ENV_FILE="../env/.env"

  export dir=/var/pandoras

  # Check if the directory is empty (except for .gitkeep)
  isEmpty=true
  shopt -s nullglob
  for file in "$dir/environment"/*; do
    if [ "$file" != "$dir/environment/.gitkeep" ]; then
      isEmpty=false
      break
    fi
  done

  if [ "$isEmpty" = false ]; then
    echo "The directory ${dir}/environment is not empty, exiting..."
    exit 1
  fi

  # Check if a box name is provided as a command-line parameter
  if [ -n "$1" ]; then
    image="$1"
  fi

  mount $dir/images/"$image".img $dir/environment

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
  sed -i "s/^RUNNING_IMG_NAME=.*/RUNNING_IMG_NAME=\"$image\"/" $ENV_FILE

  chroot $dir/environment /bin/su -c 'sh /boot/boot.sh'
}

# Check if a command-line argument is provided and call start_box with the argument
if [ -n "$1" ]; then
  (start_box "$1")
fi
