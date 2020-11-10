#!/bin/bash

# git clone 

#cd git clone


rm -rf /tmp/anonsurf

#временный рабочий катаолог
mkdir /tmp/anonsurf

cp -v  $(pwd)/source/anonsurf.desktop /tmp/anonsurf/
cp -v  $(pwd)/source/Uninstall-Anonsurf.desktop /tmp/anonsurf/
cp -v  $(pwd)/source/torrc.anon /tmp/anonsurf/
cp -v  $(pwd)/source/onion.pac /tmp/anonsurf/
cp -v  $(pwd)/source/anonsurf.service /tmp/anonsurf/
cp -v  $(pwd)/source/Anon /tmp/anonsurf/
cp -v  $(pwd)/source/UnAnonsurf /tmp/anonsurf/
cp -v  $(pwd)/source/UnAnDelete.sh /tmp/anonsurf/
cp -v  $(pwd)/source/anonsurf.sh /tmp/anonsurf/
cp -v  $(pwd)/source/anon.png /tmp/anonsurf/

# Добавляем репозитории и
# устанавливаем Тор
pkexec bash $(pwd)/release.sh 



#проверка файла приложения
desktop-file-validate /usr/share/applications/anonsurf.desktop
desktop-file-validate /usr/share/applications/Uninstall-Anonsurf.desktop
install -vdm755 /usr/share/applications && update-desktop-database
update-icon-caches /usr/share/pixmaps/*

#ярлык на рабочий стол
ln -s  /usr/share/applications/anonsurf.desktop   /home/$USER/'Рабочий стол'/Anonsurf




#postrm
# if [ -e /etc/tor/torrc.orig ]; then
#  mv /etc/tor/torrc.orig /etc/tor/torrc
# fi



exit 0;


