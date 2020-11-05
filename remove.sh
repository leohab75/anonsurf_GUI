#!/bin/bash

del=$(zenity --question --text="Удалить 'Anonsurf' с ПК ?? "\
       --width=300 --height=100)


if [[ $del == 0 ]]; then
       pkexec sudo dpkg -P anonsurf

       rm -rf /opt/anonsurf
       pkexec rm -f /usr/share/applictionas/anonsurf.desktop

fi