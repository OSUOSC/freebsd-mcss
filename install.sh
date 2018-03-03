#!/bin/bash

ROOT=/root/mcss
SERVER=0

if [ "$1" = "-s" ]; then
    SERVER=1
fi

# Install MCSS software.
echo
echo "Installing MCSS software..."
echo
mkdir -p $ROOT
cp mcss anti-malware uninstall.sh malware-exclude $ROOT
chmod 755 $ROOT/mcss
chmod 755 $ROOT/anti-malware
chmod 755 $ROOT/uninstall.sh
chmod 644 $ROOT/malware-exclude

# Setup log files and rotation.
touch /var/log/mcss.log
touch /var/log/anti-malware.log
echo "Installing MCSS logrotate.d configuration..."
echo
cp logrotate.d/mcss /usr/local/etc/logrotate.d
chmod 644 /usr/local/etc/logrotate.d/mcss

# Setup proper authentication settings.
# https://www.freebsd.org/doc/en_US.ISO8859-1/articles/pam/
echo "Installing passwd pam.d settings..."
echo
cp /etc/pam.d/passwd /etc/pam.d/passwd.orig
cp /etc/pam.d/system /etc/pam.d/system.orig
cp pam.d/passwd /etc/pam.d
chmod 644 /etc/pam.d/passwd
cp pam.d/system /etc/pam.d
chmod 644 /etc/pam.d/system
# This is for password expiry. This file keeps the last n passwords from the users' password changes
touch /etc/security/opasswd
chmod 600 /etc/security/opasswd

# Schdule cron jobs to run.
echo "Adding MCSS root crontab..."
echo
crontab -u root -l >crontab/root.orig
grep -v $ROOT crontab/root.orig >crontab/root.new
cat crontab/root >>crontab/root.new
# I am trying to insert some variation in the times the MCSS check script
# is run on different machines to aviod overloading the CSE Red Hat Proxy
# or other distribution update servers.  I am using the current time's
# minute value for the hourly cron job's minute setting.  The 15 minute
# bump is so it won't run immedately after installed in case the user
# is running it interactively right away to test.
MIN=`date -v +15M +%M`
sed -i "s/MIN/$MIN/" crontab/root.new
crontab -u root crontab/root.new
rm crontab/root.orig crontab/root.new
echo "Crontab"
echo "-------"
crontab -u root -l
echo

if [ $SERVER -eq 1 ]; then
    echo "Setting server mode..."
    sed -i 's/SERVER=0/SERVER=1/' $ROOT/mcss
    sed -i 's/SERVER=0/SERVER=1/' $ROOT/anti-malware
    echo
fi
