#!/bin/bash
##############################################################
##############################################################
#######                                                #######
#######      WSS LITESPEED INSTALLER DEBIAN 10         #######
#######                                                #######
##############################################################
##############################################################

## Предупреждение
clear
echo "############################## ВНИМАНИЕ ##############################"
echo "WSS устанавливается только на новую/чистую ОС. В ходе работы установщика WSS из системы безвозвратно будут удалены любые мешающие работе скрипта пакеты/программы/файлы конфигурации/данные. Установщик скрипта, а так-же разработчик WSS установщика не гарантирует безошибочную работу скрипта. Всю ответственность и риски вы берете на себя."
echo "############################## ВНИМАНИЕ ##############################"
echo -en "\n\n\tНажмите любую клавишу для продолжения, или CTRL + C для отмены"
read -n 1 line
clear

if [ "$EUID" -ne 0 ]
  then echo "Работа установшика WSS возможна только от имени суперпользователя ROOT."
  exit
fi

## Обновление системы
aptitude upgrade -y

## Установка вспомогательных пакетов
apt install dos2unix bash-completion curl wget git

## Удаление возможно установленных пакетов
apt autoremove nginx apache2  mysql-common mariadb-server mariadb-client proftpd pure-ftpd vsftpd bind9 sendmail postfix exim4 -y
apt autoremove lsws openlitespeed -y
apt autoclean -y
apt clean

## Удаление конфигов
rm -rf /etc/nginx/
rm -rf /etc/apache2/
rm -rf /usr/local/lsws/
rm -rf /etc/mysql/ /etc/my.cnf
rm -rf /etc/proftpd/
rm -rf /etc/pure-ftpd/
rm -rf /etc/vsftpd.conf
rm -rf /etc/bind/ /var/cache/bind/
rm -rf /etc/mail/
rm -rf /etc/postfix/
rm -rf /etc/exim4/
rm -rf /usr/local/lsws/

##Добавляем репозитории
#LiteSpeed
wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | bash
#
