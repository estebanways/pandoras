[![Shell Linter](https://github.com/estebanways/pandoras/actions/workflows/shell-linter.yml/badge.svg)](https://github.com/estebanways/pandoras/actions/workflows/shell-linter.yml) [![License: GPLv3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# Pandoras

Universal Chroot environment that can be deployed to most linux distros and with a portable chroot image that can be moved to one host to another.

<img alt="sword-vim" src="./pandoras.jpg?raw=true" width="500" height="320" />

## Build a Chroot Management System

### Create your chroot directory

```shell
cd
git clone git@github.com:estebanways/pandoras.git 
sudo chown -R root:root pandoras/
sudo mv pandoras /var 
```

This is going to create the directories:

`/var/pandoras`: Your chroot directory.
<br />`/var/pandoras/images`: The images directory.
<br />`/var/pandoras/process`: The process directory.
<br />`/var/pandoras/environment`: The chroot environment directory that will be mounted.

If you want to have a chroot directory instead of /var/pandoras make sure you edit the Pandoras scripts to your directory.

/var/pandoras can be anything, depends on where you do want to put your chroot images (The directory or partition that have enough free space). For Chrome OS it's best on /home/chronos directory and on Android it's best on /storage or /data directory.

```shell
#!/bin/env bash
export dir=#your custom directory, or just leave it if you want to use /var/chroot
```

Keep in mind that the availability and functionality of Bash may vary based on the specific device, Android version, or Chromebook model you are using.

## Install Debootstrap

For Debian based distributions, run:

```shell
sudo apt-get update
sudo apt-get install debootstrap
```

For RHEL, do run:

```shell
sudo yum install debootstrap
# Or
sudo dnf install debootstrap
# Or if you are using OpenSUSE
sudo zypper install debootstrap
```

For Arch based distributions:

```shell
sudo pacman -S debootstrap
```

For other distros (custom debootstrap build):

Don't do this if you can install debootstrap with package manager.

```shell
sudo su -  # As root user
cd /tmp  # Navigate to your tmp directory, or Download directory (any directory for trash data)
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/debootstrap/debootstrap.sh
sh debootstrap.sh
tar xvf debootstrap.tar.gz
mkdir /usr/share/debootstrap
cp debootstrap-*/debootstrap /usr/bin/  # Or can be your another favorite bin directory
cp debootstrap-*/functions /usr/share/debootstrap/
cp -r debootstrap-*/scripts /usr/share/debootstrap/
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/debootstrap/pkgdetails -O /usr/share/debootstrap/pkgdetails
wget https://raw.githubusercontent.com/rafi16jan/universal-chroot/master/debootstrap/ar -O /usr/local/bin/ar # Your favorite bin directory
chmod a+x /usr/share/debootstrap/pkgdetails
chmod a+x /usr/bin/ar
exit  # exit the root user
```

## Setup the Pandoras script

Navigate to your favorite bin directory.

```shell
cd /usr/bin
```

Make a soft link (shortcut) of your scripts file.

```shell
sudo ln -s /var/pandoras/pandoras.sh ./pandoras  # Remember /var/pandoras can be different
ls -l pandoras
```

Symbolic links (symlinks) in Linux always appear with the permissions lrwxrwxrwx, which means they are read, write, and execute for all users, but it doesn't represent the actual permissions of the target file or directory. The permissions of the symlink itself are not relevant in terms of access control.

Create your first chroot image.

```
sudo pandoras create-box
```

Done! Now, to start your chroot just execute `sudo pandoras start-box`.

For more command options excute `pandoras --help`.

## Contributors

### Maintainer

- [@estebanways](https://github.com/estebanways) - Maintainer

### Original Codebase

This project was originally developed by [rafi16jan](https://github.com/rafi16jan). The initial version of this codebase can be found at [Link to Original Code](https://github.com/rafi16jan/universal-chroot).

