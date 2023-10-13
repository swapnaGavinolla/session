source common.sh
head "installing nginx"
yum install nginx -y &>>$log_file
validate $?

head "enabling"
systemctl enable user &>>$log_file
validate $?

head "strating"
systemctl start user &>>$log_file
validate $?

head "removing old data"
rm -rf /usr/share/nginx/html/* &>>$log_file
validate $?

head "downloading frontend content"
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>>$log_file
validate $?

head "extract frontend content"
cd /usr/share/nginx/html &>>$log_file
validate $?

head "unzipping"
unzip /tmp/web.zip &>>$log_file
validate $?

head "copying roboshop.conf"
cp ${code_dir}/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$log_file
validate $?

head "restarting nginx"
systemctl restart nginx  &>>$log_file
validate $?