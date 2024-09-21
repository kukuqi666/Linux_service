#!/bin/bash

# 打印帮助信息和作者信息
print_help() {
    echo "数据库操作工具"
    echo "作者：kukuqi"
    echo "联系方式：kukuqi666@gmail.com"
    echo "代码仓库：https://github.com/kukuqi666"
    echo
    echo "Usage: $0"
    echo "1. 连接数据库"
    echo "2. 进入数据库"
    echo "3. 配置数据库"
    echo "4. 修改数据库用户名和密码"
    echo "5. 查看数据库用户名、数据库和数据表"
    echo "6. 添加数据库用户和密码"
    echo "7. 删除数据库用户和密码"
    echo "8. 添加数据库"
    echo "9. 删除数据库"
    echo "10. 导入数据表单"
    echo "11. 删除数据表单"
    echo "q. 退出"
}

# 连接数据库
connect_database() {
    read -p "输入数据库用户名: " db_user
    read -sp "输入数据库密码: " db_pass
    mysql -u$db_user -p$db_pass
}

# 进入数据库
enter_database() {
    read -p "输入数据库用户名: " db_user
    read -sp "输入数据库密码: " db_pass
    read -p "输入数据库名称: " db_name
    mysql -u$db_user -p$db_pass $db_name
}

# 配置数据库
configure_database() {
    echo "开始配置数据库..."
    sudo mysql_secure_installation
    echo "数据库配置完成"
}

# 修改数据库用户名和密码
change_database_credentials() {
    echo "1. 修改数据库用户名"
    echo "2. 修改数据库密码"
    read -p "选择操作: " choice

    case $choice in
        1)
            read -p "输入当前数据库用户名: " current_user
            read -sp "输入当前密码: " db_pass
            read -p "输入新用户名: " new_user
            mysql -u$current_user -p$db_pass -e "RENAME USER '$current_user'@'localhost' TO '$new_user'@'localhost';"
            echo "数据库用户名已修改为 $new_user"
            ;;
        2)
            read -p "输入数据库用户名: " db_user
            read -sp "输入当前密码: " db_pass
            read -sp "输入新密码: " new_pass
            mysql -u$db_user -p$db_pass -e "ALTER USER '$db_user'@'localhost' IDENTIFIED BY '$new_pass';"
            echo "数据库用户 $db_user 密码已修改"
            ;;
        *)
            echo "无效选项，请重新选择"
            ;;
    esac
}

# 查看数据库用户名、数据库和数据表
view_databases_and_tables() {
    read -p "输入数据库用户名: " db_user
    read -sp "输入数据库密码: " db_pass
    mysql -u$db_user -p$db_pass -e "SELECT User FROM mysql.user;"
    mysql -u$db_user -p$db_pass -e "SHOW DATABASES;"
    read -p "输入要查看的数据库名: " db_name
    mysql -u$db_user -p$db_pass -e "USE $db_name; SHOW TABLES;"
}

# 添加数据库用户和密码
add_database_user() {
    read -p "输入新数据库用户名: " new_user
    read -sp "输入新数据库用户密码: " new_pass
    mysql -u root -p -e "CREATE USER '$new_user'@'localhost' IDENTIFIED BY '$new_pass';"
    mysql -u root -p -e "GRANT ALL PRIVILEGES ON *.* TO '$new_user'@'localhost';"
    mysql -u root -p -e "FLUSH PRIVILEGES;"
    echo "数据库用户 $new_user 添加完成"
}

# 删除数据库用户和密码
delete_database_user() {
    read -p "输入要删除的数据库用户名: " del_user
    mysql -u root -p -e "DROP USER '$del_user'@'localhost';"
    mysql -u root -p -e "FLUSH PRIVILEGES;"
    echo "数据库用户 $del_user 删除完成"
}

# 添加数据库
add_database() {
    read -p "输入数据库用户名: " db_user
    read -sp "输入数据库密码: " db_pass
    read -p "输入要添加的数据库名: " db_name
    mysql -u$db_user -p$db_pass -e "CREATE DATABASE $db_name;"
    echo "数据库 $db_name 添加完成"
}

# 删除数据库
delete_database() {
    read -p "输入数据库用户名: " db_user
    read -sp "输入数据库密码: " db_pass
    read -p "输入要删除的数据库名: " db_name
    mysql -u$db_user -p$db_pass -e "DROP DATABASE $db_name;"
    echo "数据库 $db_name 删除完成"
}

# 导入数据表单
import_table() {
    read -p "输入数据库用户名: " db_user
    read -sp "输入数据库密码: " db_pass
    read -p "输入数据库名称: " db_name
    read -p "输入SQL文件路径: " sql_file
    mysql -u$db_user -p$db_pass $db_name < $sql_file
    echo "数据表单导入完成"
}

# 删除数据表单
delete_table() {
    read -p "输入数据库用户名: " db_user
    read -sp "输入数据库密码: " db_pass
    read -p "输入数据库名称: " db_name
    read -p "输入要删除的表名: " table_name
    mysql -u$db_user -p$db_pass -e "USE $db_name; DROP TABLE $table_name;"
    echo "数据表 $table_name 删除完成"
}

# 主逻辑
while true; do
    print_help
    read -p "选择操作 (或 'q' 退出): " choice

    case $choice in
        1)
            connect_database
            ;;
        2)
            enter_database
            ;;
        3)
            configure_database
            ;;
        4)
            change_database_credentials
            ;;
        5)
            view_databases_and_tables
            ;;
        6)
            add_database_user
            ;;
        7)
            delete_database_user
            ;;
        8)
            add_database
            ;;
        9)
            delete_database
            ;;
        10)
            import_table
            ;;
        11)
            delete_table
            ;;
        q)
            exit 0
            ;;
        *)
            echo "无效选项，请重新选择"
            ;;
    esac

    echo
done

