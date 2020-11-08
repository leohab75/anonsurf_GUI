#!/bin/bash

#подготовим почву)
rm -rf /tmp/anonsurf


#перемещаем рабочие файлы во временный каталог
mkdir /tmp/anonsurf
mv -f $(pwd)/anonsurf-src /tmp/anonsurf
mv -f $(pwd)/source.sh /tmp/anonsurf

#установка и настройка
pkexec sh /tmp/anonsurf/source.sh


#проверка файла приложения
desktop-file-validate /usr/share/applications/anonsurf.desktop
desktop-file-validate /usr/share/applications/Uninstall-Anonsurf.desktop
install -vdm755 /usr/share/applications && update-desktop-database
update-icon-caches /usr/share/pixmaps/*

#ярлык на рабочий стол
ln -s  /usr/share/applications/anonsurf.desktop   /home/$USER/'Рабочий стол'/Anonsurf


#подчищаем за собой
rm -rf /tmp/anonsurf
cd ..
rm -rf $(pwd)/anonsurf_GUI

exit 0;
