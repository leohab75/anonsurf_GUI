#!/bin/bash

apt install -y curl 

#подготоим почву
rm -f /etc/apt/sources.list.d/i2p.list
rm -rf /opt/anonsurf
rm -f /usr/share/applications/Anonsurf.desktop
rm -f /usr/share/applications/Uninstall-Anonsurf.desktop


#устанавливаем репозитории для Тора
if [[ -n $(cat /etc/os-release |grep ubuntu) ]]; then
      apt-add-repository ppa:i2p-maintainers/i2p

else 
      echo "deb https://deb.i2p2.de/ buster main" > /etc/apt/sources.list.d/i2p.list
      curl -o i2p-debian-repo.key.asc https://geti2p.net/_static/i2p-debian-repo.key.asc
      gpg -n --import --import-options import-show i2p-debian-repo.key.asc
      apt-key add i2p-debian-repo.key.asc

fi

#ставим Тор
apt update -y
apt install -y zenity i2p secure-delete tor i2p i2p-keyring secure-delete tor
 
#собирае и устанавливаем .deb
dpkg-deb -b /tmp/anonsurf/anonsurf-src anonsurf.deb
dpkg -i anonsurf.deb || (apt -f install && dpkg -i anonsurf.deb) 


#копируем в рабичие каталоги
mkdir /opt/anonsurf

cp -f /tmp/anonsurf/anon.sh  /opt/anonsurf
chmod +x /opt/anonsurf/anon.sh
cp -f /tmp/anonsurf/anonsurf.desktop /usr/share/applications/
chmod +x /usr/share/applications/anonsurf.desktop
cp -f /tmp/anonsurf/anon.png /usr/share/icon/
cp -f /tmp/anonsurf/remove.sh  /opt/anonsurf/remove.sh   
chmod +x /opt/anonsurf/remove.sh
cp -f /tmp/anonsurf/Uninstall-Anonsurf.desktop   /usr/share/applications/
chmod +x /usr/share/applications/Uninstall-Anonsurf.desktop


exit 0;