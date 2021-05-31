---
title: "[译] The Implementation of Lua 5.0"
date: 2021-05-16T19:55:06+08:00
draft: true
tags:
  - 翻译练习
  - Lua
---

> 原文地址: [The implementation of Lua 5.0](http://www.lua.org/doc/jucs05.pdf)
>
> 原文作者: R. Ierusalimschy, L. H. de Figueiredo, W. Celes

## 1. Introduction (介绍)

Lua 诞生于一个学术实验室作为一种工具用于内部的软件开发, 适用于世界上多数行业, 如今广泛用于游戏行业.

我们如何解释 Lua 的广泛使用呢? 我们相信答案在于我们的设计和实现目标: 提供一门简单, 高效, 便捷, 轻量的嵌入式脚本语言. 自从 1993 年 Lua 诞生以来这是我们的主要目标. 这些特性, 加上事实上 Lua 从设计之初便被嵌入到大型应用中, 说明它很早就被业界采用了.

广泛的使用产生了对语言特性的需求. Lua 的许多特性都是以解决产业的需求和用户的反馈为目的. 例子就是 Lua 5.0 引入的协程 (coroutine) 和即将到来的 Lua 5.1 引入的增量式垃圾回收 (incremental garbage collection). 这两种特性对游戏来说都很重要.

在这篇论文中, 我们讨论了 Lua 5.0 相对于 Lua 4.0 实现上的创新:

- _基于寄存器 (Register-based) 的虚拟机_: 大多数虚拟机都是基于栈的虚拟机, 例如 Pascal 的 Pmachine, Java 的 JVM, 微软的 .Net environment. 然而目前寄存器式虚拟机在增长 (例如 Perl 6 的新的虚拟机 Parrot 将使用寄存器式虚拟机). 目前我们所知道的是 Lua 5.0 是第一个广泛使用的基于寄存器的虚拟机. 这将在第七部分阐述.

- _新的算法使用数组 (array) 来优化表 (table)_: Lua 不像其它语言一样提供数组类型 (array type). Lua 程序员使用常见的表加上整数索引来实现数组. Lua 5.0 使用一种新的算法来检测表是否被用来当做数组来使用, 并自动存储关联到数组中的数字索引的值, 而不是将它们添加到哈希表. 这个算法将在第四部分讨论.

- _闭包 (closure) 的实现_: Lua 5.0 的词法作用域 (lexical scoping) 支持第一等 (first-class) 函数. 这一机制造成了语言众所周知的困难, 就是使用基于数组的栈 (array-based stack) 来存储活动记录 (activation record). 对于函数闭包 (function closure) Lua 使用一种新颖的方法, 保留本地变量到基于数组的栈中, 同时如果它们被嵌套式的函数引用而超出了范围 (scope), 那也仅移动它们到堆 (heap) 中.

- _新增的协程 (coroutine)_: Lua 5.0 引入了协程, 尽管实现协程的是传统方法, 我们将在第六部分简要概述.

其他部分补充或提供了本讨论的背景. 在第二部分我们大致浏览了 Lua 的设计目标以及这些目标是如何指引其实现的. 在第三部分我们描述了 Lua 如何表现它的值 (value). 尽管这些没有新意但我们需要这些基础来继续剩下的部分. 最终在第八部分, 我们展现了基准测试以及画出结果.

## 2. An Overview of Lua’s Design and Implementation (Lua 设计与实现概述)

## 3. The Representation of Values (值的表现形式)

## 4. Tables (表)

## 5. Functions and Closures (函数和闭包)

## 6. Threads and Coroutines (线程和协程)

## 7. The Virtual Machine (虚拟机)

## 8. Conclusion (结论)
