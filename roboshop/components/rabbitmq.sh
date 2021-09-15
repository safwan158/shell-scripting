#!/bin/bash

source components/common.sh

Print "Install Erlang"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y &>>$LOG
Status_Check $?

Print "Setup YUM repositories"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>$LOG
Status_Check $?

Print "Install RabbitMQ"
yum install rabbitmq-server -y &>>$LOG
Status_Check $?

Print "Start RabbitMQ"
systemctl enable rabbitmq-server &>>$LOG &&  systemctl start rabbitmq-server &>>$LOG
Status_Check $?

Print "Create an application User"

rabbitmqctl add_user roboshop roboshop123 &>>$LOG && rabbitmqctl set_user_tags roboshop administrator && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG
Status_Check $?
