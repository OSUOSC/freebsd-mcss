#!/bin/bash

ROOT=/root/mcss

# Remove MCSS software.
echo
echo "Uninstalling MCSS software..."
echo
rm -rf $ROOT

# Remove log file rotation.
echo "Uninstalling MCSS logrotate.d configuration..."
echo
rm -f /usr/local/etc/logrotate.d/mcss

# Restore original authentication settings.
echo "Restoring original passwd pam.d settings..."
echo
mv /etc/pam.d/passwd.orig /etc/pam.d/passwd 2>/dev/null
mv /etc/pam.d/system.orig /etc/pam.d/system 2>/dev/null

# Remove MCSS cron jobs.
echo "Removing MCSS root crontab..."
echo
crontab -u root -l >/tmp/root.orig.$$
grep -v $ROOT /tmp/root.orig.$$ >/tmp/root.new.$$
crontab -u root /tmp/root.new.$$
rm /tmp/root.orig.$$ /tmp/root.new.$$
echo "Crontab"
echo "-------"
crontab -u root -l
echo
