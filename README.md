# anonsurf_GUI 2.0
GUI for Anonsurf 2.0

Простая и интуинтивно понятная утилита для анонимного сёрфига интернетов..

На данном этапе поддерживаются: Debian, Ubuntu, Fedora, RHEL, Arch и их производные.

Установка:  sudo apt install git или sudo yum install git

git clone https://github.com/leohab75/anonsurf_GUI.git && cd anonsurf_GUI/ && sh install.sh

В результате вам будет установлен тор с простым и функциональным меню, который будет заворачивать весь трафик 

через свою сеть.

Само приложение будет расположенно в меню приложений на вкладке интернет.

Приложения => Интернет => Anonsurf

Для его удаления кликните:

Приложения => Интернет => Uninstall Anonsurf

В терминале будут доступны команды : 

Anon  // для вызова меню пользователя

и 

UnAnonsurf  //для удаления программы

управление утилитой из терминала распологается в 

sudo /usr/lib/anonsurf/anondaemon start|stop|restart

часть кода перенесена с Parrot Os (Anonsurf 3.0)




