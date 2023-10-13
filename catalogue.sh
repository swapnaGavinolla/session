source common.sh

head "setting ip nodeJS repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
validate $?

head "installing nodeJS"
yum install nodejs -y &>>$log_file
validate $?


head"adding user"
user $? id roboshop
useradd roboshop &>>$log_file


head "creating directory"
dir $? app/
mkdir /app &>>$log_file



head "downloading application code"
curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>>$log_file
validate $?


head "unzipping"
unzip /tmp/catalogue.zip &>>$log_file
validate $?


cd /app

head "installing dependencies"
npm install &>>$log_file
validate $?

head "setting up catalogue service"
cp ${code_dir}/catalogue.service /etc/systemd/system/catalogue.service &>>$log_file
validate $?

head "demon reloading"
systemctl daemon-reload &>>$log_file
validate $?

head "enabling"
systemctl enable catalogue &>>$log_file
validate $?

head "strating"
systemctl start catalogue &>>$log_file
validate $?

head "copying mongo repo"
cp ${code_dir}/mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file
validate $?

head "install mongodb client"
yum install mongodb-org-shell -y &>>$log_file
validate $?

head "loading schema"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js &>>$log_file
validate $?




