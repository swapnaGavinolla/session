source common.sh

head "disabling mysql module"
yum module disable mysql -y  &>>$log_file
validate $?

head "setting up mysql repo"
cp ${code_dir}/mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
validate $?

head "installing mysql community server"
yum install mysql-community-server -y &>>$log_file
validate $?


head "enabling "
systemctl enable mysqld  &>>$log_file
validate $?

head "starting"
systemctl start mysqld &>>$log_file
validate $?

mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file



