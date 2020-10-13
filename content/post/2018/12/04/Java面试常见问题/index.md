---
title: "Java面试常见问题"
date: 2018-12-04T06:37:46+08:00
draft: false
tags:
  - Java
---

## 自我介绍、项目经历、技术栈

## SpringMVC 工作原理

1. 客户端请求提交到 DispatcherServlet
2. 由 DispatcherServlet 控制器查询一个或多个 HandlerMapping，找到处理请求的 Controller
3. DispatcherServlet 将请求提交到 Controller
4. Controller 调用业务逻辑处理后，返回 ModelAndView
5. DispatcherServlet 查询一个或多个 ViewResoler 视图解析器，找到 ModelAndView 指定的视图
6. 视图负责将结果显示到客户端

## 对 IOC、AOP 的理解

- IOC: 解决了创建一个对象时, 如何获取它所依赖的另一个对象. 即把创建和获取对象的责任交给 spring 容器
- AOP: 通过代理(或修改字节码)方式, 把非业务逻辑横切插入到业务逻辑里

## Spring 中用到了那些设计模式

## Spring Bean 的作用域和生命周期

## Spring 事务中的隔离级别

## Spring 事务中的事务传播行为

## String 为什么是不可变的？String 为啥要设计为不可变的？

## Java 多线程

一条线程指的是进程中一个单一顺序的控制流，一个进程中可以并发多个线程，每条线程并行执行不同的任务。
三种创建线程的方法：1. 通过实现 `Runnable` 接口；2. 通过继承 `Thread` 类本身；3. 通过 `Callable` 和 `Future` 创建线程。

## 悲观锁和乐观锁

- 悲观锁：在整个数据处理过程中，将数据处于锁定状态。 实现：依靠数据库提供的锁机制
- 乐观锁：乐观锁假设认为数据不会造成冲突，在数据进行提交更新时，才对数据的冲突与否进行检测。实现：记录数据版本

## volatile 和 synchronized 的区别

- volatile 只能修饰变量, synchronized 可以修饰变量和方法
- 任何线程修改被 volatile 修饰的变量时会立即刷新到主内存并将其余缓存中该变量值清除, 导致其它线程只能去主内存读取最新值
- volatile 仅能实现变量的修改可见性, 而 synchronized 可以保证变量的修改可见性和原子性(锁定当前变量, 只有当前线程可以访问该变量, 其他线程被阻塞).

## 可重入锁与非可重入锁的区别

TODO ReentrantLock

## 多线程是解决什么问题的

防止阻塞, 发挥多核 CPU 优势

## 线程池解决什么问题，为什么要用线程池

避免频繁创建/销毁线程对象, 达到线程对象的重用
复用已有资源, 控制资源总量

## 线程间的几种通信方式

