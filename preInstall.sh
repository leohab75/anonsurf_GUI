#!/bin/bash

if [[ -n $(cat /etc/os-release |grep ubuntu) ]]
then
      pkexec sudo apt-add-repository ppa:i2p-maintainers/i2p

else 
      pkexec sudo echo "deb https://deb.i2p2.de/ buster main" > /ete/apt/sources.list.d/i2p.list
      curl -o i2p-debian-repo.key.asc https://geti2p.net/_static/i2p-debian-repo.key.asc
      gpg -n --import --import-options import-show i2p-debian-repo.key.asc
      pkexec sudo apt-key add i2p-debian-repo.key.asc

fi

pkexec sudo apt update -y
pkexec sudo apt install -y zenity i2p secure-delete tor i2p i2p-keyring secure-delete tor
 


pkexec sudo dpkg-deb -b $(pwd)/anonsurf-src anonsurf.deb
pkexec sudo dpkg -i anonsurf.deb || (pkexec sudo apt -f install && pkexec sudo dpkg -i anonsurf.deb) 

mkdir ~/anonsurf


cp anon.sh ~/anonsurf

pkexec sudo chmod +x ~/anonsurf/anon.sh

cp anonsurf.desktop ~/.local/share/applications/

cp anon.png ~/anonsurf

cp remove.sh ~/anon


icon=$(zenity --question --text="Установить ярлык на рабочий стол ?"\
       --width=300 --height=100)

    if [[ $? == 0 ]]; then
       cp ~/.local/share/applications/anonsurf.desktop  ~/'Рабочий стол'
    fi

cd ..

rm -rf anonsurf_GUI

exit 0;