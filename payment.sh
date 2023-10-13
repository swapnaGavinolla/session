source common.sh

head "installing python"
yum install python36 gcc python3-devel -y &>>$log_file
validate $?

head"adding user"
user $? id roboshop
useradd roboshop &>>$log_file


head "creating directory"
dir $? app/
mkdir /app &>>$log_file

head "downloading application code"
curl -L -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip &>>$log_file
validate $?

cd /app 

head "unzipping"
unzip /tmp/payment.zip &>>$log_file
validate $?


cd /app 

head "installing requirements"
pip3.6 install -r requirements.txt &>>$log_file
validate $?

head "copying payment.service"
cp ${code_dir}/payment.service /etc/systemd/system/payment.service
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
