#!/bin/bash

# 打印帮助信息和作者信息
print_help() {
    echo "作者：抖音海上森林一只猫"
    echo "联系方式：kukuqi666@gmail.com"
    echo "代码仓库：https://github.com/kukuqi666"
    echo
    echo "Usage: $0"
    echo "Select a service to view details:"
    echo "1. MySQL"
    echo "2. Nginx"
    echo "3. PHP-FPM"
    echo "4. Redis"
    echo "5. FTP"
    echo "6. Composer"
    echo "q. Quit"
}

# 查看 MySQL 进程、端口和资源占用情况
view_mysql_details() {
    echo "MySQL Process and Resource Details:"
    echo "Processes:"
    ps aux | grep mysql
    echo
    echo "Listening Ports:"
    sudo netstat -tunlp | grep mysql
    echo
    echo "Processes Holding MySQL Ports:"
    sudo lsof -i -P -n | grep LISTEN | grep mysql
}

# 查看 Nginx 进程、端口和资源占用情况
view_nginx_details() {
    echo "Nginx Process and Resource Details:"
    echo "Processes:"
    ps aux | grep nginx
    echo
    echo "Listening Ports:"
    sudo netstat -tunlp | grep nginx
    echo
    echo "Processes Holding Nginx Ports:"
    sudo lsof -i -P -n | grep LISTEN | grep nginx
}

# 查看 PHP-FPM 进程、端口和资源占用情况
view_php_details() {
    echo "PHP-FPM Process and Resource Details:"
    echo "Processes:"
    ps aux | grep php-fpm
    echo
    echo "Listening Ports:"
    sudo netstat -tunlp | grep php-fpm
    echo
    echo "Processes Holding PHP-FPM Ports:"
    sudo lsof -i -P -n | grep LISTEN | grep php-fpm
}

# 查看 Redis 进程、端口和资源占用情况
view_redis_details() {
    echo "Redis Process and Resource Details:"
    echo "Processes:"
    ps aux | grep redis-server
    echo
    echo "Listening Ports:"
    sudo netstat -tunlp | grep redis-server
    echo
    echo "Processes Holding Redis Ports:"
    sudo lsof -i -P -n | grep LISTEN | grep redis-server
}

# 查看 FTP 进程、端口和资源占用情况
view_ftp_details() {
    echo "FTP Process and Resource Details:"
    echo "Processes:"
    ps aux | grep vsftpd  # 假设 FTP 服务为 vsftpd
    echo
    echo "Listening Ports:"
    sudo netstat -tunlp | grep vsftpd
    echo
    echo "Processes Holding FTP Ports:"
    sudo lsof -i -P -n | grep LISTEN | grep vsftpd
}

# 查看 Composer 进程、端口和资源占用情况
view_composer_details() {
    echo "Composer Process and Resource Details:"
    echo "Composer is not a server process and does not have ports or dedicated processes for monitoring in this context."
}

# 主逻辑
while true; do
    print_help
    read -p "Enter the service number to view details (or 'q' to quit): " service_number

    case $service_number in
        1)
            view_mysql_details
            ;;
        2)
            view_nginx_details
            ;;
        3)
            view_php_details
            ;;
        4)
            view_redis_details
            ;;
        5)
            view_ftp_details
            ;;
        6)
            view_composer_details
            ;;
        q)
            exit 0
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
done

