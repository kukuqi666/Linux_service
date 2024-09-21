#!/bin/bash

# 定义服务名称和对应的命令
services=("MySQL" "Nginx" "PHP-FPM" "Redis" "FTP" "Composer")
commands=("mariadb" "nginx" "php-fpm" "redis" "vsftpd" "composer")   # 注意：CentOS 7中PHP-FPM命令为php-fpm，不带版本号

# 打印帮助信息和作者信息
print_help() {
    echo "作者：抖音海上森林一只猫"
    echo "联系方式：kukuqi666@gmail.com"
    echo "代码仓库："
    echo
    echo "Usage: $0"
    echo "选择一个服务进行管理："
    for i in "${!services[@]}"; do
        echo "$((i+1)). ${services[$i]}"
    done
    echo "q. 退出"
}

# 打印子菜单
print_sub_menu() {
    local service_index=$1
    echo "1. 启动 ${services[$service_index]}"
    echo "2. 停止 ${services[$service_index]}"
    echo "3. 查看 ${services[$service_index]} 状态"
    echo "4. 开机启动 ${services[$service_index]}"
    echo "5. 关闭开机启动 ${services[$service_index]}"
    echo "6. 返回主菜单"
}

# 启动指定服务
start_service() {
    local service_index=$1
    if systemctl start ${commands[$service_index]} >/dev/null 2>&1; then
        echo "${services[$service_index]} 服务已启动"
    else
        echo "启动 ${services[$service_index]} 服务时出错"
    fi
}

# 停止指定服务
stop_service() {
    local service_index=$1
    if systemctl stop ${commands[$service_index]} >/dev/null 2>&1; then
        echo "${services[$service_index]} 服务已停止"
    else
        echo "停止 ${services[$service_index]} 服务时出错"
    fi
}

# 查看指定服务状态
status_service() {
    local service_index=$1
    if systemctl status ${commands[$service_index]} >/dev/null 2>&1; then
        echo "${services[$service_index]} 服务正在运行"
    else
        echo "${services[$service_index]} 服务未运行"
    fi
}

# 开启指定服务开机自启
enable_service_startup() {
    local service_index=$1
    if systemctl enable ${commands[$service_index]} >/dev/null 2>&1; then
        echo "已启用 ${services[$service_index]} 服务开机自启"
    else
        echo "启用 ${services[$service_index]} 服务开机自启时出错"
    fi
}

# 关闭指定服务开机自启
disable_service_startup() {
    local service_index=$1
    if systemctl disable ${commands[$service_index]} >/dev/null 2>&1; then
        echo "已禁用 ${services[$service_index]} 服务开机自启"
    else
        echo "禁用 ${services[$service_index]} 服务开机自启时出错"
    fi
}

# 处理子菜单选项
handle_sub_menu() {
    local service_index=$1
    while true; do
        print_sub_menu $service_index
        read -p "选择一个操作选项: " action
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
                echo "无效选项"
                ;;
        esac
    done
}

# 主逻辑
while true; do
    print_help
    read -p "输入要管理的服务编号 (或 'q' 退出): " service_number

    # 验证服务编号
    if [[ $service_number == "q" ]]; then
        exit 0
    elif ! [[ $service_number =~ ^[1-6]$ ]]; then
        echo "无效的服务编号"
        continue
    fi

    service_index=$((service_number-1))
    handle_sub_menu $service_index
done
