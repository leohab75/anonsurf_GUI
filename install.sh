#!/bin/bash

#подготовим почву)
rm -rf /tmp/anonsurf
rm -f /home/$USER/'Рабочий стол'/anonsurf.desktop


#перемещаем рабочие файлы во временный каталог
mkdir /tmp/anonsurf
mv -f $(pwd)/anonsurf-src /tmp/anonsurf
mv -f $(pwd)/source.sh /tmp/anonsurf
mv -f $(pwd)/remove.sh /tmp/anonsurf
mv -f $(pwd)/Uninstall-Anonsurf.desktop /tmp/anonsurf
mv -f $(pwd)/anon.png /tmp/anonsurf
mv -f $(pwd)/anon.sh /tmp/anonsurf
cp    $(pwd)/anonsurf.desktop /home/$USER/'Рабочий стол'
mv -f $(pwd)/anonsurf.desktop /tmp/anonsurf
mv -f $(pwd)/Uninstall-Anonsurf.desktop /tmp/anonsurf
mv -f $(pwd)/delete.sh /tmp/anonsurf

#установка и настройка
pkexec sh /tmp/anonsurf/source.sh


#проверка файла приложения
desktop-file-validate /usr/share/applications/anonsurf.desktop
desktop-file-validate /usr/share/applications/Uninstall-Anonsurf.desktop
install -vdm755 /usr/share/applications && update-desktop-database


sleep 10

echo "Готово"

#подчищаем за собой
rm -rf /tmp/anonsurf
cd ..
rm -rf $(pwd)/anonsurf_GUI

exit 0;
