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

# pandoras
# Universal Chroot environment that can be deployed to most linux distros
# Starts the.
# 
# Run the application using sudo and with parameters, for example:
# shell> sudo pandoras start-box

# Prints license
display_license() {

cat <<EOT
Copyright (c) 2023-present Esteban Herrera                                  
stv.herrera@gmail.com                                                       

This program is free software; you can redistribute it and/or modify        
it under the terms of the GNU General Public License as published by        
the Free Software Foundation; either version 3 of the License, or           
(at your option) any later version.                                         

This program is distributed in the hope that it will be useful,             
but WITHOUT ANY WARRANTY; without even the implied warranty of              
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               
GNU General Public License for more details.                                

You should have received a copy of the GNU General Public License           
along with this program; if not, write to the Free Software                 
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   
EOT
}

# Prints help
display_help() {

cat <<EOT
Pandoras (v0.1.2)

Options Usage: (sudo) pandoras [options]

Boxes Options:
    -l, --list-boxes                  Lists chroots
    -f, --list-filesystems            Lists chroots filesystems
    -s, --start-box <box_name>        Starts chroot no dialogs
    -e, --enter-box                   Enters the chroot
    -t, --stop-box                    Stops chroot
    -c, --create-box                  Creates chroot
    -r, --delete-box                  Deletes chroot
    -d, --duplicate-box               Duplicates chroot
    -u, --upsize-box                  Upsizes chroot

More Options:
    -g, --license                     Print the GPL license notification
    -h, --help                        Print this Help
    -V, -v, --version                 Print software version and exit

EOT
}

# Prints version
display_version() {
  echo "Pandoras (v0.1.2)";
}

# Options
main() {
  case $1 in
    '-l' | '--list-boxes')
      cd /var/pandoras/includes || { echo "Error: Unable to change directory."; exit 1; }
      bash list_boxes.sh list_boxes || { echo "Error: list_boxes.sh failed."; exit 1; }
      ;;
    '-f' | '--list-filesystems')
      cd /var/pandoras/includes || { echo "Error: Unable to change directory."; exit 1; }
      bash list_filesystems.sh list_boxes || { echo "Error: list_filesystems.sh failed."; exit 1; }
      ;;
    '-s' | '--start-box')
      # Check if a box name is provided
      if [ -z "$2" ]; then
        echo "Error: Box name is required for start-box."
        exit 1
      fi
      cd /var/pandoras/includes || { echo "Error: Unable to change directory."; exit 1; }
      # Pass the box name as a parameter to start_box.sh
      bash start_box.sh "$2" || { echo "Error: start_box.sh failed."; exit 1; }
      ;;
    '-e' | '--enter-box')
      cd /var/pandoras/includes || { echo "Error: Unable to change directory."; exit 1; }
      bash enter_box.sh enter_box || { echo "Error: enter_box.sh failed."; exit 1; }
      ;;
    '-t' | '--stop-box')
      cd /var/pandoras/includes || { echo "Error: Unable to change directory."; exit 1; }
      bash stop_box.sh stop_box || { echo "Error: stop_box.sh failed."; exit 1; }
      ;;
    '-c' | '--create-box')
      cd /var/pandoras/includes || { echo "Error: Unable to change directory."; exit 1; }
      bash create_box.sh create_box || { echo "Error: create_box.sh failed."; exit 1; }
      ;;
    '-r' | '--delete-box')
      cd /var/pandoras/includes || { echo "Error: Unable to change directory."; exit 1; }
      bash delete_box.sh delete_box || { echo "Error: delete_box.sh failed."; exit 1; }
      ;;
    '-d' | '--duplicate-box')
      cd /var/pandoras/includes || { echo "Error: Unable to change directory."; exit 1; }
      bash duplicate_box.sh duplicate_box || { echo "Error: duplicate_box.sh failed."; exit 1; }
      ;;
    '-u' | '--upsize-box')
      cd /var/pandoras/includes || { echo "Error: Unable to change directory."; exit 1; }
      bash upsize_box.sh upsize_box || { echo "Error: upsize_box.sh failed."; exit 1; }
      ;;
    '-g' | '--license')
      display_license | more
      exit 99
      ;;
    '-h' | '--help')
      display_help | less
      exit 99
      ;;
    '-V' | '-v' | '--version')
      display_version
      exit 99
      ;;
  esac
}

# Set the script to exit on any error
set -e

# Call the main function with the provided arguments
main "$@"

exit 99
