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
# String 为什么是不可变的？String为啥要设计为不可变的？
# Java多线程
## 悲观锁和乐观锁
## synchronized 和 ReenTrantLock 区别以及 volatile 和 synchronized 的区别
## 可重入锁与非可重入锁的区别
## 多线程是解决什么问题的
## 线程池解决什么问题，为什么要用线程池
## 线程间的几种通信方式
## Java 提供了哪几种线程池？他们各自的使用场景是什么？
# Arraylist 与 LinkedList 异同
# HashMap的底层实现
# HashMap 的长度为什么是 2 的幂次方
# ConcurrentHashMap 和 Hashtable 的区别
# ConcurrentHashMap线程安全的具体实现方式/底层具体实现
# Object类有哪些方法
# hashCode 与 equals
## 为什么要有hashCode
## 为什么两个对象有相同的hashcode值，它们也不一定是相等的？
## == 与 equals
# 转发(Forward)和重定向(Redirect)的区别
# TCP 三次握手和四次挥手
# IP地址与MAC地址的区别
# HTTP请求、响应报文格式
# 为什么要使用索引？
## 索引这么多优点，为什么不对表中的每一个列创建一个索引呢？
## 索引是如何提高查询速度的？
## 说一下使用索引的注意事项？
## Mysql索引主要使用的两种数据结构？
## 什么是覆盖索引?
