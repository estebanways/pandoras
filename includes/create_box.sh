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

# Creates chroot

#echo "Hello World"

create_box() {

  dir=/var/pandoras

	read -r -p "Type your new chroot name: " chroot
  read -r -p "Type your new chroot size (in GB): " size
  dd if=/dev/zero of=$dir/images/"$chroot".img bs=1G count="$size"
  mke2fs -t ext4 $dir/images/"$chroot".img
  mount $dir/images/"$chroot".img $dir/environment
  rm -rf $dir/environment/*
  read -r -p "Type your architecture: " arch
  read -r -p "Type your distro codename: " distro
  read -r -p "Type your mirror url (leave blank for default mirror): " mirror
  debootstrap --arch "$arch" "$distro" $dir/environment/ "$mirror" &&
  chroot $dir/environment /bin/su -c 'echo "#!/bin/sh" > /boot/boot.sh' &&
  chroot $dir/environment /bin/su -c 'echo "" > /etc/resolv.conf'
  umount $dir/environment
}

# Call the parse_skill_ if the script is run directly (not sourced)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	(create_box)
fi

