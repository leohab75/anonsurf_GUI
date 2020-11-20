#!/bin/bash

export GREEN='\033[1;92m'
export RED='\033[1;91m'
export RESETCOLOR='\033[1;00m'
export BLUE='\033[1;94m'

rm -rf /tmp/anonsurf

mkdir /tmp/anonsurf
echo -e "\n$GREEN*$BLUE миграция во временный каталог \n$RESETCOLOR"

cp -v  $(pwd)/source/anonsurf.desktop /tmp/anonsurf/
cp -v  $(pwd)/source/Uninstall-Anonsurf.desktop /tmp/anonsurf/
cp -v  $(pwd)/source/torrc.anon /tmp/anonsurf/
cp -v  $(pwd)/source/onion.pac /tmp/anonsurf/
cp -v  $(pwd)/source/anonsurf.service /tmp/anonsurf/
cp -v  $(pwd)/source/Anon /tmp/anonsurf/
cp -v  $(pwd)/source/UnAnonsurf /tmp/anonsurf/
cp -v  $(pwd)/source/UnAnDelete /tmp/anonsurf/
cp -v  $(pwd)/source/anonsurf /tmp/anonsurf/
cp -v  $(pwd)/source/anon.png /tmp/anonsurf/
cp -v  $(pwd)/source/tor.service /tmp/anonsurf/
cp -v  $(pwd)/source/ctor.repo /tmp/anonsurf/
cp -v  $(pwd)/source/ftor.repo /tmp/anonsurf/


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

echo -e "\n$GREEN*$BLUE Удаляется временный каталог \n$RESETCOLOR"
rm -rfv /tmp/anonsurf


echo -e "\n $GREEN Установка звершена с кодом: $RED $? $RESETCOLOR\n"

exit 0;


