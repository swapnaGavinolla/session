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
curl -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip &>>$log_file
validate $?


head "unzipping"
unzip /tmp/cart.zip &>>$log_file
validate $?


cd /app

head "installing dependencies"
npm install &>>$log_file
validate $?

head "setting up cart service"
cp ${code_dir}/cart.service /etc/systemd/system/cart.service &>>$log_file
validate $?

head "demon reloading"
systemctl daemon-reload &>>$log_file
validate $?

head "enabling"
systemctl enable cart &>>$log_file
validate $?

head "strating"
systemctl start cart &>>$log_file
validate $?





