---
title: "Java核心技术36讲 学习笔记"
date: 2018-11-12T23:13:20+08:00
tags:
  - 学习笔记
---

### 1.谈谈你对 Java 平台的理解
- JDK(Java Development Kit) 可看作 JRE(Java Runtime Environment) 的超集，JRE 包含了 JVM 和 Java 类库及一些常用模块，JDK 提供更过工具如编译器、诊断工具
- Java 源代码通过 javac 编译成字节码(bytecode)，通过 JVM 内嵌的解析器将字节码转换为机器码执行(即解释执行)，常见 JVM 如 Hotspot 提供 JIT(动态编译器) 将热点代码编译成机器码执行(即编译执行)
- Hotspot 内置两种 JIT，C1(client模式) 适用于对启动速度敏感的桌面应用，C2(server模式) 使用长时间运行的服务器端应用
- java 源代码经过 javac 编译成.class文件经JVM解析或编译运行。
    - 解析: .class 文件经过 JVM 内嵌的解析器解析执行。
    - 编译: 存在 JIT 即时编译器把经常运行的代码作为"热点代码"编译与本地平台相关的机器码，并进行各种层次的优化。
    - AOT 编译器: Java 9提供的直接将所有代码编译成机器码执行。

### 2.Exception 和 Error 的区别
- Error、Exception 都继承自 Throwable 类
- Error 系统错误，不需捕捉
- Exception 分为可检查（checked）异常和不检查（unchecked）异常
    - 可检查异常必须显式地进行捕获处理
    - 不检查异常(运行时异常)是可以通过编码避免的逻辑错误，如 NullPointerException、ArrayIndexOutOfBoundsException
- ClassNotFoundException 产生原因：例如使用Class.forName方法来动态地加载类时，可将类名作为参数传递给上述方法从而将指定类加载到JVM内存中，如果这个类在类路径中没有被找到，那么此时就会在运行时抛出此异常
- NoClassDefFoundError 产生的原因：如果 JVM 或者 ClassLoader 实例尝试加载（正常的方法调用或使用 new 来创建新对象的）类时找不到类的定义。

### 3. 谈谈 final、finaly、finalize 有什么不同

### 4. 强引用、软引用、弱引用、幻象引用有什么区别

### 5. String、StringBuffer、StringBuilder 有什么区别

### 6. 动态代理是基于什么原理

### 7. int 和 Integer 有什么区别

### 8. 对比 Vector、ArrayList、LinkedList 有何区别

### 9. 对比 Hashtable、HashMap、TreeMap 有什么不同

### 10. 如何保证集合是线性安全的；ConcurrentHashMap 如何实现高效的线程安全