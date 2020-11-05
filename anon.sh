#!/bin/bash

#меню утилиты
menu=$(zenity --list --text="Функционал"\
        --radiolist --column "Pick" --column "Anonsurf"\
        True   "start"\
        FALSE  "stop"\
        FALSE  "restart"\
        FALSE  "change"\
        FALSE  "status"\
        --height=300)
 
 # переключатель
case $menu in
        start)
              pkexec sudo anonsurf start
              
        ;;
        stop)
              pkexec sudo anonsurf stop
              
        ;;
        restart)
               pkexec sudo anonsurf restart
               
        ;;
        change)
               pkexec sudo anonsurf change
               
        ;;
        status)
               IP=$(curl "http://myexternalip.com/raw")
               active=$(exec /etc/init.d/tor status status | grep -i Active)
               zenity --info --text="Ваш текущий IP адрес: $IP\
                                    Статус сети Тор ..........\
                                    $active "\
                                    --height=200 --width=200
        
        ;;
               
               
             *)
        ;;
esac             


sleep 1

#сообщение статуса сети Тор
notifi=$(exec /etc/init.d/tor status | grep -i Active)
zenity --notification  --text="$notifi"

exit 0;