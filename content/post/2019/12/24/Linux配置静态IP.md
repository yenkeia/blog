---
title: "Linux配置静态IP"
date: 2019-12-24T17:56:08+08:00
draft: false
# keywords:
#   -
tags: 
  - Linux
categories:
  - 笔记
---

#### CentOS 8
```bash
cd /etc/sysconfig/network-scripts
vim ifcfg-网卡名
```
写入如下内容
```ini
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="static"          <-- 由 dhcp 动态分配 IP 改为 static
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="enp0s8"               <-- 网卡名
UUID="5b7a74a7-a5e6-4527-9cd6-6b11d4d26989"     <-- 由 uuidgen 生成，必须修改
DEVICE="enp0s8"             <-- 网卡名
ONBOOT="yes"

IPADDR="192.168.56.79"      <-- 想要设置成的静态 IP
NETMASK="255.255.255.0"
```
对比 ifcfg-enp0s3
```ini
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="dhcp"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="enp0s3"
UUID="7dadbb92-ca08-4a8c-b61f-ee93473f02ac"
DEVICE="enp0s3"
ONBOOT="yes"
```
重启网络服务让配置生效
```bash
systemctl restart NetworkManager.service
```

#### Ubuntu 18.04
```bash
cd /etc/netplan
vim 05-cloud-init.yaml
# sudo netplan generate
```
输入以下内容
```yaml
network:
    ethernets:
        enp3s0:                     <-- 网卡名
            dhcp4: false            <-- 不获取动态 IP
            addresses:
                - 192.168.1.97/24   <-- 静态 IP
            gateway4: 192.168.1.1   <-- 路由地址
            nameservers:
                addresses:
                    - 223.5.5.5     <-- 阿里云 DNS
                    - 223.6.6.6
                search: []
    version: 2
```
应用修改使配置生效
```bash
sudo netplan apply
```
