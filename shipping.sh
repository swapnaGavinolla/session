source common.sh

head "installing maven"
yum install maven -y &>>$log_file
validate $?

head "adding user"
id roboshop
user $?  &>>$log_file

head "creating directory"
cd /app
dir $?  &>>$log_file

head "deleting old content"
rm -rf /app/*

head "Downloading the application code"
curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip &>>$log_file
validate $?

cd /app

head "unzipping"
unzip /tmp/shipping.zip &>>$log_file
validate $?

cd /app

head "downloading the dependencies"
mvn clean package &>>$log_file
validate $?

mv target/shipping-1.0.jar shipping.jar

head "copying shipping.service"
cp ${code_dir}/shipping.service /etc/systemd/system/shipping.service &>>$log_file
validate $?

head "demon reloading"
systemctl daemon-reload &>>$log_file
validate $?

head "enabling"
systemctl enable shipping  &>>$log_file
validate $?

head "strating"
systemctl start shipping &>>$log_file
validate $?

head "mysql client"
yum install mysql -y &>>$log_file
validate $?

head "loading schema"
mysql -h 172.31.21.13 -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>$log_file
validate $?

head "restating"
systemctl restart shipping &>>$log_file
validate $?