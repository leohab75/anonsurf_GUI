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
        
        #Добавление ключей cloudfare "facal"
        echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/ focal main' | sudo tee /etc/apt/sources.list.d/cloudflare-main.list
        curl https://pkg.cloudflare.com/cloudflare-main.gpg -o /usr/share/keyrings/cloudflare-main.gpg

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

        release="buster"

    fi
          
            echo -e "\n$GREEN Добавление репозитория и установка Тор\n$RESETCOLOR"

    apt update && apt install tor bleachbit zenity obfs4proxy libc6 nyx wget -y
    apt install libnotify-bin onioncircuits connect-proxy onionshare torsocks tor-geoipdb -y
    
    #cloudfare daemon
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    dpkg -i cloudflared-linux-amd64.deb
    rm cloudflared-linux-amd64.deb
    
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
    dnf install tor bleachbit zenity obfs4proxy obfs4proxy libc6 nyx wget -y
    dnf install libnotify-bin onioncircuits connect-proxy onionshare torsocks tor-geoipdb -y
    
    #cloudfare
    
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-x86_64.rpm
    rpm install cloudflared-linux-x86_64.rpm
    rm cloudflared-linux-x86_64.rpm
   
     
   
        if [ ! -f /etc/network/iptables.rules ]; then 
        mkdir /etc/network
        touch /etc/network/iptables.rules
        fi   
   
   

elif [[ -n  $(cat /etc/os-release |  grep -i arch) ]]; then 



  
        echo -e "\n $RED -------------"
        echo -e "Relese OS: "
        echo -e "\n $GREEN Arch Linux | Manjaro "
        echo -e "\n $RED -------------\n"

            

   

    echo -e "\n$GREEN установка Тор\n$RESETCOLOR"

        sudo pacman -Sy --noconfirm tor torsocks bleachbit zenity  obfs4proxy libc6 nyx wget
        sudo pacman -Sy --noconfirm libnotify-bin onioncircuits connect-proxy onionshare torsocks tor-geoipdb 

        #cloudfare
        wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
        mv cloudflared-linux-amd64 cloudflared
        mv cloudflared /usr/local/bin/cloudflared
        chmod +x /usr/local/bin/cloudflared
        
        
        if [ ! -f /etc/init.d ]; then 
        mkdir /etc/init.d
        fi   

        if [ ! -f /etc/network/iptables.rules ]; then 
        mkdir /etc/network
        touch /etc/network/iptables.rules
        fi   




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
rm -rf /etc/init.d/Anon_country
rm -rf /usr/lib/anonsurf
rm -rf /usr/bin/dnstool
rm -rf /etc/anonsurf



mkdir /usr/lib/anonsurf/
mkdir /etc/anonsurf/

echo -e "\n$GREEN*$BLUE копирование в рабочие каталоги \n$RESETCOLOR"
cp -v /tmp/Anonsurf_Gui/source/anonsurf.desktop /usr/share/applications/
cp -v /tmp/Anonsurf_Gui/source/Uninstall-Anonsurf.desktop /usr/share/applications/
cp -v /tmp/Anonsurf_Gui/source/torrc.anon /etc/tor/
cp -v /tmp/Anonsurf_Gui/source/Anon /usr/bin/
cp -v /tmp/Anonsurf_Gui/source/UnAnonsurf /usr/bin/
cp -v /tmp/Anonsurf_Gui/source/UnAnDelete /etc/init.d/
cp -v /tmp/Anonsurf_Gui/source/anondaemon /usr/lib/anonsurf/
cp -v /tmp/Anonsurf_Gui/source/anon.png /usr/share/pixmaps/
cp -v /tmp/Anonsurf_Gui/source/Anon_country /etc/init.d/
cp -v /tmp/Anonsurf_Gui/source/anonsurfd.service /lib/systemd/system/
cp -v /tmp/Anonsurf_Gui/source/cloudflared-proxy-dns.service /lib/systemd/system/

cp -v /tmp/Anonsurf_Gui/bin/make-torrc /usr/lib/anonsurf/
cp -v /tmp/Anonsurf_Gui/bin/dnstool /usr/bin/

cp -v /tmp/Anonsurf_Gui/configs/onion.pac /etc/anonsurf/
cp -v /tmp/Anonsurf_Gui/configs/torrc.base /etc/anonsurf/
cp -v /tmp/Anonsurf_Gui/configs/bridges.txt /etc/anonsurf/
cp -v /tmp/Anonsurf_Gui/configs/anonrc /etc/anonsurf/
cp -v /tmp/Anonsurf_Gui/configs/bridgerc.base /etc/anonsurf

      

#postinst
if [ -f /etc/tor/torrc ]; then
 mv -v /etc/tor/torrc /etc/tor/torrc.orig
fi



if [ -f /lib/systemd/system/tor.service ]; then
 rm -fv /lib/systemd/system/tor.service
 mv -v /tmp/Anonsurf_Gui/source/tor.service /lib/systemd/system/tor.service
fi 


echo -e "\n$GREEN включение сервиса Тор\n$RESETCOLOR"

tor -f /etc/tor/torrc
systemctl enable --now tor.service

echo -e "\n$GREEN включение сервиса cloudfare\n$RESETCOLOR"
systemctl enable --now cloudflared-proxy-dns.service


chmod +x /usr/lib/anonsurf/anondaemon
chmod +x /usr/share/applications/anonsurf.desktop
chmod +x /usr/share/applications/Uninstall-Anonsurf.desktop 
chmod +x /usr/bin/Anon  
chmod +x /usr/bin/UnAnonsurf
chmod +x /etc/init.d/UnAnDelete
chmod +x /etc/init.d/Anon_country
chmod +x /usr/bin/dnstool

update-desktop-database && update-icon-caches /usr/share/pixmaps/*



exit 0;
