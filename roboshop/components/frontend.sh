#!/bin/bash

source components/common.sh

Print "Install Nginx\t\t\t"
yum install nginx -y &>>$LOG
Status_Check $?

Print "Download frontend Archives\t"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
Status_Check $?

Print "Extract frontend archive\t"
rm -rf /usr/share/nginx/* && cd /usr/share/nginx && unzip -o /tmp/frontend.zip  &>>$LOG  && mv frontend-main/* .  &>>$LOG  &&   mv static html  &>>$LOG
#rm -rf /usr/share/nginx/* && cd /usr/share/nginx && unzip -o /tmp/frontend.zip  &>>$LOG  && mv frontend-main/* .  &>>$LOG  &&   mv static html .&>>$LOG
Status_Check $?

Print "copy frontend Nginx Roboshop Config"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG
Status_Check $?

Print "update frontend Nginx Roboshop Config"
sed -i -e '/catalogue/ s/localhost/catalogue.roboshop.internal/' /etc/nginx/default.d/roboshop.conf &>>$LOG

mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG
Status_Check $?


Print "Restart Nginx\t\t\t"
systemctl restart nginx &>>$LOG
Status_Check $?