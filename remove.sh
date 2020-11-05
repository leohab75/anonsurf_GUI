#!/bin/bash

del=$(zenity --question --text="Удалить 'Anonsurf' с ПК ?? "\
       --width=300 --height=100)


if [[ $? == 0 ]]; then
       pkexec sudo dpkg -P anonsurf
       pkexec rm -rf /opt/anonsurf

fi