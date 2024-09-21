#!/bin/bash

# 打印帮助信息和作者信息
print_help() {
     echo "作者：抖音海上森林一只猫"
     echo "联系方式：kukuqi666@gmail.com"
     echo "代码仓库："
     echo
     echo "Usage: $0"
     echo "选择安装服务："
     echo "1. MySQL (MariaDB)"
     echo "2. Nginx"
     echo "3. PHP-FPM"
     echo "4. Redis"
     echo "5. FTP"
     echo "6. Composer"
     echo "q. 退出"
}

# 安装 MySQL (MariaDB)
install_mysql() {
     echo "可用的 MariaDB 版本: 5.7, 8.0"
     read -p "请输入要安装的 MariaDB 版本: " mysql_version
     sudo yum update
     if [[ $mysql_version == "5.7" ]]; then
         sudo yum install -y mariadb-server-5.7
     elif [[ $mysql_version == "8.0" ]]; then
         sudo yum install -y mariadb-server
     else
         echo "无效的 MariaDB 版本"
     fi
}

# 安装 Nginx
install_nginx() {
     echo "可用的 Nginx 版本: stable, mainline"
     read -p "请输入要安装的 Nginx 版本: " nginx_version
     sudo yum update
     if [[ $nginx_version == "stable" ]]; then
         sudo yum install -y nginx
     elif [[ $nginx_version == "mainline" ]]; then
         sudo yum install -y epel-release
         sudo yum update
         sudo yum install -y nginx
     else
         echo "无效的 Nginx 版本"
     fi
}

# 安装 PHP-FPM
install_php() {
     echo "可用的 PHP 版本: 7.4, 8.0, 8.1"
     read -p "请输入要安装的 PHP 版本: " php_version
     sudo yum update
     if [[ $php_version == "7.4" ]]; then
         sudo yum install -y php74 php74-fpm
     elif [[ $php_version == "8.0" ]]; then
         sudo yum install -y php80 php80-php-fpm
     elif [[ $php_version == "8.1" ]]; then
         sudo yum install -y php81 php81-php-fpm
     else
         echo "无效的 PHP 版本"
     fi
     install_php_extensions $php_version
}

# 安装 PHP 扩展
install_php_extensions() {
     local php_version=$1
     echo "可用的 PHP 扩展: curl, mbstring, xml, zip, pdo, gd, openssl, json, mysql, imagick, soap, redis, Memcached, MongoDB, Swoole, apcu"
     read -p "请输入要安装的 PHP 扩展 (用空格分隔): " php_extensions
     for extension in $php_extensions; do
         sudo yum install -y php${php_version}-${extension}
     done
}

# 安装 Redis
install_redis() {
     sudo yum update
     sudo yum install -y redis
}

# 安装 FTP
install_ftp() {
     echo "可用的 FTP 服务器: vsftpd, proftpd"
     read -p "请输入要安装的 FTP 服务器: " ftp_server
     sudo yum update
     if [[ $ftp_server == "vsftpd" ]]; then
         sudo yum install -y vsftpd
     elif [[ $ftp_server == "proftpd" ]]; then
         sudo yum install -y proftpd
     else
         echo "无效的 FTP 服务器"
     fi
}

# 安装 Composer
install_composer() {
     echo "可用的 Composer 版本: 1.x, 2.x"
     read -p "请输入要安装的 Composer 版本: " composer_version
     sudo yum update
     if [[ $composer_version == "1.x" ]]; then
         curl -sS https://getcomposer.org/installer | php -- --1
         sudo mv composer.phar /usr/local/bin/composer
     elif [[ $composer_version == "2.x" ]]; then
         php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
         php composer-setup.php
         php -r "unlink('composer-setup.php');"
         sudo mv composer.phar /usr/local/bin/composer
     else
         echo "无效的 Composer 版本"
     fi
}

# 主逻辑
while true; do
     print_help
     read -p "请输入要安装的服务编号 (或 'q' 退出): " service_number

     case $service_number in
         1)
             install_mysql
             ;;
         2)
             install_nginx
             ;;
         3)
             install_php
             ;;
         4)
             install_redis
             ;;
         5)
             install_ftp
             ;;
         6)
             install_composer
             ;;
         q)
             exit 0
             ;;
         *)
             echo "无效选项"
             ;;
     esac
done
