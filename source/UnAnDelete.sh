#!/bin/bash
rm -fv /usr/share/applications/anonsurf.desktop   /home/$USER/'Рабочий стол'/Anonsurf

$RED
rm -fv /etc/init.d/anonsurf.sh
rm -fv /usr/share/applications/anonsurf.desktop
rm -fv /usr/share/applications/Uninstall-Anonsurf.desktop
rm -fv /etc/tor/torrc.anon 
rm -fv /etc/tor/onio.pac   
rm -fv /etc/systemd/system/anonsurf.service
rm -fv /usr/bin/Anon  
rm -fv /us/bin/UnAnonsurf
rm -fv /etc/init.d/UnAnDelete
rm -fv /usr/share/pixmaps/anon.png  

if [[ -n  $(cat /etc/os-release |  grep -i ID=debian) || $(cat /etc/os-release |  grep -i ID=ubuntu) ]] ;
then
    aptitude purge tor -y
else
    dnf remove tor -y 
fi 

exit 0;