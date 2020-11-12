#!/bin/bash

for pack in cat `cat list2.txt`
do sudo apt-get -y install $pack
done

mysql -u root -p <<MYSQL_SCRIPT
CREATE DATABASE VOGEL;
CREATE USER 'pi'@'localhost' IDENTIFIED BY 'rootroot';
GRANT ALL PRIVILEGES ON VOGEL.* TO 'pi'@'localhost';
FLUSH PRIVILeGES;
MYSQL_SCRIPT

wget https://download.owncloud.org/community/owncloud-complete-20200731.tar.bz2
tar -xvf owncloud-complete-20200731.tar.bz2
mv owncloud /var/www/html/
sudo chown -R www-data:www-data /var/www/
sudo systemctl restart apache2.service

sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
sudo rfkill unblock wlan