[参考文章](https://github.com/crossoverJie/JCSprout/blob/master/MD/concurrent/thread-communication.md)

- 等待通知机制, 两个线程通过对同一对象调用 wait() 和 notify() 方法来进行通讯
- volatile 共享内存
- CountDownLatch 并发工具
- CyclicBarrier 并发工具
- 线程响应中断
- 管道通信

## Java 提供了哪几种线程池？他们各自的使用场景是什么？

- newFixedTreadPool
- newCachedThreadPool
- newSingleThreadExecutor
- newScheduledTreadPool

## ThreadLocal

- 提供了线程的局部变量, 每个线程可以通过 `set()` `get()` 方法对局部变量操作, 但不会和其它线程局部变量冲突, 实现了线程的数据隔离
- 每个 Thread 维护一个 ThreadLocalMap 的引用, 键为 ThreadLocal 对象, 值为 `set()` `get()` 的对象
- ThreadLocal 本身并不存储值, 只是作为键让线程从 ThreadLocalMap 获取值

## HashMap 的长度为什么是 2 的幂次方

## HashMap、ConcurrentHashMap、HashTable 的区别

- `HashMap` 不是同步的，是线程不安全，不适合应用于多线程并发环境下
- `ConcurrentHashMap` 是线程安全的，在多线程和并发环境中，通常作为 `Map` 的主要实现
- `HashTable` 是一个遗弃的类，它把所有方法都加上 `synchronized` 关键字来实现线程安全

## ConcurrentHashMap 线程安全的具体实现方式/底层具体实现

## Object 类有哪些方法

## equals、hashCode、==

- `==` 运算符判断两个对象是不是同一个对象，即他们的地址是否相等
- `equals()` 用来判断其他的对象是否和该对象相等
- `hashCode()` 方法给对象返回一个 hashcode 值。这个方法被用于 hash tables，例如 `HashMap`

## 转发（Forward）和重定向（Redirect）的区别

转发是服务器行为.

重定向是客户端行为.
如果 web 服务器返回给客户端的 HTTP 状态码是 301(永久跳转) 或者 302(临时跳转), 则客户端浏览器就能通过 Response Headers 的 Location 字段拿到重定向的 URL 进行跳转.

## TCP 三次握手和四次挥手具体过程

TCP 是基于字节流的通信协议

三次握手:
![三次握手](./三次握手.png)

四次挥手:
![四次挥手](./四次挥手.png)

## IP 地址与 MAC 地址的区别

IP 地址是指 (Internet Protocol address), 术语叫互联网协议地址, 而 MAC 地址是指 (Media Access Control Address), 直译为媒体访问控制地址, 或物理地址 (Physical Address), 每个可以连接到以太网 (Ethernet) 的设备必须有一个 MAC 地址.

参考: [知乎 - IP 地址和 MAC 地址的区别和联系是什么](https://www.zhihu.com/question/49335649)

## HTTP 请求, 响应报文格式

## 为什么要使用索引

## 索引这么多优点, 为什么不对表中的每一个列创建一个索引

## 索引是如何提高查询速度的

## 使用索引的注意事项

## MySQL 索引主要使用的两种数据结构

## 什么是覆盖索引

## 项目中的监控; 常见的监控指标

## 微服务划分的粒度

## 微服务如何保证高可用

## 微服务涉及到的技术以及需要注意的问题

## 注册中心

## 常用的负载均衡，该怎么用

## 网关能为后端服务带来哪些好处

## consul 的机制以及和其他注册中心的对比

## Spring Boot 除了自动配置，相比 Spring 有什么区别

## 对 Spring Cloud 的了解

## Spring Bean 的生命周期

## HashMap 和 HashTable 的区别

## Object 的 hashcode 方法重写了, 是否需要重写 equals 方法

## HashMap 线程不安全的出现场景

## 线上 CPU 很高的解决方法, 如何找到问题

## JDK 中有哪几个线程池

## SQL 优化的常见方法

## SQL 索引的顺序，字段的顺序

## MySQL 实现分页查询

## 有什么工具可以查看 SQL 是否用了索引

## TCP 和 UDP 的区别; TCP 传输过程中怎么做到可靠的

## 说说排序算法

## 如何查找一个数组的中位数

## 反射的机制

## Object 类中的方法

## hashmap put 方法存放时如何判断是否重复

## 如果存取相同的数据, ArrayList 和 LinkedList 谁占用空间大

## Set 存的顺序是有序的吗

## Set 和 List 区别

## ArrayList, LinkedList 区别

## 常见的 Set 实现

## TreeSet 对存入的数据有什么要求, 源码实现

## HashSet 的底层实现

## HashSet 为什么不是线程安全的

## Java 中有哪些线程安全的 Map

## ConcurrentHashMap 如何做到线程安全的

## 如何保证线程安全

## synchronized 和 lock 的区别

## volatile 的原子性问题; 为什么 i++ 不支持原子性 (从计算机原理角度说明)

## happens before 原理

## CAS 操作

## 公平锁, 非公平锁

## Java 读写锁

## 读写锁设计主要解决什么问题

## MySQL 分页查询语句

## MySQL 事务特性和隔离级别

## SQL having 使用场景

## 前端浏览器地址的一个 http 请求到后端整个流程是怎样的

## git rebase、git merge 作用

## JDK、ClassLoader、NIO、Spring 代码熟悉程度

## Java 中的值传递和引用传递

## Integer 常量池

## Java 内存模型

## select, poll, epoll 区别

## TCP 拆包粘包

## 队列、栈、链表、树、堆、图

## 栈和队列的相同和不同之处, 栈通常采用的两种存储结构

## 两个栈实现队列, 和两个队列实现栈

## 排序都有哪几种方法? 手写快速排序, 归并排序

## 各种排序算法的时间复杂度和稳定性, 重点快排

## 单链表的遍历和逆序

## 深度优先搜索和广度优先搜索

## 最小生成树

## 常见 Hash 算法, 哈希的原理和代价

## 全排列, 贪心算法, KMP 算法, hash 算法

## 一致性 Hash 算法

## get 和 post 的区别

## HTTP 请求和响应的全过程

## forward 和 redirect 的区别

## osi 七层模型

## tcp/ip 四层模型及原理

## 容量控制, 拥塞控制

## 子网划分

## IPV4 和 IPV6

## HTTPS 和 HTTP/2

## 数据库范式

## 数据库事务和隔离级别

## 为什么需要锁, 锁定分类, 锁粒度

## 乐观锁, 悲观锁的概念及实现方式

## 分页如何实现

## MySQL 引擎

## MySQL 语句优化

## 从一张大表读取数据, 如何解决性能问题

## 内连接, 左连接, 右连接作用及区别

## Statement 和 PreparedStatement 之间的区别

## 索引以及索引的实现 (B+ 树和 B 树, R 树区别)

## 什么是数据库连接池

## Java 中实现多态的机制是什么, 动态多态和静态多态的区别

## 接口和抽象类的区别, 如何选择

## Java 能不能多继承, 可不可以多实现

## Static Nested Class 和 Inner Class 的不同

## 重载和重写的区别

## 是否可以继承 String 类

## 构造器是否可被 override

## public, protected, private 的区别

## 列举几个 Java 中 Collection 类库中的常用类

## List, Set, Map 是否都继承自 Collection 接口? 存储特点分别是什么?

## ArrayList, LinkedList, Vector 之间的区别与联系

## HashMap, Hashtable, TreeMap, ConcurrentHashMap 的区别

## Collection 和 Collections 的区别

## 其他的集合类: TreeSet, LinkedHashMap 等

## Error 和 Exception 的区别

## 异常的类型, 什么是运行时异常

## 列举 3 个以上的 RuntimeException

## Java 中的异常处理机制的简单原理和应用

## String, StringBuffer, StringBuilder 的区别

## == 和 equals 的区别

## hashCode 的作用, 和 equals 方法的关系

## Input/OutputStream 和 Reader/Writer 有什么区别?

## 如何在字符流和字节流之间转换?

## switch 可以使用那些数据类型

## Java 的四种引用

## 序列化与反序列化

## 正则表达式

## int 和 Integer 的区别, 什么是自动装箱和自动拆箱

## 进程和线程的区别

## 并行和并发的区别和联系

## 同步与异步

## 多线程的实现方式, 有什么区别

## 什么叫守护线程

## 如何停止一个线程?

## 什么是线程安全?

## synchronized 和 lock 的区别

## 当一个线程进入一个对象的一个 synchronized 方法后, 其它线程是否可进入此对象的其它方法?

## 启动一个线程是用 run() 还是 start()?

## wait 和 sleep 的区别

## notify 和 notifyAll 的区别

## 线程池的作用

## Java 中线程池相关的类

## GC 的概念, 如果 A 和 B 对象循环引用, 是否可以被 GC?

## JVM GC 如何判断对象是否需要回收, 有哪几种方式?

## Java 中能不能主动触发 GC

## JVM 的内存结构, 堆和栈的区别

## JVM 堆的分代

## Java 中的内存溢出是什么, 和内存泄露有什么关系

## Java 的类加载机制, 什么是双亲委派

## ClassLoader 的类加载方式

## NIO, AIO 和 BIO 之间的区别

## IO 和 NIO 常用用法

## hashcode 有哪些算法

## 反射的基本概念，反射是否可以调用私有方法

## Java 中范型的概念

## JVM 启动参数，-Xms 和 -Xmx

## 代理机制的实现

## `String s = new String("s")` 创建了几个对象

## JSP 的动态 include 和静态 include

## web.xml 中常用配置及作用

## Servlet 的线程安全问题

## 什么是 MVC

## session 和 cookie 的区别

## HTTP 请求中 session 实现原理?

## 如果客户端禁止 Cookie 能实现 Session 吗?

## get 和 post 区别

## 常见的 web 请求返回的状态码

## Spring 的事务管理, Spring Bean 注入的几种方式

## Spring Bean 的初始化过程

## Spring 四种依赖注入方式

## 什么是 web 服务器, 什么是应用服务器, 常用的 web 服务器有哪些

## Tomcat 和 weblogic 的区别

## 什么是 SQL 注入, XSS 攻击, CSRF 攻击, 如何避免

## Java 的动态代理的概念, 实现

## XML 的解析方式, 以及优缺点

## Ajax 如何解决跨域问题

## 列举常见的设计模式

## 单例 (Singleton) 的几种实现方式, 实现一个线程安全的单例

## 工厂模式和抽象工厂模式之间的区别

## 请简单介绍一下你的这个项目, 以及在项目中充当什么角色, 这个项目的技术选型有做过么

## 选择某项技术做过哪些调研和对比

## 这个项目中遇到的最大的问题是什么? 你是如何解决的?

## 项目中是否考虑过性能, 安全性等问题
