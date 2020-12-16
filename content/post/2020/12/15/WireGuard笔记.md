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

以下全部来自维基百科

- [网卡][1]

  又称网络接口控制器, 网络适配器 (network adapter), 网卡 (network interface card), 或局域网接收器 (LAN adapter), 是一块被设计用来允许计算机在计算机网络上进行通讯的计算机硬件.

  由于其拥有 MAC 地址, 因此属于 OSI 模型的第 2 层. 它使得用户可以通过电缆或无线相互连接. 每一个网卡都有一个被称为 MAC 地址的独一无二的 48 位串行号, 它被写在卡上的一块 ROM 中. 在网络上的每一个计算机都必须拥有一个独一无二的 MAC 地址. 没有任何两块被生产出来的网卡拥有同样的地址. 这是因为电气电子工程师协会 (IEEE) 负责为网络接口控制器销售商分配唯一的 MAC 地址.

  网卡以前是作为扩展卡插到计算机总线上的, 但是由于其价格低廉而且以太网标准普遍存在, 大部分新的计算机都在主板上集成了网络接口. 除非需要多接口, 否则不再需要一块独立的网卡. 甚至更新的主板可能含有内置的双网络 (以太网) 接口.

- [网关][2]

  在计算机网络中, 网关 (英语: Gateway) 是转发其他服务器通信数据的服务器, 接收从客户端发送来的请求时, 它就像自己拥有资源的源服务器一样对请求进行处理. 有时客户端可能都不会察觉, 自己的通信目标是一个网关.

  区别于路由器 (由于历史的原因, 许多有关 TCP/IP 的文献曾经把网络层使用的路由器 (英语: Router) 称为网关, 在今天很多局域网采用都是路由来接入网络, 因此现在通常指的网关就是路由器的 IP), 经常在家庭中或者小型企业网络中使用, 用于连接局域网和互联网.
  网关也经常指把一种协议转成另一种协议的设备, 比如语音网关.

- [路由][3]
  路由 (routing) 就是通过互联的网络把信息从源地址传输到目的地址的活动. 路由发生在 OSI 网络参考模型中的第三层即网络层.

  路由引导分组转送, 经过一些中间的节点后, 到它们最后的目的地. 作成硬件的话, 则称为路由器. 路由通常根据路由表——一个存储到各个目的地的最佳路径的表——来引导分组转送. 因此为了有效率的转送分组, 创建存储在路由器存储器内的路由表是非常重要的.

  路由与桥接的不同, 在于路由假设地址相似的节点距离相近. 这使得路由表中的一项纪录可以表示到一群地址的路径. 因此, 在大型网络中, 路由优于桥接, 且路由已经成为互联网上查找路径的最主要方法.

  较小的网络通常可以手动设置路由表, 但较大且拥有复杂拓扑的网络可能常常变化, 若要手动创建路由表是不切实际的. 尽管如此, 大多数的公共交换电话网络 (PSTN) 仍然使用预先计算好的路由表, 在直接连线的路径断线时才使用预备的路径; 见公共交换电话网路由. "动态路由" 尝试按照由路由协议所携带的信息来自动创建路由表以解决这个问题, 也让网络能够近自主地避免网络断线或失败.

  动态路由目前主宰了整个互联网. 然而, 设置路由协议常须要经验与技术; 目前的网络技术还没有发展到能够全自动地设置路由.

  分组交换网络 (例如互联网) 将资料分割成许多带有完整目的地地址的分组, 每个分组单独转送. 而电路交换网络 (例如公共交换电话网络) 同样使用路由来找到一条路径, 让接下来的资料能在仅带有部分目的地地址的情况下也能够抵达正确的目的地.

- [路由器][4]
  路由器 (英语: Router, 又称路径器) 是一种电讯网络设备, 提供路由与转送两种重要机制, 可以决定数据包从来源端到目的端所经过的路由路径 (host 到 host 之间的传输路径), 这个过程称为路由; 将路由器输入端的数据包移送至适当的路由器输出端 (在路由器内部进行), 这称为转送. 路由工作在 OSI 模型的第三层——即网络层, 例如网际协议 (IP).

  IP 路由器之中最常见的类型是家用和小型办公路由器, 它只在家庭电脑和互联网之间转发 IP 数据包, 例如, 用户的 cable 路由器或 DSL 路由器, 这些路由器通过互联网服务提供商 (ISP) 连接到互联网. 而像是企业级路由器之类更为复杂的路由器, 则会将大型企业或 ISP 的网络与强大的核心路由器连接起来, 沿着互联网主干网的光纤线路高速转发数据.

[1]: https://zh.wikipedia.org/wiki/%E7%BD%91%E5%8D%A1
[2]: https://zh.wikipedia.org/wiki/%E7%BD%91%E5%85%B3
[3]: https://zh.wikipedia.org/wiki/%E8%B7%AF%E7%94%B1
[4]: https://zh.wikipedia.org/zh-hans/%E8%B7%AF%E7%94%B1%E5%99%A8

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

