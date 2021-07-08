#!/bin/bash


export BLUE='\033[1;94m'
export GREEN='\033[1;92m'
export RED='\033[1;91m'
export RESETCOLOR='\033[1;00m'


echo -e "\n $GREEN*$BLUE Определятся версия ОС \n"

if [[ -n  $(cat /etc/os-release |  grep -i debian) || $(cat /etc/os-release |  grep -i ubuntu) ]]; then 
    
    if [[ -n  $(cat /etc/os-release |  grep -i ID=debian) ]]; then

        echo -e "\n $RED -------------"
        echo -e "Relese OS: "
        echo -e "\n $GREEN debian "
        echo -e "\n $RED -------------"
        
        
        release=$(lsb_release -c | awk '{print $ 2}')

    elif [[ -n  $(cat /etc/os-release |  grep -i ubuntu) ]]; then

        echo -e "\n $RED -------------"
        echo -e "Relese OS: "
        echo -e "\n $GREEN ubuntu "
        echo -e "\n $RED -------------"

        release=$(cat /etc/os-release | grep -i UBUNTU_CODENAME | sed -r 's/.{,16}//')
            
    else
          
        echo -e "\n $RED -------------"
        echo -e "Relese OS: "
        echo -e "\n $GREEN debian based: по умолчанию  'stretch'  "
        echo -e "\n $RED -------------"

        release="stretch"
        apt install resolvconf -y

    fi
          
            echo -e "\n$GREEN Добавление репозитория и установка Тор\n$RESETCOLOR"

    apt install apt-transport-https wget zenity aptitude -y
    rm -fv /etc/apt/sources.list.d/tor.list
    echo "deb [arch=amd64] https://deb.torproject.org/torproject.org tor-nightly-master-$release main" > /etc/apt/sources.list.d/tor.list
     
     
     wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import
     gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
     
     
    apt update && apt install deb.torproject.org-keyring -y
    aptitude install tor bleachbit resolvconf -y
    dpkg --configure -a

    
    
elif [[ -n  $(cat /etc/os-release |  grep -i fedora) ]]; then 



  
        echo -e "\n $RED -------------"
        echo -e "Relese OS: "
        echo -e "\n $GREEN fedora | Rhel "
        echo -e "\n $RED -------------\n"

            if [ -f /etc/yum.repos.d/ftor.repo ]; then
            mv -v /tmp/anonsurf/ftor.repo /etc/yum.repos.d/
            fi

   

    echo -e "\n$GREEN Добавление репозитория и установка Тор\n$RESETCOLOR"

    yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
    dnf check-update
    dnf install epel-release -y
    dnf install tor bleachbit zenity -y
   
     
   
        if [ ! -f /etc/network/iptables.rules ]; then 
        mkdir /etc/network
        touch /etc/network/iptables.rules
        fi   
   
   #чиним DNS
   wget http://roy.marples.name/downloads/openresolv/openresolv-3.7.0.tar.bz2
   tar fxjv openresolv-3.7.0.tar.bz2
   cd openresolv-3.7.0
   make
   make install

#elif SUSE | Arch

else 

     echo -e "\n----------------"
     echo -e "\n $RED NOT release "
     echo -e "----------------\n"

     exit 1;

fi


echo -e "\n $GREEN*$BLUE подготовка перед копированием \n$RESETCOLOR"
#подготовим почву
rm -fv /etc/init.d/anonsurf
rm -fv /usr/share/applications/anonsurf.desktop
rm -fv /usr/share/applications/Uninstall-Anonsurf.desktop
rm -fv /etc/tor/torrc.anon 
rm -fv /etc/tor/onion.pac   
rm -fv /etc/systemd/system/anonsurf.service
rm -fv /usr/bin/Anon 
rm -fv /usr/bin/UnAnonsurf
rm -fv /etc/init.d/UnAnDelete
rm -fv /usr/share/pixmaps/anon.png  



echo -e "\n$GREEN*$BLUE копирование в рабочие каталоги \n$RESETCOLOR"
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
if [ -f /etc/tor/torrc ]; then
 mv -v /etc/tor/torrc /etc/tor/torrc.orig
fi
if [ -f /etc/tor/torrc.anon ]; then
 mv -v /etc/tor/torrc.anon /etc/tor/torrc
fi


if [ -f /lib/systemd/system/tor.service ]; then
 rm -fv /lib/systemd/system/tor.service
 mv -v /tmp/anonsurf/tor.service /lib/systemd/system/tor.service
fi 

tor -f /etc/tor/torrc

chmod +x /etc/init.d/anonsurf
chmod +x /usr/share/applications/anonsurf.desktop
chmod +x /usr/share/applications/Uninstall-Anonsurf.desktop 
chmod +x /etc/systemd/system/anonsurf.service
chmod +x /usr/bin/Anon  
chmod +x /usr/bin/UnAnonsurf
chmod +x /etc/init.d/UnAnDelete

update-desktop-database && update-icon-caches /usr/share/pixmaps/*



exit 0;
