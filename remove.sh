#!/bin/bash

del=$(zenity --question --text="Удалить 'Anonsurf' с ПК ?? "\
       --width=300 --height=100)


if [[ $? == 0 ]]; then
       
       rm -f /home/$USER/'Рабочий стол'/anonsurf.desktop
       pkexec sh /opt/anonsurf/delete.sh
fi