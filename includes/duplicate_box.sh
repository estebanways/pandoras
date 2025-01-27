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

# Duplicates chroot
duplicate_box() {

  export dir=/var/pandoras

  echo "Your chroot images:
  $(find "$dir/images" -type f -name "*.img" -exec basename {} .img \; | less)
  "
  read -r -p "Type your old image name: " old
  read -r -p "Type your new image name: " new
  cp $dir/images/"$old".img $dir/images/"$new".img
  cp $dir/images/"$old".filesystems.mnt $dir/images/"$new".filesystems.mnt
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  (duplicate_box)
fi
