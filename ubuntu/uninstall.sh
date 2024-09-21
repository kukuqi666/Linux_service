#!/bin/bash

# 打印帮助信息和作者信息
print_help() {
    echo "作者：抖音海上森林一只猫"
    echo "联系方式：kukuqi666@gmail.com"
    echo "代码仓库：https://github.com/kukuqi666"
    echo
    echo "Usage: $0"
    echo "Select a service to uninstall:"
    echo "1. MySQL"
    echo "2. Nginx"
    echo "3. PHP-FPM"
    echo "4. Redis"
    echo "5. FTP"
    echo "6. Composer"
    echo "q. Quit"
}

# 卸载 MySQL
uninstall_mysql() {
    sudo apt purge -y mysql-server mysql-client
    sudo apt autoremove -y
    sudo rm -rf /etc/mysql /var/lib/mysql /var/log/mysql
    echo "MySQL uninstalled"
}

# 卸载 Nginx
uninstall_nginx() {
    sudo apt purge -y nginx
    sudo apt autoremove -y
    sudo rm -rf /etc/nginx /var/www/html /var/log/nginx
    echo "Nginx uninstalled"
}

# 卸载 PHP-FPM
uninstall_php() {
    sudo apt purge -y php7.4-fpm php8.0-fpm php8.1-fpm
    sudo apt autoremove -y
    sudo rm -rf /etc/php /var/log/php-fpm
    echo "PHP-FPM uninstalled"
}

# 卸载 Redis
uninstall_redis() {
    sudo apt purge -y redis-server
    sudo apt autoremove -y
    sudo rm -rf /etc/redis /var/lib/redis /var/log/redis
    echo "Redis uninstalled"
}

# 卸载 FTP
uninstall_ftp() {
    sudo apt purge -y vsftpd proftpd  # 假设可能安装的 FTP 服务器是 vsftpd 或 proftpd
    sudo apt autoremove -y
    sudo rm -rf /etc/vsftpd /etc/proftpd  # 相应的配置目录，根据实际情况修改
    sudo rm -rf /var/lib/ftp  # 可能的用户数据目录，根据实际情况修改
    echo "FTP uninstalled"
}

# 卸载 Composer
uninstall_composer() {
    sudo rm -rf /usr/local/bin/composer  # 假设 Composer 安装在 /usr/local/bin 目录
    echo "Composer uninstalled"
}

# 主逻辑
while true; do
    print_help
    read -p "Enter the service number to uninstall (or 'q' to quit): " service_number

    case $service_number in
        1)
            uninstall_mysql
            ;;
        2)
            uninstall_nginx
            ;;
        3)
            uninstall_php
            ;;
        4)
            uninstall_redis
            ;;
        5)
            uninstall_ftp
            ;;
        6)
            uninstall_composer
            ;;
        q)
            exit 0
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
done

