#!/bin/bash

del=$(zenity --question --text="Удалить 'Anonsurf' с ПК ?? "\
       --width=300 --height=100)


if [[ $? == 0 ]]; then
       pkexec sudo dpkg -P anonsurf.sh

       rm -rf ~/anon
       rm -f ~/.local/share/applictionas/anonsurf.desktop

fi