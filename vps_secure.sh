#!/bin/bash
# VPS‑secure‑script | Linux服务器加固与运维菜单工具
# Support: Ubuntu / Debian / CentOS / AlmaLinux

clear
echo "====================================="
echo "        VPS 安全运维工具箱           "
echo "====================================="

while true; do
    echo ""
    echo "【功能菜单】"
    echo "1) 系统基础更新"
    echo "2) 防火墙基础配置"
    echo "3) SSH安全加固"
    echo "4) 查看系统资源"
    echo "5) 磁盘占用检查"
    echo "0) 退出"
    read -p "请输入选项数字: " opt

    case $opt in
    1)
        echo ">>> 执行系统更新"
        if [[ -f /etc/debian_version ]];then
            apt update -y && apt upgrade -y
        else
            dnf update -y
        fi
        ;;
    2)
        echo ">>> 配置防火墙"
        if command -v ufw &>/dev/null;then
            ufw allow 22/tcp
            ufw allow 80/tcp
            ufw allow 443/tcp
            ufw enable
            ufw status
        else
            echo "ufw未安装，请手动处理firewalld"
        fi
        ;;
    3)
        echo ">>> SSH加固提示：禁止root密码登录，建议使用密钥登录"
        grep -E "^PermitRootLogin|^PasswordAuthentication" /etc/ssh/sshd_config
        ;;
    4)
        echo ">>> 系统资源"
        free -h
        top -b -n1 | head -15
        ;;
    5)
        echo ">>> 磁盘使用"
        df -h
        du -sh /* 2>/dev/null
        ;;
    0)
        echo "退出工具"
        exit 0
        ;;
    *)
        echo "无效选项"
        ;;
    esac
done
