---
title: "Java面试常见问题"
date: 2018-12-04T06:37:46+08:00
draft: true
tags: 
  - Java
categories:
  - 面试
---

# SpringMVC 工作原理
1. 客户端请求提交到DispatcherServlet
2. 由DispatcherServlet控制器查询一个或多个HandlerMapping，找到处理请求的Controller
3. DispatcherServlet将请求提交到Controller
4. Controller调用业务逻辑处理后，返回ModelAndView
5. DispatcherServlet查询一个或多个ViewResoler视图解析器，找到ModelAndView指定的视图
6. 视图负责将结果显示到客户端

# 对 IOC、AOP 的理解
# Spring 中用到了那些设计模式
# Spring Bean 的作用域和生命周期
# Spring 事务中的隔离级别
# Spring 事务中的事务传播行为
# String 为什么是不可变的？String 为啥要设计为不可变的？

# Java 多线程
一条线程指的是进程中一个单一顺序的控制流，一个进程中可以并发多个线程，每条线程并行执行不同的任务。
三种创建线程的方法：1. 通过实现 `Runnable` 接口；2. 通过继承 `Thread` 类本身；3. 通过 `Callable` 和 `Future` 创建线程。

# 悲观锁和乐观锁
- 悲观锁：在整个数据处理过程中，将数据处于锁定状态。 实现：依靠数据库提供的锁机制
- 乐观锁：乐观锁假设认为数据不会造成冲突，在数据进行提交更新时，才对数据的冲突与否进行检测。实现：记录数据版本

# volatile 和 synchronized 的区别
# 可重入锁与非可重入锁的区别
# 多线程是解决什么问题的
# 线程池解决什么问题，为什么要用线程池
# 线程间的几种通信方式
# Java 提供了哪几种线程池？他们各自的使用场景是什么？

# HashMap 的长度为什么是 2 的幂次方
# HashMap、ConcurrentHashMap、HashTable的区别
- `HashMap` 不是同步的，是线程不安全，不适合应用于多线程并发环境下
- `ConcurrentHashMap` 是线程安全的，在多线程和并发环境中，通常作为 `Map` 的主要实现
- `HashTable` 是一个遗弃的类，它把所有方法都加上 `synchronized` 关键字来实现线程安全

# ConcurrentHashMap 线程安全的具体实现方式/底层具体实现

# Object 类有哪些方法
# equals、hashCode、==
- `==` 运算符判断两个对象是不是同一个对象，即他们的地址是否相等
- `equals()` 用来判断其他的对象是否和该对象相等
- `hashCode()` 方法给对象返回一个 hashcode 值。这个方法被用于 hash tables，例如 `HashMap`

# 转发（Forward）和重定向（Redirect）的区别
# TCP 三次握手和四次挥手
# IP 地址与 MAC 地址的区别
# HTTP 请求、响应报文格式

# 为什么要使用索引？
# 索引这么多优点，为什么不对表中的每一个列创建一个索引呢？
# 索引是如何提高查询速度的？
# 说一下使用索引的注意事项？
# MySQL 索引主要使用的两种数据结构？
# 什么是覆盖索引?
