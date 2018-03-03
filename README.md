# OS software installation

In FreeBSD, the binary package manager is `pkg`. Otherwise, software can be compiled with the `ports` setup. Documentation about these two systems can be found online in the [FreeBSD Handbook](https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/ports.html).

The following packages will need to be installed:

- logrotate
- git

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
