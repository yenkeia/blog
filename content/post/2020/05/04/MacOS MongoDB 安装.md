---
title: "MacOS MongoDB 安装"
date: 2020-05-04T23:32:07+08:00
draft: false
# tags:
#   -
categories:
  - 其他
---

## Ubuntu Server 16.04 安装 MongoDB

- sudo apt install mongodb -y
- 配置文件在 /etc/mongodb.conf

## MacOS 安装 MongoDB

### 方法 1: brew 安装

- brew tap mongodb/brew
- brew install mongodb-community
- brew untap mongodb/brew (删除仓库)
- 默认配置文件位置参考[官方文档](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/)

### 方法 2: 二进制文件安装

- 从[官方网站](https://www.mongodb.com/download-center)下载可执行文件
- tar -xvzf mongodb-osx-ssl-x86_64-3.6.18.tgz -C /usr/local/share (解压从官网下载的可执行文件)
- export MONGO_BIN=/usr/local/share/mongodb-osx-x86_64-3.6.18/bin
- mkdir /usr/local/share/mongodb-osx-x86_64-3.6.18/data (新建数据目录)
- 编辑配置文件 sudo vim /etc/mongod.conf, [输入以下内容](https://docs.mongodb.com/manual/reference/configuration-options/)

```yaml
systemLog:
  destination: file
  # path: "/var/log/mongod.log"
  path: "/tmp/mongod.log"
  logAppend: true
storage:
  dbPath: "/usr/local/share/mongodb-osx-x86_64-3.6.18/data"
  journal:
    enabled: true
# processManagement:
#   fork: true
net:
  bindIp: 127.0.0.1
  port: 27017
setParameter:
  enableLocalhostAuthBypass: false
```

- 启动 sudo mongod -f /etc/mongod.conf
