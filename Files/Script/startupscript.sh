#!/bin/bash

echo "Updating system..."
sudo apt-get update
sudo apt-get upgrade

echo "Installing Dependencies"
sudo apt-get install mosquitto mosquitto-clients
sudo apt-get install mariadb-server-10.0

echo "Installing Python libraries"
sudo apt-get install python-mysql.connector
sudo pip install paho-mqtt

echo "Creating SQL database"
sudo mysql -u root -p <<MYSQL_SCRIPT
CREATE DATABASE TRACKING;
CREATE USER 'pi'@'localhost' IDENTIFIED BY 'rootroot';
GRANT ALL PRIVILEGES ON TRACKING.* TO 'pi'@'localhost';
FLUSH PRIVILEGES;
USE TRACKING;
CREATE TABLE DEVICES(
ID INT NOT NULL AUTO_INCREMENT,
Device_id VARCHAR (100) NOT NULL,
ROOM VARCHAR (100) NOT NULL,
PRIMARY KEY (ID)
);
CREATE TABLE PEOPLECOUNT(
Time DATETIME,
ROOM1 int,
ROOM2 int
);
MYSQL_SCRIPT

echo "Installing Grafana"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/$
sudo apt-get update
sudo apt-get install -y grafana
sudo /bin/systemctl enable grafana-server
sudo /bin/systemctl start grafana-server


