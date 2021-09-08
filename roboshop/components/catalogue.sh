#!/bin/bash

source components/common.sh

Print "Installing NodeJS"
yum install nodejs make gcc-c++ -y &>>$LOG
Status_Check $?

print "Adding RoboShop User"
useradd roboshop &>>$LOG
Status_Check $?

Print "Downloading Catalogue Content"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG
Status_Check $?

Print "Extracting Catalogue"
$cd /home/roboshop
unzip /tmp/catalogue.zip &>>$LOG
Status_Check $?

mv catalogue-main catalogue
cd /home/roboshop/catalogue
npm install 
We need to update the IP address of MONGODB Server in systemd.service file
Now, lets set up the service with systemctl.

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue