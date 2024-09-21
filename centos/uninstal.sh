#!/bin/bash

# 打印帮助信息和作者信息
print_help() {
    echo "作者：抖音海上森林一只猫"
    echo "联系方式：kukuqi666@gmail.com"
    echo "代码仓库："
    echo
    echo "Usage: $0"
    echo "选择要卸载的服务："
    echo "1. MySQL"
    echo "2. Nginx"
    echo "3. PHP-FPM"
    echo "4. Redis"
    echo "5. FTP"
    echo "6. Composer"
    echo "q. 退出"
}

# 卸载 MySQL
uninstall_mysql() {
    sudo yum remove -y mysql-server mysql-client
    sudo yum autoremove -y
    sudo rm -rf /etc/my.cnf /var/lib/mysql /var/log/mysql
    echo "MySQL 卸载完成"
}

# 卸载 Nginx
uninstall_nginx() {
    sudo yum remove -y nginx
    sudo yum autoremove -y
    sudo rm -rf /etc/nginx /usr/share/nginx /var/log/nginx
    echo "Nginx 卸载完成"
}

# 卸载 PHP-FPM
uninstall_php() {
    sudo yum remove -y php-fpm
    sudo yum autoremove -y
    sudo rm -rf /etc/php /var/log/php-fpm
    echo "PHP-FPM 卸载完成"
}

# 卸载 Redis
uninstall_redis() {
    sudo yum remove -y redis
    sudo yum autoremove -y
    sudo rm -rf /etc/redis /var/lib/redis /var/log/redis
    echo "Redis 卸载完成"
}

# 卸载 FTP
uninstall_ftp() {
    sudo yum remove -y vsftpd proftpd   # 假设可能安装的 FTP 服务器是 vsftpd 或 proftpd
    sudo yum autoremove -y
    sudo rm -rf /etc/vsftpd /etc/proftpd   # 相应的配置目录，根据实际情况修改
    sudo rm -rf /var/lib/vsftpd /var/lib/proftpd   # 可能的用户数据目录，根据实际情况修改
    echo "FTP 卸载完成"
}

# 卸载 Composer
uninstall_composer() {
    sudo rm -rf /usr/local/bin/composer   # 假设 Composer 安装在 /usr/local/bin 目录
    echo "Composer 卸载完成"
}

# 主逻辑
while true; do
    print_help
    read -p "输入要卸载的服务编号 (或 'q' 退出): " service_number

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
            echo "无效选项"
            ;;
    esac
done
