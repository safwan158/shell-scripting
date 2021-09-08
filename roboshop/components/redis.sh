#!/bin/bash/

source components/common.sh

Print "Install Yum Utiles & Download Redis Repos"
yum install epel-release yum-utils -y yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$LOG
Status_Check $?

Print "SetUp Redis Repos"
yum-config-manager --enable remi &>>$LOG
Status_Check $?

Print "Install Redis"
yum install redis -y &>>$LOG
Status_Check $?

Print "Configure Redis Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.' /etc/redis.conf

Print "Start Redis Service"
systemctl enable redis &>>$LOG && systemctl start redis &>>$LOG

