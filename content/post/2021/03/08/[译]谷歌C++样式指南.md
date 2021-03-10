---
title: "[译]谷歌C++样式指南"
date: 2021-03-08T18:02:00+08:00
draft: true
tags:
  - 翻译练习
  - C++
---

> 原文地址: [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)

## Background (背景)

C++ 是许多谷歌开源项目的主要开发语言. 如许多 C++ 程序员所知, 这门语言有许多强大的特性 (feature), 但同时这些特性也带来了复杂度 (complexity), 让代码更加容易产生 bug, 更难以阅读和维护.

这个指南的目的是通过描述文档的细节来管理这些复杂度. 这些规则的存在是为了让代码基本可维护的同时允许程序员使用 C++ 语言特性更有生产力.

_样式 (Style)_, 也可以理解为可读性, 我们称之为管理我们 C++ 代码的约定. 样式这个术语有一点用词不当, 因为这些约定远不止于包括规定源代码文件的格式.

大多数谷歌开发的开源项目遵守这个指南的要求.

同时注意这个指南不是 C++ 教程: 我们假设读者已经熟悉了这门语言.

### Goals of the Style Guide (样式指南的目的)

(TN: 大部分都是废话, 只翻译有价值的地方.)

为什么我们做了这份文件?

我们认为这份指南能为一些核心目的服务. 这些*理由*是所有单独的规则的基础. 在列出这些想法之前, 我们希望能让外部社区更能理解为什么我们做了这些决定. 如果你能理解每一条规则为什么目的服务, 那这将让每个人更加清楚为何某条规则被我们放弃, 或者某些二选一的情况下修改这个指南的某条规则是有必要的.

我们目前看到的样式指南目标如下:

- 样式规则应该明确职责 (Style rules should pull their weight)
  样式规则的好处必须大到足以让我们所有的工程师记住它.

- 为阅读代码的人优化而不是写代码的人 (Optimize for the reader, not the writer)
  我们的代码库(和大部分提交到代码库的独立的组件)预计还会持续一段时间. 因此我们读代码的时间比写代码的时间要长. 我们明确地选择为大部分软件工程师阅读和维护以及调试代码的体验而优化代码库, 而不是在写代码时候简化. "为读者留下线索" 这一原则常见的点: 当一些意外情况可能会发生在某一小段代码 (比如转换指针的所有权), 留下文字提醒读者会非常有价值 (`std::unique_ptr` 示范了调用方明确的所有权转移).

- 和已存在的代码保持一致 (Be consistent with existing code)
  在我们的代码库一致地使用一种样式可以让我们专注于(处理更重要)的问题.

- 和外部的 C++ 社区尽量保持一致 (Be consistent with the broader C++ community when appropriate)

- 避免意外的设计和危险的设计 (Avoid surprising or dangerous constructs)

- 避免让我们大部分的 C++ 程序员觉得难以阅读或者难以维护 (Avoid constructs that our average C++ programmer would find tricky or hard to maintain)

- 注意我们的规模 (Be mindful of our scale)

- 在有必要时容许优化 (Concede to optimization when necessary)

这份文档的意图是在合理的约束范围内提供最大的指导.

## C++ Version (C++ 版本)

目前应该用 C++ 17, 不应该用 C++2x 的特性.

不要用非标准的扩展 ([non-standard extensions](https://google.github.io/styleguide/cppguide.html#Nonstandard_Extensions)).

在你的项目中使用 C++ 14 和 C++ 17 的特性前考虑到其他环境的可移植性.

## Header Files (头文件)

通常每个 `.cc` 文件应当有一个相关联的 `.h` 文件. 这里有通常有些例外, 例如单元测试和 `.cc` 文件仅包含一个 `main()` 函数.

正确地使用头文件可以在可读性, 大小以及性能上有巨大的不同.

下面的规则会指引你避开许多使用头文件的陷阱.

### Self-contained Headers (自包含的头文件)

头文件应该可以自包含 (自行编译), 并以 `.h` 结尾. 需要包含的非头文件应该以 `.inc` 结尾, 并要谨慎使用.

所有的头文件应该是可以自包含的. 用户和重构工具不应该依赖特别的条件来引入头文件. 特别需要注意的是一个头文件应该有头文件保护 ([header guards](https://google.github.io/styleguide/cppguide.html#The__define_Guard)) 同时进入它所需的其它头文件.

TODO

### The #define Guard (#define 保护)

### Include What You Use (只引入所需头文件)

### Forward Declarations (前置声明)

### Inline Functions (内联函数)

### Names and Order of Includes (引入文件的命名和顺序)
