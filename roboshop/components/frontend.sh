#!/bin/bash

source components/common.sh

Print "Install Nginx"
yum install nginx -y &>>$LOG
Status_Check $?

Print "Download frontend Archives"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
Status_Check $?

Print "Extract frontend archive"
rm -rf  /usr/share/nginx/html && cd /usr/share/nginx/html && unzip /tmp/frontend.zip &>>$LOG && mv frontend-main/* . && mv static/* .
Status_Check $?

Print "Update frontend Nginx Roboshop Config"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG
Status_Check $?

Print "Restart Nginx\t\t"
systemctl restart nginx &>>$LOG
Status_Check $?