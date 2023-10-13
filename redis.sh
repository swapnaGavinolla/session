source common.sh

head "setting up repo"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>$log_file
validate $?

head "enabling 6.2 version"
yum module enable redis:remi-6.2 -y &>>$log_file
validate $?

head "installing redis"
yum install redis -y &>>$log_file 
validate $?

head "updating redis listening addresss"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>>$log_file
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf &>>$log_file
validate $?

head "enabling "
systemctl enable redis &>>$log_file
validate $?

head "starting"
systemctl start redis &>>$log_file
validate $?

