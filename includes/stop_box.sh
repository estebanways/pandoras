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

# Stops chroot
stop_box() {

  export dir=/var/pandoras/

  lsof | grep "/environment/" > $dir/process/1
  cut -c11-15 $dir/process/1 > $dir/process/2
  uniq $dir/process/2 > $dir/process/3
  echo "
  $(cat $dir/process/3)" > $dir/process/4
  sed 's/ //g' $dir/process/4 > $dir/process/5
  sed ':a;N;$!ba;s/\n/\nkill -9 /g' $dir/process/5 > $dir/process/6
  sed '1 d' $dir/process/6 > $dir/process/7
  sh $dir/process/6
  umount $dir/environment/sys
  umount $dir/environment/proc
  umount $dir/environment/dev
  umount $dir/environment/etc/resolv.conf
  umount $dir/environment
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  (stop_box)
fi