使用 `ip addr` 命令查看所有网络接口, 得到 vm01, vm02 的 eth0 网卡分配到的 ipv4 地址分别为 10.211.55.10, 10.211.55.11 并且互相能 ping 通, 还能看到 wg0 网卡信息.

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

## 使用 wg-quick

TODO

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

## 三台机器互联

需求: 假设有 A B C 三台机器, 要实现 A(client) -> B(server&client) -> C(server)

实现:

0. 关闭 CentOS 7 的防火墙

   ```bash
   systemctl stop firewalld.service
   ```

1. 三台机器都生成秘钥

   ```bash
    cd /etc/wireguard
    wg genkey > private.key # 生成私钥
    wg pubkey < ./private.key > public.key  # 通过私钥生成公钥
   ```

2. 配置 A(client)

   新建网卡

   ```bash
    ip link add dev wg0-client type wireguard # wg0-client 为网卡名
    ip addr add dev wg0-client 10.1.0.1/24 # 设置 10.1.x.x 网段下的 IP
    ip link set wg0-client up # 启动网卡
   ```

   新建 wg0-client.conf, 内容:

   ```plain
    [Interface]
    ListenPort = 11111
    PrivateKey = <A的秘钥>

    [Peer]
    PublicKey = <B的公钥>
    AllowedIPs = 0.0.0.0/0
    Endpoint = <B的eth0网卡IP>:<B的wg0-server.conf写的ListenPort,即22222>
    PersistentKeepalive = 15
   ```

   使用 wg0-client.conf 这个配置

   ```bash
    wg setconf wg0-client ./wg0-client.conf
   ```

3. 配置 B(server)

   新建网卡

   ```bash
    ip link add dev wg0-server type wireguard
    ip addr add dev wg0-server 10.1.0.2/24 # 设置 10.1.x.x 网段下的 IP
    ip link set wg0-server up
   ```

   新建 wg0-server.conf, 内容:

   ```plain
    [Interface]
    ListenPort = 22222
    PrivateKey = <B的秘钥>

    [Peer]
    PublicKey = <A的公钥>
    AllowedIPs = 0.0.0.0/0
    Endpoint = <A的eth0网卡IP>:<A的wg0-client.conf写的ListenPort, 即11111>
    PersistentKeepalive = 15
   ```

   使用 wg0-server.conf 这个配置

   ```bash
    wg setconf wg0-server ./wg0-server.conf
   ```

4. 测试 A -> B 可以连通

   ```bash
    # A
    ping 10.1.0.2
    # B
    tcpdump -i wg0-server
   ```

   能看到 A 正常 ping 通, B tcpdump 有 request / reply, 反之也可以连通

5. 配置 B(client)

   新建网卡

   ```bash
    ip link add dev wg1-client type wireguard
    ip addr add dev wg1-client 10.2.0.1/24 # !!! 注意这是新的网段 10.2.x.x 下的 IP
    ip link set wg1-client up # 启动作为客户端的网卡
   ```

   新建 wg1-client.conf, 内容:

   ```plain
    [Interface]
    ListenPort = 23333
    PrivateKey = <B的秘钥>

    [Peer]
    PublicKey = <C的公钥>
    AllowedIPs = 0.0.0.0/0
    Endpoint = <C的eth0网卡IP>:<C的wg0-server.conf写的ListenPort,即33333>
    PersistentKeepalive = 15
   ```

   使用 wg1-client.conf 这个配置

   ```bash
    wg setconf wg1-client ./wg1-client.conf
   ```

6. 配置 C(server)

   新建网卡

   ```bash
    ip link add dev wg0-server type wireguard
    ip addr add dev wg0-server 10.2.0.2/24 # 设置 10.2.x.x 网段下的 IP
    ip link set wg0-server up
   ```

   新建 wg0-server.conf, 内容:

   ```plain
    [Interface]
    ListenPort = 33333
    PrivateKey = <C的秘钥>

    [Peer]
    PublicKey = <B的公钥>
    AllowedIPs = 0.0.0.0/0
    Endpoint = <B的eth0网卡IP>:<B的wg1-client.conf写的ListenPort, 即23333>
    PersistentKeepalive = 15
   ```

   使用 wg0-server.conf 这个配置

   ```bash
    wg setconf wg0-server ./wg0-server.conf
   ```

7. 测试 B -> C 可以连通

8. 实现 A -> C

   设置 A:

   ```bash
    ip route add <C所在的网段即10.2.0.0>/24 via <wg0-server网卡的ipv4地址>
   ```

   设置 C:

   ```bash
    ip route add <A所在的网段即10.1.0.0>/24 via <wg1-client网卡的ipv4地址>
   ```

## 参考

- [网关和路由器的区别是什么？](https://www.zhihu.com/question/21787311)
- [Linux 下配置多网卡多网关](https://www.hi-linux.com/posts/64963.html)
- [IP 地址是主机的还是网卡的 ?](https://segmentfault.com/a/1190000020031911)
- [WireGuard Docs](https://github.com/pirate/wireguard-docs)
