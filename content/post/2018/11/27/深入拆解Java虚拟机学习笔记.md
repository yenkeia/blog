---
title: "<<深入拆解Java虚拟机>>学习笔记"
date: 2018-11-27T05:19:56+08:00
draft: false
tags:
  - Java
---

极客时间[深入拆解 Java 虚拟机](https://time.geekbang.org/column/108)

## 1. Java 代码是怎么运行的？

- JVM 将运行时内存分为方法区、堆、PC 寄存器、Java 方法栈、本地方法栈五部分
- 执行 Java 代码首先需要将它编译而成的 class 文件加载到 Java 虚拟机中。加载后的 Java 类会被存放于方法区
- 每当调用进入一个 Java 方法，Java 虚拟机会在当前线程的 Java 方法栈中生成一个栈帧，用以存放局部变量以及字节码的操作数

## 2. Java 的基本类型

- JVM 规范中，`true` 被映射成整数 1，`false` 为 0
- （解释器使用的解释）栈帧由局部变量区，字节码的操作数栈组成
- 除 boolean 类型之外，Java 还有另外 7 个基本类型。它们拥有不同的值域，但默认值在内存中均为 0

## 3. Java 虚拟机是如何加载 Java 类的？

- 从 `class` 文件到内存中的类，按先后顺序需要经过加载、链接以及初始化三大步骤
- Java 类型分为基本类型（primitive types）和引用类型（reference types）
- 引用类型可细分为类、接口、数组类、范型参数
  - 数组类由 Java 虚拟机直接生成
  - 泛型参数会在编译过程中被擦除
  - 类、接口有对应的字节流
- 字节流可由程序内部生成，网络获取，最常见的形式为 Java 编译器生成的 `class` 文件，这些不同形式的字节流，都会被加载到 Java 虚拟机中，成为类或接口
- 加载：指查找字节流，并且据此创建类的过程
  - 加载需要借助类加载器，在 Java 虚拟机中，类加载器使用了双亲委派模型，即接收到加载请求时，会先将请求转发给父类加载器
- 链接：是指将创建成的类合并至 Java 虚拟机中使之能够执行的过程
  - 链接还分验证、准备和解析三个阶段（解析阶段为非必须的）
- 初始化：为标记为常量值的字段赋值，以及执行 `< clinit >` 方法的过程

## 4. JVM 是如何执行方法调用的？（上）

- 不提倡可变长参数方法的重载因为 Java 编译器可能无法决定应该调用哪个目标方法（二义性）
- Java 虚拟机识别方法的关键在于类名、方法名以及方法描述符（method descriptor）
  - 描述符由方法的参数类型以及返回类型所构成
- TODO

## 5. JVM 是如何执行方法调用的？（下）

## 6. JVM 是如何处理异常的？

- 异常都是 `Throwable` 类或者其子类的实例
- `Error`: 程序执行状态已经无法恢复，需要中止线程甚至是中止虚拟机
- `Exception`: 涵盖程序可能需要捕获并且处理的异常
  - `RuntimeException`: 程序虽然无法继续执行，但是还能抢救一下，如数组索引越界
- `RuntimeException` 和 `Error` 属于**非检查异常**
- 所有的**检查异常**都需要程序显式地捕获，或者在方法声明中用 `throws` 关键字标注
- 在编译生成的字节码中，每个方法都附带一个异常表
- 异常表中的每一个条目代表一个异常处理器

```java
public static void main(String[] args) {
  try {
    mayThrowException();
  } catch (Exception e) {
    e.printStackTrace();
  }
}
// 对应的 Java 字节码
public static void main(java.lang.String[]);
  Code:
    0: invokestatic mayThrowException:()V
    3: goto 11
    6: astore_1
    7: aload_1
    8: invokevirtual java.lang.Exception.printStackTrace
   11: return
  Exception table:
    from  to target type
      0   3   6  Class java/lang/Exception  // 异常表条目
```

`from`、`to` 表识该异常处理器所监控的范围，例如 `try` 代码块覆盖范围，`target` 指针则指向异常处理器的起始位置，如 `catch` 代码块的起始位置

## 7. JVM 是如何实现反射的？

## 8. JVM 是怎么实现 invokedynamic 的？（上）

## 9. JVM 是怎么实现 invokedynamic 的？（下）

## 10. Java 对象的内存布局

## 11. 垃圾回收（上）

## 12. 垃圾回收（下）

## 13. Java 内存模型

## 14. Java 虚拟机是怎么实现 synchronized 的？

## 15. Java 语法糖与 Java 编译器

## 16. 即时编译（上）

## 17. 即时编译（下）

## 18. 即时编译器的中间表达形式

## 19. Java 字节码（基础篇）

## 20. 方法内联（上）

## 21. 方法内联（下）

## 22. HotSpot 虚拟机的 intrinsic

## 23. 逃逸分析

## 24. 字段访问相关优化

## 25. 循环优化

## 26. 向量化

## 27. 注解处理器

## 28. 基准测试框架 JMH（上）

## 29. 基准测试框架 JMH（下）

## 30. Java 虚拟机的监控及诊断工具（命令行篇）

## 31. Java 虚拟机的监控及诊断工具（GUI 篇）

## 32. JNI 的运行机制

## 33. Java Agent 与字节码注入

## 34. Graal：用 Java 编译 Java

## 35. Truffle：语言实现框架

## 36. SubstrateVM：AOT 编译框架
