import os
import subprocess
def run_script(script_name):
    script_path = os.path.join('/home/ubuntu/桌面/tool/ubuntu', script_name)
    if not os.path.isfile(script_path):
        print(f"错误: 找不到脚本 {script_path}")
        return
    if not os.access(script_path, os.sh_OK):
        print(f"错误: 脚本 {script_path} 没有可执行权限")
        return
    try:
        result = subprocess.run([ script_path])
        print(result.stdout)
    except subprocess.TimeoutExpired:
        print(f"脚本 {script_path} 超时")
    except subprocess.CalledProcessError as e:
        print(f"脚本 {script_path} 执行错误: {e}")
        print(e.stderr)

def main():
    scripts = {
        "1": "database_tool.sh",
        "2": "manage_server.sh",
        "3": "view_source.sh",
        "4": "settings.sh",
        "5": "ufw.sh",
        "6": "install_server.sh",
        "7": "uninstall.sh",
        "q": "退出"
    }
    
    while True:
        print("选择一个脚本运行:")
        for key, value in scripts.items():
            print(f"{key}. {value}")
        
        choice = input("选择操作 (或 'q' 退出): ")

        if choice in scripts:
            if choice == 'q':
                print("退出")
                break
            script = scripts[choice]
            print(f"正在运行脚本 {script}")
            run_script(script)
        else:
            print("无效选项，请重新选择")

if __name__ == "__main__":
    main()

