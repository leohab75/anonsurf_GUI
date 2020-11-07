#!/bin/bash



remote=$(zenity --question --text="Удалить 'Anonsurf' с ПК ?? "\
       --width=300 --height=100) 
       
if [ $? = 0 ]; then
       
       rm -f /home/$USER/'Рабочий стол'/anon_link
       pkexec sh /opt/anonsurf/delete.sh
fi