[![Shell Linter](https://github.com/estebanways/pandoras/actions/workflows/shell-linter.yml/badge.svg)](https://github.com/estebanways/pandoras/actions/workflows/shell-linter.yml) [![License: GPLv3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# Pandoras

Universal Chroot environment that can be deployed to most Linux distributions, enabling the creation of portable boxes transferable among different hosts.

<img alt="sword-vim" src="./pandoras.jpg?raw=true" width="500" height="320" />

## 🚀 Chroot magic options

- Start a box
- Stop a box
- Create a box
- Delete a box
- Duplicate a box
- Enter a box
- List boxes
- List filesystems
- Upsize a box

## Further aspects

- Mount of custom directories
- Enter the box directly to a specified shell
- Easily customizable source code
- Full Linux, Android, and Chromebook compatibility

## Build a boxes Management System

### Create your Pandoras directory

```shell
cd
git clone git@github.com:estebanways/pandoras.git 
sudo chown -R root:root pandoras/
sudo mv pandoras /var 
```

This is going to create the directories:

`/var/pandoras`: Your Pandoras main directory.
<br />`/var/pandoras/env`: The env directory.
<br />`/var/pandoras/images`: The images directory and also the filesystems configuration directory.
<br />`/var/pandoras/process`: The process directory.
<br />`/var/pandoras/environment`: The chroot environment directory that will be mounted.

If you want to have a main directory instead of /var/pandoras make sure you edit the Pandoras scripts to your directory.

/var/pandoras can be anything, depending on where you do want to put your boxes images (the directory or partition that have enough free space). For Chrome OS it's best on /home/chronos directory and on Android it's best on /storage or /data directory.

```shell
#!/bin/env bash
export dir=#your custom directory, or just leave it if you want to use /var/pandoras
```

Keep in mind that the availability and functionality of Bash may vary based on the specific device, Android version, or Chromebook model you are using.

Basically, Pandoras requires Bash to run itself, while boxes can be created to run different shells like Sh or Bash.

To get Bash, Android users can install an app such as Termux. Chromebook's users can use Bash after the activation of the Developer Mode.

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
```

If you are using OpenSUSE:

```shell
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

Create your first box image.

```
sudo pandoras --create-box
```

Done! Now, to start your box just execute `sudo pandoras --start-box`.

For more command options and shortcuts execute `pandoras --help`.

## Advanced topics

### Modify mount points

You can modify the default mount points in the script includes/create_box.sh before creating a new Pandoras box. These changes will remain until the next modification of the file.

For example, to add a mount point for /dev/pts:

```shell
sudo nano /var/pandoras/includes/create_box.sh
```

Uncomment the next line:

```shell
  #echo "/dev/pts $dir/environment/dev/pts" >> "$dir/images/$chroot.filesystems.mnt"
```

Save changes and then create your new box.

The mount points will be stored in a brand-new Pandoras box file <box-name>.filesystems.mnt.

You can also modify the mount points in the Pandoras Box file <box-name>.filesystems.mnt before starting the box. These changes will remain until the next modification of the file.

For example, add a new mount point like this:

```shell
/home/my_user/tmp /var/pandoras/environment/mnt
```

### Enter a box using Sh as shell

To enter your box using Sh instead of Bash (Pandoras default) as shell, modify the script includes/enter_box.sh like this:

```shell
  # Enter the chroot using the shell defined in the main system
  #chroot $dir/environment /bin/su -

  # Enter the chroot using sh as shell
  chroot $dir/environment /bin/sh
```

## Extras

### Upsize boxes

To be able to upsize chroots with Pandoras, install qemu-utils. For example:

```shell
sudo apt-get install qemu-utils
```

## Contributors

### Maintainer

- [@estebanways](https://github.com/estebanways) - Maintainer

### Original Codebase

This project was originally developed by [rafi16jan](https://github.com/rafi16jan) in Sh. The initial version of this codebase can be found at [rafi16jan/universal-chroot](https://github.com/rafi16jan/universal-chroot).
