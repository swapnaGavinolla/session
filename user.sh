source common.sh

head "setting ip nodeJS repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
validate $?

head "installing nodeJS"
yum install nodejs -y &>>$log_file
validate $?


head "adding user"
id roboshop
user $?

head "creating directory"
cd /app
dir $?

head "deleting old content"
rm -rf /app/*


head "downloading application code"
curl -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>>$log_file
validate $?


head "unzipping"
unzip /tmp/user.zip &>>$log_file
validate $?


cd /app

head "installing dependencies"
npm install &>>$log_file
validate $?

head "setting up user service"
cp ${code_dir}/user.service /etc/systemd/system/user.service &>>$log_file
validate $?

head "demon reloading"
systemctl daemon-reload &>>$log_file
validate $?

head "enabling"
systemctl enable user &>>$log_file
validate $?

head "strating"
systemctl start user &>>$log_file
validate $?

head "copying mongo repo"
cp ${code_dir}/mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file
validate $?

head "install mongodb client"
yum install mongodb-org-shell -y &>>$log_file
validate $?

head "loading schema"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js &>>$log_file
validate $?




