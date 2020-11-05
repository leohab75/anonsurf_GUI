#!/bin/bash

sudo apt install zenity -y

git clone https://github.com/Und3rf10w/kali-anonsurf.git

cd kali-anonsurf

chmod +x installer.sh

cd ..

./installer.sh

dpkg -i kali-anonsurf.deb

mkdir /opt/anon

cp anon.sh /opt/anon

chmod +x /opt/anon/anon.sh

cp anonsurf.desktop ~/.local/share/applications/

cp anon.png /opt/anon


zenity --question --text="Установить ярлык на рабочий стол ?"\
       --width=300 --height=100

    if [[ $? == 0 ]]; then
        cp ~/.local/share/applications/anonsurf.desktop  ~/'Рабочий стол'
    fi


