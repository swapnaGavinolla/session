source common.sh

head "config yum repo"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$log_file
validate $?

head "config yum repo for rabbitmq"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$log_file
validate $?

head "installing rabbitmq"
yum install rabbitmq-server -y &>>$log_file
validate $?

head "enabling "
systemctl enable rabbitmq-server   &>>$log_file
validate $?

head "starting"
systemctl start rabbitmq-server  &>>$log_file
validate $?

rabbitmqctl add_user roboshop roboshop123 &>>$log_file

