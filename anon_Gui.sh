#!/bin/bash

pkexec sudo apt install zenity -y

git clone https://github.com/Und3rf10w/kali-anonsurf.git

cd kali-anonsurf

pkexec sudo chmod +x installer.sh

pkexec ./installer.sh

mkdir ~/anonsurf

cd ..

cp anon.sh ~/anonsurf

pkexec sudo chmod +x ~/anonsurf/anon.sh

cp anonsurf.desktop ~/.local/share/applications/

cp anon.png ~/anonsurf


zenity --question --text="Установить ярлык на рабочий стол ?"\
       --width=300 --height=100

    if [[ $? == 0 ]]; then
       cp ~/.local/share/applications/anonsurf.desktop  ~/'Рабочий стол'
    fi


