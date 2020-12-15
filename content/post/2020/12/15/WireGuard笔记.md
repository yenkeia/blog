---
title: "WireGuard笔记"
date: 2020-12-15T09:15:07+08:00
draft: false
tags:
  - 日常记录
---

## 简介

WireGuard 是个 VPN, 多用于企业之间的数据安全传输.

## 准备

使用 Parallels Desktop 新建两台 CentOS 7.9 的 Linux 虚拟机, 分别命名为 vm01, vm02.

```bash
# 关闭防火墙
systemctl stop firewalld.service
# 安装
yum install -y epel-release elrepo-release
yum install -y yum-plugin-elrepo
yum install -y kmod-wireguard wireguard-tools
```

## 名词解析

- 网卡
- 网关
- 路由
- 路由器

## 入门

跟着[WireGuard 官网](https://www.wireguard.com/quickstart/)中的视频一步一步操作

```bash
# vm01
wg genkey > private
ip link add wg0 type wireguard
ip addr add 10.0.0.1/24 dev wg0
wg set wg0 private-key ./private
ip link set wg0 up
# vm02
wg genkey > private
wg pubkey < private
ip link add wg0 type wireguard
ip addr add 10.0.0.2/24 dev wg0
wg set wg0 private-key ./private
ip link set wg0 up
```

使用 `ip addr` 命令查看所有网络信息, 得到 vm01, vm02 的 eth0 网卡分配到的 ipv4 地址分别为 10.211.55.10, 10.211.55.11 并且互相能 ping 通, 还能看到 wg0 网卡信息.

使用 `wg` 命令查看 WireGuard 信息

```plain
# vm01
interface: wg0
  public key: OgbUF/E21zi9qHf5h9H6N/iM92nnNYgRtOMhReFm730=
  private key: (hidden)
  listening port: 35304
# vm02
interface: wg0
  public key: 4MIj+Te/pKnszjk9kc72E/YEhMeBdS8U1vPEg2PxSQI=
  private key: (hidden)
  listening port: 39114
```

配置 wg

```bash
# vm01
wg set wg0 peer <vm02 的 public key> allowed-ips <vm02 的 wg0 地址/32> endpoint <vm02 的 eth0 ipv4 地址:listerning port>
# vm02
wg set wg0 peer <vm01 的 public key> allowed-ips <vm01 的 wg0 地址/32> endpoint <vm01 的 eth0 ipv4 地址:listerning port>
```

验证两台虚拟机是否能用 wg0 网卡互联

```bash
# vm01
ping 10.0.0.2
# vm02
ping 10.0.0.1
```

再次用 `wg` 命令发现 peer 的 lasted handshake 有信息即配置 wireguard 完成.

## 一些有用的命令

查看配置好的网络情况 `ip a | grep eth0`

```plain
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    inet 10.211.55.11/24 brd 10.211.55.255 scope global noprefixroute dynamic eth0
```

查看各网卡当前路由`ip route show`

```plain
default via 10.211.55.1 dev eth0 proto dhcp metric 100
10.211.55.0/24 dev eth0 proto kernel scope link src 10.211.55.11 metric 100
192.168.122.0/24 dev virbr0 proto kernel scope link src 192.168.122.1
```

## 参考

- [网关和路由器的区别是什么？](https://www.zhihu.com/question/21787311)
- [Linux 下配置多网卡多网关](https://www.hi-linux.com/posts/64963.html)
