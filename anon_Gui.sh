#!/bin/bash

sudo apt install zenity -y

git clone https://github.com/Und3rf10w/kali-anonsurf.git

cd kali-anonsurf

chmod +x installer.sh

./installer.sh

dpkg -i kali-anonsurf.deb

sudo -u $USER mkdir /opt/anon

cd ..

sudo -u $USER cp anon.sh /opt/anon

chmod +x /opt/anon/anon.sh

sudo -u $USER cp anonsurf.desktop ~/.local/share/applications/

sudo -u $USER cp anon.png /opt/anon


zenity --question --text="Установить ярлык на рабочий стол ?"\
       --width=300 --height=100

    if [[ $? == 0 ]]; then
        sudo -u $USER cp ~/.local/share/applications/anonsurf.desktop  ~/'Рабочий стол'
    fi


