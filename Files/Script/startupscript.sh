#!/bin/bash

sudo apt-get update
for pack in cat `cat list2.txt`
do sudo apt-get -y install $pack
done

sudo mysql -u root -p <<MYSQL_SCRIPT
CREATE DATABASE VOGEL;
CREATE USER 'pi'@'localhost' IDENTIFIED BY 'rootroot';
GRANT ALL PRIVILEGES ON VOGEL.* TO 'pi'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

wget https://download.owncloud.org/community/owncloud-complete-20200731.tar.bz2
tar -xvf owncloud-complete-20200731.tar.bz2
mv owncloud /var/www/html/
sudo chown -R www-data:www-data /var/www/

sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
sudo rfkill unblock wlan

cp ../Config/config.php /var/www/html/owncloud
cp ../Config/dhcpcd.conf /etc/dhcpcd.conf
sudo cp ../Config/dnsmasq.conf /etc/dnsmasq.conf
cp ../Config/hostapd.conf /etc/hostapd/hostapd.conf
cp .bashrc /home/pi

sudo reboot
