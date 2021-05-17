#!/bin/bash

export GREEN='\033[1;92m'
export RED='\033[1;91m'
export RESETCOLOR='\033[1;00m'
export BLUE='\033[1;94m'

if [ -f /tmp/anonsurf ]; then
rm -rfv /tmp/anonsurf
fi


mkdir /tmp/anonsurf
echo -e "\n$GREEN*$BLUE миграция во временный каталог \n$RESETCOLOR"

cp -rv  $(pwd)/source/*  /tmp/anonsurf/

# Добавляем репозитории и
# устанавливаем Тор
pkexec bash $(pwd)/release.sh 



#проверка файла приложения
desktop-file-validate /usr/share/applications/anonsurf.desktop
desktop-file-validate /usr/share/applications/Uninstall-Anonsurf.desktop

#ярлык на рабочий стол
if  [ ! -f /home/$USER/'Рабочий стол'/Anonsurf ]; then
ln -s  /usr/share/applications/anonsurf.desktop   /home/$USER/'Рабочий стол'/Anonsurf
fi 

echo -e "\n$GREEN*$BLUE Удаляется временный каталог \n$RESETCOLOR"
rm -rfv /tmp/anonsurf


exit 0;


