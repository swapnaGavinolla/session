source common.sh
code_dir=$(pwd)

head "coping mongo repo"
cp ${code_dir}/mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file
validate $?

head "installing mongodb"  
yum install mongodb-org -y &>>$log_file
validate $?


head "enabling "
systemctl enable mongod &>>$log_file
validate $?

head "starting"
systemctl start mongod &>>$log_file
validate $?

head "updating mongodb listening addresss"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$log_file
validate $?

head "restarting"
systemctl restart mongod &>>$log_file
validate $?