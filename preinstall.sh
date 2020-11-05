#!/bin/bash

# For upgrades and sanity check, remove any existing i2p.list file
rm -f /etc/apt/sources.list.d/i2p.list

if [[ -n $(cat /etc/os-release |grep ubuntu) ]]
then
      pkexec sudo apt-add-repository ppa:i2p-maintainers/i2p

else 
      pkexec sudo echo "deb https://deb.i2p2.de/ buster main" > /ete/apt/sources.list.d/i2p.list
      curl -o i2p-debian-repo.key.asc https://geti2p.net/_static/i2p-debian-repo.key.asc
      gpg -n --import --import-options import-show i2p-debian-repo.key.asc
      pkexec sudo apt-key add i2p-debian-repo.key.asc

fi

pkexec sudo apt update -y
pkexec sudo apt install -y zenity i2p secure-delete tor i2p i2p-keyring secure-delete tor
 
 exit 0;