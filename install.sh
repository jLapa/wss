#!/bin/sh
if [ "$EUID" -ne 0 ]
  then echo "Работа установшика WSS возможна только от имени суперпользователя ROOT."
  exit
fi

OUTPUT=$(cat /etc/*release)
if echo $OUTPUT | grep -q "CentOS Linux 8" ; then
        echo -e "\nDetecting Centos 8...\n"
        SERVER_OS="cent8"
dnf install curl wget git -y 1> /dev/null
dnf update curl wget ca-certificates git -y 1> /dev/null

elif echo $OUTPUT | grep -q "Debian GNU/Linux 10 (buster)" ; then
apt install wget curlgit git  -y
                SERVER_OS="deb10"
else

                echo -e "\nUnable to detect your OS...\n"
                echo -e "\nWSS is supported on Debian 10, Centos 8\n"
                exit 1
fi

git clone https://github.com/jLapa/wss 2>/dev/null
chmod -R +x *.sh
./wss_installer/wss_install_$SERVER_OS.sh $@