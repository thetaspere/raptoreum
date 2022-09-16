
Debian
====================
This directory contains files used to package thetad/theta-qt
for Debian-based Linux systems. If you compile thetad/theta-qt yourself, there are some useful files here.

## theta: URI support ##


theta-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install theta-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your theta-qt binary to `/usr/bin`
and the `../../share/pixmaps/theta128.png` to `/usr/share/pixmaps`

theta-qt.protocol (KDE)

