---
title: "Java核心技术36讲笔记(1-20)"
date: 2018-11-12T23:13:20+08:00
tags:
  - Java
categories:
  - 学习笔记
---

### 1.谈谈你对 Java 平台的理解
- JDK(Java Development Kit) 可看作 JRE(Java Runtime Environment) 的超集，JRE 包含了 JVM 和 Java 类库及一些常用模块，JDK 提供更过工具如编译器、诊断工具
- Java 源代码通过 javac 编译成字节码(bytecode)，通过 JVM 内嵌的解析器将字节码转换为机器码执行(即解释执行)，常见 JVM 如 Hotspot 提供 JIT(动态编译器) 将热点代码编译成机器码执行(即编译执行)
- Hotspot 内置两种 JIT，C1(client模式) 适用于对启动速度敏感的桌面应用，C2(server模式) 适用长时间运行的服务器端应用
- java 源代码经过 javac 编译成 .class 文件经 JVM 解析或编译运行
  - 解析: .class 文件经过 JVM 内嵌的解析器解析执行
  - 编译: 存在 JIT 即时编译器把经常运行的代码作为"热点代码"编译与本地平台相关的机器码，并进行各种层次的优化
  - AOT 编译器: Java 9提供的直接将所有代码编译成机器码执行

### 2.Exception、Error
- `Error`、`Exception` 都继承自`Throwable`类
- `Error` 系统错误，不需捕捉
- `Exception` 分为可检查（checked）异常和不检查（unchecked）异常
  - 可检查异常必须显式地进行捕获处理
  - 不检查异常（运行时异常）是可以通过编码避免的逻辑错误，如 `NullPointerException`、`ArrayIndexOutOfBoundsException`
- `ClassNotFoundException` 产生原因：例如使用`Class.forName`方法来动态地加载类时，可将类名作为参数传递给上述方法从而将指定类加载到 JVM 内存中，如果这个类在类路径中没有被找到，那么此时就会在运行时抛出此异常
- `NoClassDefFoundError` 产生的原因：如果 JVM 或者 ClassLoader 实例尝试加载（正常的方法调用或使用 `new` 来创建新对象的）类时找不到类的定义

### 3. final、finaly、finalize
- `final` 修饰的类不可被继承，修饰的变量不可修改，修饰的方法不可被重写（`override`）
- `finaly` 是保证重点代码一定被执行的机制，如用 `try-finaly` 释放锁
- `finalize` 对象在被垃圾收集前调用，容易导致拖慢垃圾收集造成 OOM，在 JDK 9 中标记为 `deprecated`

### 4. 强引用、软引用、弱引用、幻象引用
- 所有引用类型，都是抽象类 `java.lang.ref.Reference` 的子类
- 强引用：通过 `new` 关键字创建的对象所关联的引用，只要超过了引用的作用域或者显式地将相应（强）引用赋值为 `null`，就可被垃圾收集，具体回收时机还要看垃圾收集策略
- 软引用：通过 `SoftReference` 类实现，JVM 抛出 `OutOfMemoryError` 之前，清理软引用指向的对象，
  - 可以和引用队列（`ReferenceQueue`）联合使用；可以实现内存敏感的缓存。如果还有空闲内存，就可以暂时保留缓存，当内存不足时清理掉，这样就保证了使用缓存的同时，不会耗尽内存
  - 图片缓存框架中，“内存缓存” 中的图片是以这种引用来保存，使得 JVM 在发生 OOM 之前，可以回收这部分缓存
- 弱引用：通过 `WeakReference` 类实现，弱引用的生命周期比软引用短。在垃圾回收器线程扫描它所管辖的内存区域的过程中，一旦发现了具有弱引用的对象，不管当前内存空间足够与否，都会回收它的内存
  - 可以和一个引用队列（`ReferenceQueue`）联合使用，同样可用于内存敏感的缓存
- 虚引用：虚引用也叫幻象引用，通过 `PhantomReference` 类来实现
  - 无法通过虚引用访问对象的任何属性或函数
  - 当垃圾回收器准备回收一个对象时，如果发现它还有虚引用，就会在回收对象的内存之前，把这个虚引用加入到与之关联的引用队列中
    ```
    ReferenceQueue queue = new ReferenceQueue();
    PhantomReference pr = new PhantomReference(object, queue); 
    ```
  - 程序可以通过判断引用队列中是否已经加入了虚引用，来了解被引用的对象是否将要被垃圾回收
  - 在静态内部类中，经常会使用虚引用。例如，一个类发送网络请求，承担 callback 的静态内部类，则常以虚引用的方式来保存外部类（宿主类）的引用，当外部类需要被 JVM 回收时，不会因为网络请求没有及时回来，导致外部类不能被回收，引起内存泄漏
- 幻象引用：`get()` 永远返回 `null`

### 5. String、StringBuffer、StringBuilder

### 6. 动态代理是基于什么原理

### 7. int、Integer

### 8. Vector、ArrayList、LinkedList

### 9. Hashtable、HashMap、TreeMap

### 10. 如何保证集合是线性安全的；ConcurrentHashMap 如何实现高效的线程安全

### 11. Java IO 方式；NIO 如何实现多路复用

### 12. Java 有几种文件拷贝方式；哪种最高效

### 13. 接口和抽象类的区别

### 14. 设计模式

### 15. synchronized、ReentranLock

### 16. synchronized 底层实现；锁的升级、降级

### 17. 一个线程两次调用 start() 方法会出现什么情况

### 18. 什么情况下 Java 程序会产生死锁；如何定位、修复
```java
void transfer(Account from, Account to, int amount) {
  synchronized (from) {
    synchronized (to) {
      from.setAmount(from.getAmount() - amount);  // from 余额 - 转账金额
      to.setAmount(to.getAmount() + amount);      // to 余额 + 转账金额
    }
  }
}
```
- 死锁：在多个线程之间互相持有对方所需要的锁而永久处于阻塞状态
- 死锁的条件必须同时满足：
  - 互斥等待（同一个任务只能有一个线程执行，别的线程必须等待，即必须要有锁的存在）解决方法：把执行逻辑改成不含有锁的存在，很难
  - hold and wait（拿着一个锁等待另一个锁）解决方法：一次性获取所有锁 1) A B 锁外面再加上全局锁 2) 拿着 A 锁带上超时时间去拿 B 锁，拿不到就把 A 锁放掉，过一段时间再重复
  - 循环等待（线程 1 拿着 A 的锁等待 B，线程 2 拿着 B 的锁等待 A）解决方法：按顺序获取锁
  - 无法剥夺的等待（即必须要拿到锁而一直等待）解决方法：加入超时
- 死锁原因：
  - 互斥条件，类似 Java 中 Monitor 都是独占的，要么是我用，要么是你用。
  - 互斥条件是长期持有的，在使用结束之前，自己不会释放，也不能被其他线程抢占。
  - 循环依赖关系，两个或者多个个体之间出现了锁的链条环。

### 19. Java 并发包提供了哪些并发工具类

### 20. 并发包中 ConcurrentLinkedQueue 和 LinkedBlockingQueue 区别