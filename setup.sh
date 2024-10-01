#!/bin/bash

# 定义菜单
function show_menu {
    echo "执行以下选项："
    echo "1. 配置 Astronvim"
    echo "2. 退出"
}

# 执行 Astronvim 配置的操作
function configure_astronvim {
    echo "正在安装 Astronvim..."
    
    # 初始化和更新 Git 子模块
    git submodule init
    git submodule update

    # 备份现有 Neovim 配置和数据
    mv ~/.config/nvim ~/.config/nvim.bak
    mv ~/.local/share/nvim ~/.local/share/nvim.bak
    mv ~/.local/state/nvim ~/.local/state/nvim.bak
    mv ~/.cache/nvim ~/.cache/nvim.bak

    # 移动新的 Astronvim 配置
    mv ./astronvim ~/.config/nvim

    echo "Astronvim 配置已安装完成！"
}

# 主程序
while true; do
    show_menu
    read -p "请输入选项: " choice
    case $choice in
        1)
            configure_astronvim
            ;;
        2)
            echo "退出程序。"
            exit 0
            ;;
        *)
            echo "无效选项，请重新输入。"
            ;;
    esac
done

