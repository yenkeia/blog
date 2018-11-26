---
title: "<<深入拆解Java虚拟机>>学习笔记(1-18)"
date: 2018-11-27T05:19:56+08:00
draft: false
tags:
  - Java
categories:
  - 学习笔记
---
极客时间[深入拆解Java虚拟机](https://time.geekbang.org/column/108)

# 1. Java代码是怎么运行的？
- JVM 将运行时内存分为方法区、堆、PC 寄存器、Java 方法栈、本地方法栈五部分
- 执行 Java 代码首先需要将它编译而成的 class 文件加载到 Java 虚拟机中。加载后的 Java 类会被存放于方法区
- 每当调用进入一个 Java 方法，Java 虚拟机会在当前线程的 Java 方法栈中生成一个栈帧，用以存放局部变量以及字节码的操作数

# 2. Java的基本类型
- JVM 规范中，`true` 被映射成整数 1，`false` 为 0
- （解释器使用的解释）栈帧由局部变量区，字节码的操作数栈组成
- 除 boolean 类型之外，Java 还有另外 7 个基本类型。它们拥有不同的值域，但默认值在内存中均为 0

# 3. Java虚拟机是如何加载Java类的？

# 4. JVM是如何执行方法调用的？（上）

# 5. JVM是如何执行方法调用的？（下）

# 6. JVM是如何处理异常的？

# 7. JVM是如何实现反射的？

# 8. JVM是怎么实现invokedynamic的？（上）

# 9. JVM是怎么实现invokedynamic的？（下）

# 10. Java对象的内存布局

# 11. 垃圾回收（上）

# 12. 垃圾回收（下）

# 13. Java内存模型

# 14. Java虚拟机是怎么实现synchronized的？

# 15. Java语法糖与Java编译器

# 16. 即时编译（上）

# 17. 即时编译（下）

# 18. 即时编译器的中间表达形式
