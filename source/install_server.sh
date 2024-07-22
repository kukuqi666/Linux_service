#!/bin/bash

# 打印帮助信息和作者信息
print_help() {
    echo "作者：抖音海上森林一只猫"
    echo "联系方式：kukuqi666@gmail.com"
    echo "代码仓库：https://github.com/kukuqi666"
    echo
    echo "Usage: $0"
    echo "Select an option to install:"
    echo "1. MySQL"
    echo "2. Nginx"
    echo "3. PHP-FPM"
    echo "4. Redis"
    echo "5. FTP"
    echo "6. Composer"
    echo "q. Quit"
}

# 安装 MySQL
install_mysql() {
    echo "Available MySQL versions: 5.7, 8.0"
    read -p "Enter the version of MySQL to install: " mysql_version
    sudo apt update
    if [[ $mysql_version == "5.7" ]]; then
        sudo apt install -y mysql-server-5.7
    elif [[ $mysql_version == "8.0" ]]; then
        sudo apt install -y mysql-server
    else
        echo "Invalid MySQL version"
    fi
}

# 安装 Nginx
install_nginx() {
    echo "Available Nginx versions: stable, mainline"
    read -p "Enter the version of Nginx to install: " nginx_version
    sudo apt update
    if [[ $nginx_version == "stable" ]]; then
        sudo apt install -y nginx
    elif [[ $nginx_version == "mainline" ]]; then
        sudo add-apt-repository -y ppa:nginx/development
        sudo apt update
        sudo apt install -y nginx
    else
        echo "Invalid Nginx version"
    fi
}

# 安装 PHP-FPM
install_php() {
    echo "Available PHP versions: 7.4, 8.0, 8.1"
    read -p "Enter the version of PHP to install: " php_version
    sudo apt update
    if [[ $php_version == "7.4" ]]; then
        sudo apt install -y php7.4-fpm
    elif [[ $php_version == "8.0" ]]; then
        sudo apt install -y php8.0-fpm
    elif [[ $php_version == "8.1" ]]; then
        sudo apt install -y php8.1-fpm
    else
        echo "Invalid PHP version"
    fi
    install_php_extensions $php_version
}

# 安装 PHP 扩展
install_php_extensions() {
    local php_version=$1
    echo "Available PHP extensions: curl, mbstring, xml, zip,pdo,gd,openssl,json,mysql,imagick,soap,redis,Memcached,MongoDB,Swoole,apcu"
    read -p "Enter the PHP extensions to install (separated by spaces): " php_extensions
    for extension in $php_extensions; do
        sudo apt install -y php${php_version}-${extension}
    done
}

# 安装 Redis
install_redis() {
    sudo apt update
    sudo apt install -y redis-server
}

# 安装 FTP
install_ftp() {
    echo "Available FTP servers: vsftpd, proftpd"
    read -p "Enter the FTP server to install: " ftp_server
    sudo apt update
    if [[ $ftp_server == "vsftpd" ]]; then
        sudo apt install -y vsftpd
    elif [[ $ftp_server == "proftpd" ]]; then
        sudo apt install -y proftpd
    else
        echo "Invalid FTP server"
    fi
}

# 安装 Composer
install_composer() {
    echo "Available Composer versions: 1.x, 2.x"
    read -p "Enter the version of Composer to install: " composer_version
    sudo apt update
    if [[ $composer_version == "1.x" ]]; then
        sudo curl -sS https://getcomposer.org/installer | php -- --1
        sudo mv composer.phar /usr/local/bin/composer
    elif [[ $composer_version == "2.x" ]]; then
        sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
        sudo php composer-setup.php
        sudo php -r "unlink('composer-setup.php');"
        sudo mv composer.phar /usr/local/bin/composer
    else
        echo "Invalid Composer version"
    fi
}

# 主逻辑
while true; do
    print_help
    read -p "Enter the service number to install (or 'q' to quit): " service_number

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
            echo "Invalid option"
            ;;
    esac
done

