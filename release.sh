#!/bin/bash

export GREEN='\033[1;92m'
export RED='\033[1;91m'
export RESETCOLOR='\033[1;00m'

#Качаем и устанавливаем Тор

if [[ -n  $(cat /etc/os-release |  grep -i debian) || $(cat /etc/os-release |  grep -i ubuntu) ]]; then 
    
    if [[ -n  $(cat /etc/os-release |  grep -i ID=debian) ]]; then

        echo -e "\n $RED -------------"
        echo -e "Relese OS: "
        echo -e "\n $GREEN debian "
        echo -e "\n $RED -------------"
        
        
        release=$(lsb_release -c | awk '{print $ 2}')

    else

        echo -e "\n $RED -------------"
        echo -e "Relese OS: "
        echo -e "\n $GREEN ubuntu "
        echo -e "\n $RED -------------"

        release=$(cat /etc/os-release | grep -i UBUNTU_CODENAME | sed -r 's/.{,16}//')
            
    fi


    apt install apt-transport-https wget zenity aptitude -y
    rm -fv /etc/apt/sources.list.d/tor.list
    echo "deb https://deb.torproject.org/torproject.org $release main" > /etc/apt/sources.list.d/tor.list
     
     
     wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import
     gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
     
     
    apt update && apt deb.torproject.org-keyring -y
    aptutude install tor  -y
    dpkg --configure -a

    
    
elif [[ -n $(cat /etc/os-release |  grep -i ID=centos) || $(cat /etc/os-release |  grep -i ID=rhel) || $(cat /etc/os-release |  grep -i ID=fedora) ]]; then 



    if [[ -n $(cat /etc/os-release |  grep -i ID=fedora) ]] ;then


        echo -e "\n $RED -------------"
        echo -e "Relese OS: "
        echo -e "\n $GREEN fedora"
        echo -e "\n $RED -------------\n"

            if [ -f /etc/yum.repos.d/ftor.repo ]; then
            mv /tmp/anonsurf/ftor.repo /etc/yum.repos.d/
            fi

    else

        echo -e "\n $RED -------------"
        echo -e "Relese OS: "
        echo -e "\n $GREEN CentOs | rhel"
        echo -e "\n $RED -------------\n"

            if [ -f /etc/yum.repos.d/ctor.repo ]; then
            mv /tmp/anonsurf/ctor.repo /etc/yum.repos.d/
            fi


    fi

     
    dnf update -y
    yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
    dnf config-manager --set-enabled PowerTools -y
    dnf install tor dpkg -y
    dnf install epel-release -y 
   
        if [ -f /etc/network/ ];then 
        mkdir /etc/network
        toch /etc/network/iptables.rules
        fi   



#elif SUSE | Arch

else 

     echo -e "\n----------------"
     echo -e "\n $RED NOT release "
     echo -e "----------------\n"

     exit 1;

fi


echo -e " $GREEN*$BLUE"
#подготовим почву
rm -fv /etc/init.d/anonsurf
rm -fv /usr/share/applications/anonsurf.desktop
rm -fv /usr/share/applications/Uninstall-Anonsurf.desktop
rm -fv /etc/tor/torrc.anon 
rm -fv /etc/tor/onion.pac   
rm -fv /etc/systemd/system/anonsurf.service
rm -fv /usr/bin/Anon 
rm -fv /us/bin/UnAnonsurf
rm -fv /etc/init.d/UnAnDelete
rm -fv /usr/share/pixmaps/anon.png  


#распихиваем по каталогам
cp -v /tmp/anonsurf/anonsurf.desktop /usr/share/applications/
cp -v /tmp/anonsurf/Uninstall-Anonsurf.desktop /usr/share/applications/
cp -v /tmp/anonsurf/torrc.anon /etc/tor/
cp -v /tmp/anonsurf/onion.pac /etc/tor/
cp -v /tmp/anonsurf/anonsurf.service /etc/systemd/system/
cp -v /tmp/anonsurf/Anon /usr/bin/
cp -v /tmp/anonsurf/UnAnonsurf /usr/bin/
cp -v /tmp/anonsurf/UnAnDelete /etc/init.d/
cp -v /tmp/anonsurf/anonsurf /etc/init.d/
cp -v /tmp/anonsurf/anon.png /usr/share/pixmaps/

      

#postinst
if [ -e /etc/tor/torrc ]; then
 mv /etc/tor/torrc /etc/tor/torrc.orig
fi
if [ -e /etc/tor/torrc.anon ]; then
 mv /etc/tor/torrc.anon /etc/tor/torrc
fi

systemctl start tor
tor -f /etc/tor/torrc

if [ -f /lib/systemd/system/tor.service ]; then
 rm -fv /lib/systemd/system/tor.service
 mv /tmp/anonsurf/tor.service /lib/systemd/system/tor.service
fi 

chmod +x /etc/init.d/anonsurf
chmod +x /usr/share/applications/anonsurf.desktop
chmod +x /usr/share/applications/Uninstall-Anonsurf.desktop 
chmod +x /etc/systemd/system/anonsurf.service
chmod +x /usr/bin/Anon  
chmod +x /usr/bin/UnAnonsurf
chmod +x /etc/init.d/UnAnDelete
chmod +x /usr/share/pixmaps/anon.png  

echo -e "\n $GREEN Установка звершена с кодом: $RED $? $RESETCOLOR\n"

exit 0;
