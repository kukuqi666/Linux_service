#!/bin/bash

# 打印帮助信息和作者信息
print_help() {
    echo "作者：抖音海上森林一只猫"
    echo "联系方式：kukuqi666@gmail.com"
    echo "代码仓库：https://github.com/kukuqi666"
    echo
    echo "Usage: $0"
    echo "Select a service to manage:"
    echo "1. MySQL"
    echo "2. Nginx"
    echo "3. PHP-FPM"
    echo "4. Redis"
    echo "5. Composer"
    echo "6. FTP"
    echo "q. Quit"
}

# 打印子菜单
print_sub_menu() {
    echo "1. View Paths"
    echo "2. Edit Configuration File"
    echo "3. Back to main menu"
}

# 打印 MySQL 路径信息
print_mysql_paths() {
    echo "MySQL Paths:"
    echo "Installation Path: /usr/bin/mysql"
    echo "Configuration File Path: /etc/mysql/my.cnf"
    echo "Data Directory: /var/lib/mysql"
    echo "Log File Path: /var/log/mysql"
}

# 打印 Nginx 路径信息
print_nginx_paths() {
    echo "Nginx Paths:"
    echo "Installation Path: /usr/sbin/nginx"
    echo "Configuration File Path: /etc/nginx/sites-available/default"
    echo "HTML Directory: /var/www/html"
    echo "Log File Path: /var/log/nginx"
}

# 打印 PHP-FPM 路径信息
print_php_paths() {
    echo "PHP-FPM Paths:"
    echo "Installation Path: /usr/sbin/php-fpm"
    echo "Configuration File Path: /etc/php/*/fpm/php-fpm.conf"
    echo "PHP Configuration Directory: /etc/php/*/fpm/pool.d"
    echo "Log File Path: /var/log/php-fpm"
}

# 打印 Redis 路径信息
print_redis_paths() {
    echo "Redis Paths:"
    echo "Installation Path: /usr/bin/redis-server"
    echo "Configuration File Path: /etc/redis/redis.conf"
    echo "Data Directory: /var/lib/redis"
    echo "Log File Path: /var/log/redis"
}

# 打印 Composer 路径信息
print_composer_paths() {
    echo "Composer Paths:"
    echo "Installation Path: /usr/local/bin/composer"  # 假设 Composer 安装在 /usr/local/bin 目录
    echo "Configuration File Path: ~/.composer/config.json"  # 通常的配置文件位置
}

# 打印 FTP 路径信息
print_ftp_paths() {
    echo "FTP Paths:"
    echo "Installation Path: /usr/sbin/vsftpd"  # 假设 FTP 服务为 vsftpd
    echo "Configuration File Path: /etc/vsftpd/vsftpd.conf"
    echo "User Home Directory: /home/ubuntu"  # 示例用户主目录，根据实际情况修改
    echo "Log File Path: /var/log/vsftpd.log"
}

# 编辑配置文件
edit_config_file() {
    local config_file=$1
    if [ -f $config_file ]; then
        sudo vim $config_file
    else
        echo "Configuration file not found: $config_file"
    fi
}

# 处理子菜单选项
handle_sub_menu() {
    local service_index=$1
    while true; do
        print_sub_menu
        read -p "Choose an option: " action
        case $action in
            1)
                case $service_index in
                    1) print_mysql_paths ;;
                    2) print_nginx_paths ;;
                    3) print_php_paths ;;
                    4) print_redis_paths ;;
                    5) print_composer_paths ;;
                    6) print_ftp_paths ;;
                esac
                ;;
            2)
                case $service_index in
                    1) edit_config_file "/etc/mysql/my.cnf" ;;
                    2) edit_config_file "/etc/nginx/sites-available/default" ;;
                    3) edit_config_file "/etc/php/*/fpm/php-fpm.conf" ;;
                    4) edit_config_file "/etc/redis/redis.conf" ;;
                    5) edit_config_file "~/.composer/config.json" ;;
                    6) edit_config_file "/etc/vsftpd/vsftpd.conf" ;;  # 编辑 FTP 配置文件
                esac
                ;;
            3)
                return
                ;;
            *)
                echo "Invalid option"
                ;;
        esac
    done
}

# 主逻辑
while true; do
    print_help
    read -p "Enter the service number to manage (or 'q' to quit): " service_number

    case $service_number in
        1) handle_sub_menu 1 ;;
        2) handle_sub_menu 2 ;;
        3) handle_sub_menu 3 ;;
        4) handle_sub_menu 4 ;;
        5) handle_sub_menu 5 ;;
        6) handle_sub_menu 6 ;;
        q) exit 0 ;;
        *)
            echo "Invalid option"
            ;;
    esac
done

