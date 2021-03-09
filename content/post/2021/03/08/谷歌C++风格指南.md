---
title: "[译]谷歌C++风格指南"
date: 2021-03-08T18:02:00+08:00
draft: true
tags:
  - 翻译练习
---

> 原文地址: [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)

## Background (背景)

C++ 是许多谷歌开源项目的主要开发语言. 如许多 C++ 程序员所知, 这门语言有许多强大的特性 (feature), 但同时这些特性也带来了复杂度 (complexity), 让代码更加容易产生 bug, 更难以阅读和维护.

这个指南的目的是通过描述文档的细节来管理这些复杂度. 这些规则的存在是为了让代码基本可维护的同时允许程序员使用 C++ 语言特性更有生产力.

_风格 (Style)_, 也可以理解为可读性, 我们称之为管理我们 C++ 代码的约定. 风格这个术语有一点用词不当, 因为这些约定远不止于包括规定源代码文件的格式.

大多数谷歌开发的开源项目遵守这个指南的要求.

同时注意这个指南不是 C++ 教程: 我们假设读者已经熟悉了这门语言.

### Goals of the Style Guide (风格指南的目的)

## C++ Version (C++ 版本)

## Header Files (头文件)

### Self-contained Headers (自包含的头文件)

### The #define Guard (#define 保护)

### Include What You Use (只引入所需头文件)

### Forward Declarations (前置声明)

### Inline Functions (内联函数)

### Names and Order of Includes (引入文件的命名和顺序)
