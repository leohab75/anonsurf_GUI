#!/bin/bash

sh ip2install.sh

git clone https://github.com/Und3rf10w/kali-anonsurf.git

cd kali-anonsurf


pkexec sudo dpkg-deb -b kali-anonsurf-deb-src/ kali-anonsurf.deb # Build the deb package
pkexec sudo dpkg -i kali-anonsurf.deb || (apt-get -f install && dpkg -i kali-anonsurf.deb) 

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


exit 0;