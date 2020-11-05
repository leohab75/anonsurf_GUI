#!/bin/bash

#подготовим почву)
rm -rf /tmp/anonsurf

#перемещаем рабочие файлы во временный каталог
mkdir /tmp/anonsurf
mv anonsurf-src /tmp/anonsurf
mv source.sh /tmp/anonsurf
mv remove.sh /tmp/anonsurf
mv Uninstall-Anonsurf.desktop /tmp/anonsurf
mv anon.png /tmp/anonsurf
cp anon.sh /tmp/anonsurf
mv anonsurf.desktop /tmp/anonsurf
mv Uninstall-Anonsurf.desktop /tmp/anonsurf

#установка и настройка
pkexec sh /tmp/anonsurf/source.sh


#проверка файла приложения
desktop-file-validate /usr/share/applications/anonsurf.desktop
desktop-file-validate /usr/share/applications/Uninstall-Anonsurf.desktop


#подчищаем за собой
#rm -rf /tmp/anonsurf
#rm -rf $(pwd)

exit 0;
