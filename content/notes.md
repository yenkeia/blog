# maven
- mvn clean package -Dmaven.test.skip=true 清理并打包并跳过测试

# tar
- `tar -xvzf xxx.tar.gz`
- `tar czf name_of_archive_file.tar.gz name_of_directory_to_tar`

# vim
- TAB替换为空格：
    - :set ts=4
    - :set expandtab

- 空格替换为TAB：
    - :set ts=4
    - :set noexpandtab

# linux
```
echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8
```
- chmod u+x xxx       使xxx文件可执行

# find
- MacOS: `find . -type f -name "*.js" -exec sed -i '' -e 's/想要替换的文本/替换成的文本/g' {} +`
- Linux: `find . -type f -name "*.js" -exec sed -i 's/想要替换的文本/替换成的文本/g' {} +`
- `find . -name "*.java" -exec grep "文本" -Hn {} \;`
- `find . -name "*.log" -exec rm -rfv {} +`

# tmux
- tmux ls
- tmux attach -t 0/1/2/3

# docker
- docker container rm $(docker container ls -aq)   删除所有container -q意思只列id
- docker rm $(docker container ls -f "status=exited" -q)  删除所有已经退出的container

# vscode
查找替换 option + command + F

# git
- 初始化  git submodule update --init --recursive
- 更新    git submodule update --recursive --remote
- git rm --cached file1.txt   删除一个已经提交到仓库的文件

# mongo
- keep mongod running
- mongod --fork --logpath /var/log/mongod.log
- https://serverfault.com/questions/157705/how-can-i-run-mongod-in-the-background-on-unix-mac-osx

# idea
option command + V  生成返回值
