#!/bin/bash

source components/common.sh

Print "Setup MySQL Repo"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
Status_Check $?

Print "Install MySQL\t"
yum remove mariadb-libs -y &>>$LOG && yum install mysql-community-server -y &>>$LOG
Status_Check $?

Print "Start MySQL Service"
systemctl enable mysqld && systemctl start mysqld &>>$LOG
Status_Check $?

DEFAULT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')


Print "Reset Default Password\t"
echo 'show databases' | mysql -uroot -pRoboShop@1 &>>$LOG
if [ $? -eq 0 ]; then
  echo "Root Password is already set" &>>$LOG
else
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" >/tmp/reset.sql
  mysql --connect-expired-password -u root -p"${DEFAULT_PASSWORD}" </tmp/reset.sql &>>$LOG
fi
Status_Check $?

Print "Uninstall Password validate plugin"
 echo "uninstall plugin validate_password;" >/tmp/pass.sql
 mysql -u root -p"RoboShop@1"  </tmp/pass.sql &>>$LOG
Status_Check $?

Print "Downloading the Schema"
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip" &>>$LOG

Print "Extract Schema File"
cd /tmp && unzip -o mysql.zip &>>$LOG
Status_Check $?

Print "Load Schema"
cd mysql-main && mysql -u root -pRoboShop@1 <shipping.sql &>>$LOG
Status_Check $?