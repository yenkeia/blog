# windows
- ctrl + 光标左右    单词之间跳转

# sqlyog
- ctrl + shift + B  快速过滤表
- F9                执行选中 SQL
- ctrl + N          新tab
- ctrl + TAB        tab之间切换

# java debug
sudo java -jar -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 target/jar包.war` (JDK 1.8)

# mysql
- `CREATE DATABASE xxxx CHARACTER SET utf8 COLLATE utf8_general_ci;`
- jdbc 插入中文却显示?? `jdbc:mysql://xxx.xxx.xxx.xxx:3306/databaseName?useUnicode=true&characterEncoding=UTF-8`
- [copy database](https://stackoverflow.com/questions/675289/cloning-a-mysql-database-on-the-same-mysql-instance)
- ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '密码';
- CREATE USER 'root'@'%' IDENTIFIED BY '密码';
- GRANT ALL ON *.* TO 'root'@'%';
- FLUSH PRIVILEGES;



# ubuntu 18.04 快捷键
- Ctrl + Shift + C      terminal 复制
- Ctrl + Shift + V      terminal 粘贴
- Ctrl + Shift + T      terminal 新 tab
- Ctrl + Shift + W      terminal 关闭 tab
- Alt + 1/2/3           切换 terminal tab
- Alt + 1/2/3           chrome 切换 tab
- Ctrl + Alt + T        新 terminal 进程
- Ctrl + Alt + D        显示/隐藏 桌面
- Ctrl + Alt + 上下     切换 workspace
- Win + A               显示 App (连续按两次显示打开的App)
- Win + Tab             切换到最近的 App = Alt + Tab
- Win + ↑/↓             App 全屏/App窗口化
- Shift + Win + ←/→     App 从右边屏幕移到左边/左到右
- Win + 数字            切换 App 焦点(focus
- Win + P               切换输出    [关闭方法](https://askubuntu.com/questions/68463/how-to-disable-global-super-p-shortcut)
- genpac --pac-proxy "SOCKS5 127.0.0.1:1080" --gfwlist-proxy="SOCKS5 127.0.0.1:1080" --gfwlist-url=https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt --output="autoproxy.pac"
- /usr/bin/google-chrome-stable %U --no-sandbox --proxy-server="socks5://127.0.0.1:1080"
- ctrl + alt + F7       图形界面
- ctrl + alt + F1 ~ F6  命令行界面

# ubuntu 18.04 阿里源
```bash
/etc/apt/sources.list

deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
```

# supervisor
- `reread` - Reread supervisor configuration. Do not update or restart the running services.
- `update` - Restart service(s) whose configuration has changed. Usually run after 'reread'.
- `reload` - Reread supervisor configuration, reload supervisord and supervisorctl, restart services that were started.
- `restart` - Restart service(s)
- https://github.com/Supervisor/supervisor/issues/720

# maven
- mvn clean package -Dmaven.test.skip=true 清理并打包并跳过测试

# tar
- `tar -tvf file.tar`                       列出压缩文件内容
- `tar -xvzf xxx.tar.gz`
- `tar czf name_of_archive_file.tar.gz name_of_directory_to_tar`

# linux
cp -v  show process of copy file/directory
ls -r  reverse order
   -t  sort by modification time, newest first
   -R  list subdirectories recursively
cd -  return to last directory

```
echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8
```
- chmod u+x xxx         使xxx文件可执行
- lsblk                 列出块设备信息( lsblk -f    列出文件系统类型 FSTYPE
- mount -t ntfs /dev/sdb1 /media/sdb    以 ntfs 挂载 /dev/sdb1 到 /media/sdb 路径下 (lsblk -> disk -> part
- df -h                 文件系统磁盘空间使用情况
- umount /media/sdb     不挂载设备
- eject                 弹出设备    (lsblk -> disk

# find
- MacOS: `find . -type f -name "*.js" -exec sed -i '' -e 's/想要替换的文本/替换成的文本/g' {} +`
- Linux: `find . -type f -name "*.js" -exec sed -i 's/想要替换的文本/替换成的文本/g' {} +`
- `find . -name "*.java" -exec grep "文本" -Hn {} \;`
- `find . -name "*.log" -exec rm -rfv {} +`
- `find -name "*.js" -not -path "./directory/*"`    不包含某个目录下的文件
- sed '/^#/ d' 要删除#的文件名 > 新的文件名         [删除以#开头的行](https://stackoverflow.com/questions/8206280/delete-all-lines-beginning-with-a-from-a-file)

# tmux
- tmux ls
- tmux attach -t 0/1/2/3

# docker
- docker container rm $(docker container ls -aq)   删除所有container -q意思只列id
- docker rm $(docker container ls -f "status=exited" -q)  删除所有已经退出的container
- docker run -it -p 本地端口:容器端口 image:tag
- docker stop $(docker ps -a -q)        停止所有正在运行 container
- docker rm $(docker ps -a -q)          删除所有正在运行的 container
- docker rmi 镜像id                     删除镜像


# vscode
- Ctrl + Alt + -            返回光标之前位置 (在 Ctrl + 鼠标左键进入函数定义后返回之前的位置) Ubuntu
- Ctrl + -                  返回光标之前位置 # Macos
- option + command + F      查找替换        Macos
- Ctrl + Shift + I          格式化代码      Ubuntu
- Ctrl + 回车               下一行          Ubuntu
- Ctrl + Shift + 回车       上一行          Ubuntu
- Ctrl + P                  打开文件        Ubuntu
- # (Shift + 3)             去到该字符串最近出现的地方 类似跳转到引用处

# vscode golang
- 测试用例 t.Log() 输出需要在 .vscode/settings.json 加上 "go.testFlags": ["-v"]
- F12                       去到函数定义   # Ubuntu
- Fn + F12                  去到函数定义   # Macos
- Shift + F12               显示所有引用到该函数的地方  # Ubuntu
- Fn + Shift + F12          显示所有引用到该函数的地方  # Macos

# git
- 初始化  git submodule update --init --recursive
- 更新    git submodule update --recursive --remote
- git rm --cached file1.txt   删除一个已经提交到仓库的文件
- git config --get remote.origin.url
- git remote show origin
- .git/info/exclude     该项目本地忽略的文件

# mongo
- keep mongod running
- mongod --fork --logpath /var/log/mongod.log
- https://serverfault.com/questions/157705/how-can-i-run-mongod-in-the-background-on-unix-mac-osx

# idea
- option command + V    生成返回值
- option command + T    对选中的代码（行）进行（try-catch等）操作
- Ctrl + ←/→            editor tab 切换
- Ctrl + F4             关闭 tab
- Ctrl + .              折叠代码
- Ctrl + -/+            折叠代码
- F12                   锚点从编辑窗口切换到文件目录
- Ctrl + Alt + B        跳到方法实现
- Ctrl + B              跳到方法调用处
- Shift + Alt + ↑↓      对当前行上下移动
- Ctrl + Alt + ←→       后退/前进   如当跳到方法实现处后,后退   [与 ubuntu 切换 workspace 冲突](https://stackoverflow.com/questions/47808160/intellij-idea-ctrlaltleft-shortcut-doesnt-work-in-ubuntu)

# nerdtree
- m                     进入菜单
- C                     改变为当前目录
- x                     收起当前目录
- r                     刷新目录

# vim
- ctrl + a/x            数字加 / 减 1
- gt / gT / 1gt / 2gt   下个tab / 上个tab / 第一个tab / 第二个tab
- bufdo bd              对所有 buffer 缓冲区 执行 bd(删除) 操作
- bd 2 3 5              同时删除 2 3 5 缓冲区
- zt                    当前编辑行置为屏顶
- zz                    当前编辑行置为屏中
- zb                    当前编辑行置为屏低
- `` / ''               光标在上一个位置 / 下一个位置之间移动
- ctrl + O              光标回到上一个位置
- ctrl + I              光标去到下一个位置
- ctrl + F              屏幕向下滚一屏
- ctrl + B              屏幕向上滚一屏
- ctrl + E              屏幕向下滚一行
- ctrl + Y              屏幕向上滚一行
- ctrl + D              光标向下跳半屏  (屏幕向下半屏 L + zz
- ctrl + U              光标向上跳半屏  (屏幕向上半屏 H + zz
- TAB替换为空格：
    - :set ts=4
    - :set expandtab

- 空格替换为TAB：
    - :set ts=4
    - :set noexpandtab

- :ls                   列出所有缓冲区
- :b1/2/3               跳到第1/2/3个缓冲区
- :bn/:bp               跳到下一个/前一个缓冲区
- :sb N                 横向打开第N个缓冲区
- :vert sb N            纵向打开第N个缓冲区
- :vs                   纵向打开当前缓冲区
- :vs 文件路径          纵向文件
- :help buffers         查看缓冲区帮助信息
- :bd N                 删除第 N 个缓冲区
- :bunload N            卸载第 N 个缓冲区   (TODO 作用和 bd 区别是?

- :GoImport             导入包
- :GoDef                跳转到方法定义 (可用 ctrl + O 跳回


