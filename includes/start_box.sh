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

  export dir=/var/pandoras/

  echo "Your chroot images:
  $(ls $dir/images/ | sed 's/.img//g')
  "
  read -r -p "Type your image name: " image
  mount $dir/images/"$image".img $dir/environment
  mount -o bind /etc/resolv.conf $dir/environment/etc/resolv.conf
  mount -o bind /dev $dir/environment/dev
  mount -o bind /proc $dir/environment/proc
  mount -o bind /sys $dir/environment/sys
  chroot $dir/environment /bin/su -c 'sh /boot/boot.sh'
}

