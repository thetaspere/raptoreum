Sample init scripts and service configuration for thetad
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/thetad.service:    systemd service unit configuration
    contrib/init/thetad.openrc:     OpenRC compatible SysV style init script
    contrib/init/thetad.openrcconf: OpenRC conf.d file
    contrib/init/thetad.conf:       Upstart service configuration file
    contrib/init/thetad.init:       CentOS compatible SysV style init script

Service User
---------------------------------

All three Linux startup configurations assume the existence of a "thetacore" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes thetad will be set up for the current user.

Configuration
---------------------------------

At a bare minimum, thetad requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, thetad will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that thetad and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If thetad is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running thetad without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/theta.conf`.

Paths
---------------------------------

### Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/thetad`  
Configuration file:  `/etc/thetacore/theta.conf`  
Data directory:      `/var/lib/thetad`  
PID file:            `/var/run/thetad/thetad.pid` (OpenRC and Upstart) or `/var/lib/thetad/thetad.pid` (systemd)  
Lock file:           `/var/lock/subsys/thetad` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the thetacore user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
thetacore user and group.  Access to theta-cli and other thetad rpc clients
can then be controlled by group membership.

### Mac OS X

Binary:              `/usr/local/bin/thetad`  
Configuration file:  `~/Library/Application Support/ThetaCore/theta.conf`  
Data directory:      `~/Library/Application Support/ThetaCore`
Lock file:           `~/Library/Application Support/ThetaCore/.lock`

Installing Service Configuration
-----------------------------------

### systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start thetad` and to enable for system startup run
`systemctl enable thetad`

### OpenRC

Rename thetad.openrc to thetad and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/thetad start` and configure it to run on startup with
`rc-update add thetad`

### Upstart (for Debian/Ubuntu based distributions)

Drop thetad.conf in /etc/init.  Test by running `service thetad start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

### CentOS

Copy thetad.init to /etc/init.d/thetad. Test by running `service thetad start`.

Using this script, you can adjust the path and flags to the thetad program by
setting the THETAD and FLAGS environment variables in the file
/etc/sysconfig/thetad. You can also use the DAEMONOPTS environment variable here.

### Mac OS X

Copy org.theta.thetad.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.theta.thetad.plist`.

This Launch Agent will cause thetad to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run thetad as the current user.
You will need to modify org.theta.thetad.plist if you intend to use it as a
Launch Daemon with a dedicated thetacore user.

Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
