#!/bin/bash

# 打印帮助信息和作者信息
print_help() {
     echo "作者：抖音海上森林一只猫"
     echo "联系方式：kukuqi666@gmail.com"
     echo "代码仓库："
     echo
     echo "Usage: $0"
     echo "选择一个服务查看详情："
     echo "1. MySQL"
     echo "2. Nginx"
     echo "3. PHP-FPM"
     echo "4. Redis"
     echo "5. FTP"
     echo "6. Composer"
     echo "q. 退出"
}

# 查看 MySQL 进程、端口和资源占用情况
view_mysql_details() {
     echo "MySQL 进程和资源详情："
     echo "进程："
     ps aux | grep mysql
     echo
     echo "监听端口："
     sudo netstat -tunlp | grep mysql
     echo
     echo "持有 MySQL 端口的进程："
     sudo lsof -i -P -n | grep LISTEN | grep mysql
}

# 查看 Nginx 进程、端口和资源占用情况
view_nginx_details() {
     echo "Nginx 进程和资源详情："
     echo "进程："
     ps aux | grep nginx
     echo
     echo "监听端口："
     sudo netstat -tunlp | grep nginx
     echo
     echo "持有 Nginx 端口的进程："
     sudo lsof -i -P -n | grep LISTEN | grep nginx
}

# 查看 PHP-FPM 进程、端口和资源占用情况
view_php_details() {
     echo "PHP-FPM 进程和资源详情："
     echo "进程："
     ps aux | grep php-fpm
     echo
     echo "监听端口："
     sudo netstat -tunlp | grep php-fpm
     echo
     echo "持有 PHP-FPM 端口的进程："
     sudo lsof -i -P -n | grep LISTEN | grep php-fpm
}

# 查看 Redis 进程、端口和资源占用情况
view_redis_details() {
     echo "Redis 进程和资源详情："
     echo "进程："
     ps aux | grep redis-server
     echo
     echo "监听端口："
     sudo netstat -tunlp | grep redis-server
     echo
     echo "持有 Redis 端口的进程："
     sudo lsof -i -P -n | grep LISTEN | grep redis-server
}

# 查看 FTP 进程、端口和资源占用情况
view_ftp_details() {
     echo "FTP 进程和资源详情："
     echo "进程："
     ps aux | grep vsftpd   # 假设 FTP 服务为 vsftpd
     echo
     echo "监听端口："
     sudo netstat -tunlp | grep vsftpd
     echo
     echo "持有 FTP 端口的进程："
     sudo lsof -i -P -n | grep LISTEN | grep vsftpd
}

# 查看 Composer 进程、端口和资源占用情况
view_composer_details() {
     echo "Composer 进程和资源详情："
     echo "Composer 不是一个服务器进程，因此没有端口或专用进程用于监控。"
}

# 主逻辑
while true; do
     print_help
     read -p "输入要查看详情的服务编号 (或 'q' 退出): " service_number

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
             echo "无效选项"
             ;;
     esac
done
