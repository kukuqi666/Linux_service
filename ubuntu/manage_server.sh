#!/bin/bash

# 定义服务名称和对应的命令
services=("MySQL" "Nginx" "PHP-FPM" "Redis" "FTP" "Composer")
commands=("mysql" "nginx" "php8.3-fpm" "redis-server" "vsftpd" "composer")  # php-fpm需要根据安装版本号来进行使用

# 打印帮助信息和作者信息
print_help() {
    echo "作者：抖音海上森林一只猫"
    echo "联系方式：kukuqi666@gmail.com"
    echo "代码仓库：https://github.com/kukuqi666"
    echo
    echo "Usage: $0"
    echo "Select a service to manage:"
    for i in "${!services[@]}"; do
        echo "$((i+1)). ${services[$i]}"
    done
    echo "q. Quit"
}

# 打印子菜单
print_sub_menu() {
    local service_index=$1
    echo "1. Start ${services[$service_index]}"
    echo "2. Stop ${services[$service_index]}"
    echo "3. Status of ${services[$service_index]}"
    echo "4. Enable Startup on Boot for ${services[$service_index]}"
    echo "5. Disable Startup on Boot for ${services[$service_index]}"
    echo "6. Back to main menu"
}

# 启动指定服务
start_service() {
    local service_index=$1
    if systemctl start ${commands[$service_index]} >/dev/null 2>&1; then
        echo "${services[$service_index]} service started"
    else
        echo "Error starting ${services[$service_index]} service"
    fi
}

# 停止指定服务
stop_service() {
    local service_index=$1
    if systemctl stop ${commands[$service_index]} >/dev/null 2>&1; then
        echo "${services[$service_index]} service stopped"
    else
        echo "Error stopping ${services[$service_index]} service"
    fi
}

# 查看指定服务状态
status_service() {
    local service_index=$1
    if systemctl status ${commands[$service_index]} >/dev/null 2>&1; then
        echo "${services[$service_index]} service is running"
    else
        echo "${services[$service_index]} service is not running"
    fi
}

# 开启指定服务开机自启
enable_service_startup() {
    local service_index=$1
    if systemctl enable ${commands[$service_index]} >/dev/null 2>&1; then
        echo "Enabled startup on boot for ${services[$service_index]} service"
    else
        echo "Error enabling startup on boot for ${services[$service_index]} service"
    fi
}

# 关闭指定服务开机自启
disable_service_startup() {
    local service_index=$1
    if systemctl disable ${commands[$service_index]} >/dev/null 2>&1; then
        echo "Disabled startup on boot for ${services[$service_index]} service"
    else
        echo "Error disabling startup on boot for ${services[$service_index]} service"
    fi
}

# 处理子菜单选项
handle_sub_menu() {
    local service_index=$1
    while true; do
        print_sub_menu $service_index
        read -p "Choose an option for ${services[$service_index]}: " action
        case $action in
            1)
                start_service $service_index
                ;;
            2)
                stop_service $service_index
                ;;
            3)
                status_service $service_index
                ;;
            4)
                enable_service_startup $service_index
                ;;
            5)
                disable_service_startup $service_index
                ;;
            6)
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

    # 验证服务编号
    if [[ $service_number == "q" ]]; then
        exit 0
    elif ! [[ $service_number =~ ^[1-6]$ ]]; then
        echo "Invalid service number"
        continue
    fi

    service_index=$((service_number-1))
    handle_sub_menu $service_index
done

