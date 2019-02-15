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

# ubuntu 18.04 快捷键
- Ctrl + Shift + C      复制
- Ctrl + Shift + V      粘贴
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
- `tar -xvzf xxx.tar.gz`
- `tar czf name_of_archive_file.tar.gz name_of_directory_to_tar`

# linux
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

# tmux
- tmux ls
- tmux attach -t 0/1/2/3

# docker
- docker container rm $(docker container ls -aq)   删除所有container -q意思只列id
- docker rm $(docker container ls -f "status=exited" -q)  删除所有已经退出的container

# vscode
- option + command + F      查找替换        MacOS
- Ctrl + Shift + I          格式化代码      Ubuntu
- Ctrl + 回车               下一行          Ubuntu
- Ctrl + Shift + 回车       上一行          Ubuntu
- Ctrl + P                  打开文件        Ubuntu

# git
- 初始化  git submodule update --init --recursive
- 更新    git submodule update --recursive --remote
- git rm --cached file1.txt   删除一个已经提交到仓库的文件
- git config --get remote.origin.url
- git remote show origin

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


# vim
- `` / ''               光标在上一个位置 / 下一个位置之间移动
- ctrl + O              光标回到上一个位置
- ctrl + I              光标去到下一个位置
- TAB替换为空格：
    - :set ts=4
    - :set expandtab

- 空格替换为TAB：
    - :set ts=4
    - :set noexpandtab

```vim
set nocompatible
syntax on                  " Enable syntax highlighting.

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set incsearch              " Highlight while searching with / or ?.
set ignorecase             " Ignore case when searching
" set hlsearch               " Keep matches highlighted.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set nobackup               " Do not keep a backup file

set novisualbell           " no blink ?
set pastetoggle=<F12>

" 高亮多余的空白字符及 Tab
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

" set number
" highlight LineNr ctermfg=grey
```
