#!/bin/bash

source components/common.sh

Print "Installing NodeJS\t\t"
yum install nodejs make gcc-c++ -y &>>$LOG
Status_Check $?

Print "Adding RoboShop User\t\t"
id roboshop &>>$LOG
if [ $? -eq -0 ]; then
    echo "User already there, so skipping " &>>$LOG
else
    useradd roboshop &>>$LOG
fi
Status_Check $?

Print "Downloading Catalogue Content\t"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG
Status_Check $?

Print "Extracting Catalogue\t\t"
cd /home/roboshop
rm -rf catalogue && unzip -o /tmp/catalogue.zip &>>$LOG && mv catalogue-main catalogue
Status_Check $?

Print "Downloading NodeJS Dependencies"
cd /home/roboshop/catalogue 
npm install --unsafe-perm &>>$LOG
Status_Check $?

chown roboshop:roboshop -R /home/roboshop
#We need to update the IP address of MONGODB Server in systemd.service file
#Now, lets set up the service with systemctl.
Print "SetUp SystemD Service"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service && systemctl daemon-reload &&

systemctl start catalogue
systemctl enable catalogue