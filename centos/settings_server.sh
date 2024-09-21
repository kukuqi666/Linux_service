#!/bin/bash

# ... (rest of your script)

# 打印 MySQL 路径信息
print_mysql_paths() {
    echo "MySQL 路径:"
    echo "安装路径: /usr/bin/mysql"
    echo "配置文件路径: /etc/my.cnf"
    echo "数据目录: /var/lib/mysql"
    echo "日志文件路径: /var/log/mysql"
}

# 打印 Nginx 路径信息
print_nginx_paths() {
    echo "Nginx 路径:"
    echo "安装路径: /usr/sbin/nginx"
    echo "配置文件路径: /etc/nginx/nginx.conf"
    echo "HTML 目录: /usr/share/nginx/html"
    echo "日志文件路径: /var/log/nginx"
}

# 打印 PHP-FPM 路径信息
print_php_paths() {
    echo "PHP-FPM 路径:"
    echo "安装路径: /usr/sbin/php-fpm"
    echo "配置文件路径: /etc/php-fpm.d/"
    echo "PHP 配置目录: /etc/php-fpm.d/"
    echo "日志文件路径: /var/log/php-fpm"
}

# 打印 Redis 路径信息
print_redis_paths() {
    echo "Redis 路径:"
    echo "安装路径: /usr/bin/redis-server"
    echo "配置文件路径: /etc/redis.conf"
    echo "数据目录: /var/lib/redis"
    echo "日志文件路径: /var/log/redis.log"
}

# 打印 Composer 路径信息
print_composer_paths() {
    echo "Composer 路径:"
    echo "安装路径: /usr/local/bin/composer"   # 假设 Composer 安装在 /usr/local/bin 目录
    echo "配置文件路径: ~/.config/composer"    # CentOS 中的配置文件位置可能不同
}

# 打印 FTP 路径信息
print_ftp_paths() {
    echo "FTP 路径:"
    echo "安装路径: /usr/sbin/vsftpd"   # 假设 FTP 服务为 vsftpd
    echo "配置文件路径: /etc/vsftpd/vsftpd.conf"
    echo "用户主目录: /home/username"   # 示例用户主目录，根据实际情况修改
    echo "日志文件路径: /var/log/vsftpd.log"
}

# ... (rest of your script)

# 编辑配置文件
edit_config_file() {
    local config_file=$1
    if [ -f $config_file ]; then
        sudo vi $config_file   # CentOS 中使用 vi 或 nano 作为编辑器
    else
        echo "配置文件未找到: $config_file"
    fi
}

# ... (rest of your script)

# 主逻辑
while true; do
    print_help
    read -p "输入要管理的服务编号 (或 'q' 退出): " service_number

    # ... (rest of your case statements)

    # 处理子菜单选项
    handle_sub_menu() {
        local service_index=$1
        while true; do
            print_sub_menu
            read -p "选择一个操作选项: " action
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
                        1) edit_config_file "/etc/my.cnf" ;;
                        2) edit_config_file "/etc/nginx/nginx.conf" ;;
                        3) edit_config_file "/etc/php-fpm.d/" ;;   # CentOS 中的配置文件位置可能不同
                        4) edit_config_file "/etc/redis.conf" ;;
                        5) edit_config_file "~/.config/composer" ;; # CentOS 中的配置文件位置可能不同
                        6) edit_config_file "/etc/vsftpd/vsftpd.conf" ;;
                    esac
                    ;;
                3)
                    return
                    ;;
                *)
                    echo "无效选项"
                    ;;
            esac
        done
    }

    # ... (rest of your case statements)

done
