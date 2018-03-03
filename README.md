# OS software installation

In FreeBSD, the binary package manager is `pkg`. We will be using it since we need
a convenient way to test if the installed OS is up-to-date.

The following packages will need to be installed:

- pkg (it has to install itself...)
- logrotate
- git
- clamav

# Setup

Run the install.sh script from this directory to install the MCSS software:

If the computer the software is being installed on is a server, pass the `-s` flag at the end.

```
sudo ./install.sh [-s]
```

This installs in /root/mcss.  The MCSS software can be removed with:

```
sudo /root/mcss/uninstall.sh
```

Keep in mind the MCSS software is required in order to remain connected to
the CSE network.  Report any errors to CSE computing staff.

# Assumptions

- We assume that `pf` will be used as the firewall.
- We assume local authentication
- We assume the SSH daemon is already set up and running.

Any divergence from these assumptions will have to be OK'd by the dept who is currently running the network.