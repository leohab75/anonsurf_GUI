#!/bin/bash

export GREEN='\033[1;92m'
export RED='\033[1;91m'

#Качаем и устанавливаем Тор

if [[ -n  $(cat /etc/os-release |  grep -i ID=debian) || $(cat /etc/os-release |  grep -i ID=ubuntu) ]] ;
then 

    echo -e "\n $RED -------------"
    echo -e "Relese OS: "
    echo -e "\n $GREEN debian or ubuntu"
    echo -e "\n $RED -------------"
    
    rm -f /etc/apt/sources.list.d/tor.list
    release=$(lsb_release -c | awk '{print $ 2}')
    
    apt install apt-transport-https wget zenity aptitude -y
    
    echo "deb https://deb.torproject.org/torproject.org $release main" > /etc/apt/sources.list.d/tor.list
     
     
     wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import
     gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
     
     
    apt update && apt install tor deb.torproject.org-keyring -y && apt install -f
    dpkg --configure -a
    
elif [[ -n $(cat /etc/os-release |  grep -i ID=centos) || $(cat /etc/os-release |  grep -i ID=rhel) ]] ;
then 

    echo -e "\n $RED -------------"
    echo -e "Relese OS: "
    echo -e "\n $GREEN or rhel"
    echo -e "\n $RED -------------"
    
    dnf install epel-release -y
    mv ctor.repo /etc/yum.repos.d/
    dnf install tor dpkg -y
   
    
elif [[ -n $(cat /etc/os-release |  grep -i ID=fedora) ]] ;
then
    
    echo -e "\n $RED -------------"
    echo -e "Relese OS: "
    echo -e "\n $GREEN fedora"
    echo -e "\n $RED -------------"
    
    dnf install epel-release -y
    mv ftor.repo /etc/yum.repos.d/
    dnf install tor dpkg -y
    
else 

     echo -e "----------------"
     echo -e "\n $RED NOT release"
     echo -e "----------------"

     exit 1;

fi

$BLUE
#подготовим почву
rm -fv /etc/init.d/anonsurf.sh
rm -fv /usr/share/applications/anonsurf.desktop
rm -fv /usr/share/applications/Uninstall-Anonsurf.desktop
rm -fv /etc/tor/torrc.anon 
rm -fv /etc/tor/onion.pac   
rm -fv /etc/systemd/system/anonsurf.service
rm -fv /usr/bin/Anon 
rm -fv /us/bin/UnAnonsurf.sh
rm -fv /etc/init.d/UnAnDelete.sh
rm -fv /usr/share/pixmaps/anon.png  


#распихиваем по каталогам
cp -v /tmp/anonsurf/anonsurf.desktop /usr/share/applications/
cp -v /tmp/anonsurf/Uninstall-Anonsurf.desktop /usr/share/applications/
cp -v /tmp/anonsurf/torrc.anon /etc/tor/
cp -v /tmp/anonsurf/onion.pac /etc/tor/
cp -v /tmp/anonsurf/anonsurf.service /etc/systemd/system/
cp -v /tmp/anonsurf/Anon /usr/bin/
cp -v /tmp/anonsurf/UnAnonsurf /usr/bin/
cp -v /tmp/anonsurf/UnAnDelete.sh /etc/init.d/
cp -v /tmp/anonsurf/anonsurf.sh /etc/init.d/
cp -v /tmp/anonsurf/anon.png /usr/share/pixmaps/



#postinst
if [ -e /etc/tor/torrc ]; then
 mv /etc/tor/torrc /etc/tor/torrc.orig
fi
if [ -e /etc/tor/torrc.anon ]; then
 mv /etc/tor/torrc.anon /etc/tor/torrc
fi

tor -f /etc/tor/torrc

chmod +x /etc/init.d/anonsurf
chmod +x /usr/share/applications/anonsurf.desktop
chmod +x /usr/share/applications/Uninstall-Anonsurf.desktop
chmod +x /etc/tor/torrc.anon 
chmod +x /etc/tor/onion.pac   
chmod +x /etc/systemd/system/anonsurf.service
chmod +x /usr/bin/Anon  
chmod +x /usr/bin/UnAnonsurf
chmod +x /etc/init.d/UnAnDelete.sh
chmod +x /usr/share/pixmaps/anon.png  

exit 0;
