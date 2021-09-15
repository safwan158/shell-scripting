#!/bin/bash

source components/common.sh

Print "Install Erlang\t\t"
yum list installed | grep erlang &>>$LOG
if [ $? -eq 0 ]; then 
    echo "Package is already Installed" &>>$LOG
else
    yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y &>>$LOG
fi
Status_Check $?

Print "Setup YUM repositories\t"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>$LOG
Status_Check $?

Print "Install RabbitMQ\t"
yum install rabbitmq-server -y &>>$LOG
Status_Check $?

Print "Start RabbitMQ\t\t"
systemctl enable rabbitmq-server &>>$LOG &&  systemctl start rabbitmq-server &>>$LOG
Status_Check $?

Print "Create an application User"
rabbitmqctl list_users | grep roboshop &>>$LOG
if [ $? -ne 0 ]; then
    rabbitmqctl add_user roboshop roboshop123 &>>$LOG
else 
    rabbitmqctl set_user_tags roboshop administrator &>>$LOG && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG
fi
Status_Check $?
