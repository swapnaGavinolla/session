head() {
    echo -e "\e[32m$1\e[0m"
}
code_dir=$(pwd)
rm -rf /tmp/roboshop.log
log_file=/tmp/roboshop.log

validate() {
    if [ $1 == 0 ]; then
        head "success"
    else
        head -e "\e[31m failure\e[0m"
        exit 1
    fi
}

user(){
    if [ $1 == 0 ]; then
        echo " user already exists"
    else
        useradd roboshop &>>$log_file
    fi
}

dir(){
    if [ $1 == 0 ]; then
         echo " app already exists"
    else 
        mkdir /app &>>$log_file
    fi
}
