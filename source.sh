#!/bin/bash

apt install -y curl 

if [[ -n $(cat /etc/os-release |grep ubuntu) ]]; then
      apt-add-repository ppa:i2p-maintainers/i2p

else 
      echo "deb https://deb.i2p2.de/ buster main" > /etc/apt/sources.list.d/i2p.list
      curl -o i2p-debian-repo.key.asc https://geti2p.net/_static/i2p-debian-repo.key.asc
      gpg -n --import --import-options import-show i2p-debian-repo.key.asc
      apt-key add i2p-debian-repo.key.asc

fi

apt update -y
apt install -y gnome-terminal zenity i2p secure-delete tor i2p i2p-keyring secure-delete tor
 

dpkg-deb -b /tmp/anonsurf/anonsurf-src anonsurf.deb
dpkg -i anonsurf.deb || (apt -f install && dpkg -i anonsurf.deb) 



mkdir /opt/anonsurf

cp anon.sh /opt/anonsurf
chmod +x /opt/anonsurf/anon.sh
cp /tmp/anonsurf/anonsurf.desktop /usr/share/applications/
cp anon.png /opt/anonsurf
cp /tmp/anonsurf/remove.sh   
chmod +x /opt/remove.sh
cp Uninstall-Anonsurf.desktop   /usr/share/applications/

exit 0;