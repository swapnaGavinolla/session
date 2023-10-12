head() {
    echo -e "\e[31m$1\e[0m"
}
code_dir=(pwd)
rm -rf /tmp/roboshop.log
log_file=/tmp/roboshop.log

validate() {
    if [ $1 == 0 ]; then
        head "success"
    else
        head "failure"
        exit 1
    fi
}