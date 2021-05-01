#!/bin/bash
##############################################################
##############################################################
#######                                                #######
#######       WSS LITESPEED INSTALLER CENTOS 8         #######
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

## Перемещаяемся в TMP для дальшей работы
cd /tmp

## Обновление системы
dnf upgrade -y

## Установка вспомогательных пакетов
dnf install dos2unix bash-completion wget git

## Удаление возможно установленных пакетов
dnf autoremove nginx apache2  mysql-common mariadb-server mariadb-client proftpd pure-ftpd vsftpd bind9 sendmail postfix exim4 -y
dnf autoremove lsws openlitespeed -y
dnf autoclean -y

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
rpm -Uvh http://rpms.litespeedtech.com/centos/litespeed-repo-1.1-1.el8.noarch.rpm
dnf install epel-release -y

##Устаналиваем Open
