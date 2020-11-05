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
 

git clone https://github.com/Und3rf10w/kali-anonsurf.git


cd kali-anonsurf/kali-anonsurf-deb-src/

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
 

rm -f installer.sh


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