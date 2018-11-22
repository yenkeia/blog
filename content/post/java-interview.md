---
title: "Java核心技术36讲笔记(1-20)"
date: 2018-11-12T23:13:20+08:00
draft: false
tags:
  - Java
categories:
  - 学习笔记
---

# 1.谈谈你对 Java 平台的理解
- JDK(Java Development Kit) 可看作 JRE(Java Runtime Environment) 的超集，JRE 包含了 JVM 和 Java 类库及一些常用模块，JDK 提供更过工具如编译器、诊断工具
- Java 源代码通过 javac 编译成字节码(bytecode)，通过 JVM 内嵌的解析器将字节码转换为机器码执行(即解释执行)，常见 JVM 如 Hotspot 提供 JIT(动态编译器) 将热点代码编译成机器码执行(即编译执行)
- Hotspot 内置两种 JIT，C1(client模式) 适用于对启动速度敏感的桌面应用，C2(server模式) 适用长时间运行的服务器端应用
- java 源代码经过 javac 编译成 .class 文件经 JVM 解析或编译运行
  - 解析: .class 文件经过 JVM 内嵌的解析器解析执行
  - 编译: 存在 JIT 即时编译器把经常运行的代码作为"热点代码"编译与本地平台相关的机器码，并进行各种层次的优化
  - AOT 编译器: Java 9提供的直接将所有代码编译成机器码执行

# 2.Exception、Error
- `Error`、`Exception` 都继承自`Throwable`类
- `Error` 系统错误，不需捕捉
- `Exception` 分为可检查（checked）异常和不检查（unchecked）异常
  - 可检查异常必须显式地进行捕获处理
  - 不检查异常（运行时异常）是可以通过编码避免的逻辑错误，如 `NullPointerException`、`ArrayIndexOutOfBoundsException`
- `ClassNotFoundException` 产生原因：例如使用`Class.forName`方法来动态地加载类时，可将类名作为参数传递给上述方法从而将指定类加载到 JVM 内存中，如果这个类在类路径中没有被找到，那么此时就会在运行时抛出此异常
- `NoClassDefFoundError` 产生的原因：如果 JVM 或者 ClassLoader 实例尝试加载（正常的方法调用或使用 `new` 来创建新对象的）类时找不到类的定义

# 3. final、finaly、finalize
- `final` 修饰的类不可被继承，修饰的变量不可修改，修饰的方法不可被重写（`override`）
- `finaly` 是保证重点代码一定被执行的机制，如用 `try-finaly` 释放锁
- `finalize` 对象在被垃圾收集前调用，容易导致拖慢垃圾收集造成 OOM，在 JDK 9 中标记为 `deprecated`

# 4. 强引用、软引用、弱引用、幻象引用
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

# 5. String、StringBuffer、StringBuilder
- 通过 `new` 方法创建的 `String` 对象是不检查字符串池的，而是直接在堆区或栈区创建一个新的对象，也不会把对象放入池中
```java
  String str1 = "123";              //通过直接量赋值方式，放入字符串常量池
  String str2 = new String("123");  //通过 new 方式赋值方式，不放入字符串常量池
```
- `String` 被声明成 `final class`，所有属性也是 `final` 的，它的不可变性，类似拼接、裁剪字符串等动作，都会产生新的 `String` 对象
- `StringBuffer` 和 `StringBuilder` 都实现了 `AbstractStringBuilder` 抽象类，拥有几乎一致对外提供的调用接口；其底层在内存中的存储方式与 `String` 相同，都是以一个有序的数组（`char` 类型的数组，JDK 9 以后是 `byte` 数组）进行存储
- 两者对象在构造过程中，首先按照默认大小申请一个字符数组，由于会不断加入新数据，当超过默认大小后，会创建一个更大的数组，并将原先的数组内容复制过来，再丢弃旧的数组。因此，对于较大对象的扩容会涉及大量的内存复制操作，如果能够预先评估大小，可提升性能。
- `StringBuilder` 不是线程安全的
- `StringBuffer` 类中方法定义前面都会有 `synchronize` 关键字，线程安全

# 6. 动态代理是基于什么原理
- 反射: 程序在运行时*自省*（introspect）的能力
- 静态代理：事先写好代理类，可以手工编写，也可以用工具生成。缺点是每个业务类都要对应一个代理类，非常不灵活
- 动态代理：运行时自动生成代理对象。缺点是生成代理代理对象和调用代理方法都要额外花费时间
  - JDK 动态代理：基于 Java 反射机制实现，必须要实现了接口的业务类才能用这种办法生成代理对象
  - cglib 动态代理：基于 ASM（字节码操作）机制实现，通过生成业务类的子类作为代理类

```java
// JDK 动态代理
public class MyDynamicProxy {
    public static void main(String[] args) {
        HelloImpl helloImpl = new HelloImpl();  
        MyInvocationHandler handler = new MyInvocationHandler(helloImpl); 
        // 为被调用目标构建代理对象
        Hello proxyHello = (Hello) Proxy.newProxyInstance(HelloImpl.class.getClassLoader(), HelloImpl.class.getInterfaces(), handler);
        // 调用代理方法
        proxyHello.sayHello();
    }
}
interface Hello { void sayHello(); }  // 纽带作用
class HelloImpl implements Hello {    // 被调用目标
    @Override
    public void sayHello() { System.out.println("Hello World"); }
}
class MyInvocationHandler implements InvocationHandler {
    private Object target;
    public MyInvocationHandler(Object target) { this.target = target; }
    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println("这里是代理插入的额外逻辑");
        Object result = method.invoke(target, args);
        return result;
    }
}
// 输出:
// 这里是代理插入的额外逻辑
// Hello World
```  

# 7. int、Integer
Integer 是 int 对应的包装类，Java 会根据上下文自动拆箱/装箱

# 8. Vector、ArrayList、LinkedList
- 都是有序集合
- ArrayList: 非线程安全的动态数组，扩容时空间增加 50%
- Vector: 是基于 `synchronized` 实现的线程安全的 `ArrayList` ，动态扩容时空间提高一倍
- 数组适合随机访问场合；除了尾部插入和删除元素，性能较差（往中间插入元素需移动后续所有元素
- 查找元素时需要遍历数组，对于非 `null` 元素采取 `equals` 方式寻找；扩容过程调用系统底层 `System.arraycopy()` 进行数组复制；缩小数组容量调用 `trimToSize()` 方法
- LinkedList: 非线程安全的双向链表，删除插入元素快，随机访问慢

# 9. Hashtable、HashMap、TreeMap
- 三者都是以键值对形式存储操作数据类型的容器类型
- `HashTable`：key-value 不能为 `null` ；无序；方法函数都是同步的（采用 `synchronized` 修饰）；不推荐使用
- `HashMap`：允许一个以 `null` 为 key 的键值，允许多个以 `null` 为 value 的键值；无序；不支持线程同步，若需同步则 1)`SynchronizedMap` 2) `ConcurrentHashMap`
  - 相较于 `HashTable` 锁住的是对象整体，`ConcurrentHashMap` 基于 lock 实现锁分段技术。先将 `Map` 存放的数据分段存储，然后给每一段数据分配一把锁，当一个线程占用锁访问其中一个段的数据时，其他段的数据也能被其他线程访问。`ConcurrentHashMap` 不仅保证了多线程运行环境下的数据访问安全性，而且性能上有长足的提升
  - `HashMap` 性能严重依赖哈希码的有效性，基于哈希思想，实现对数据的读写。当将键值对传递给 `put()` 方法时，它调用键对象的 `hashCode()` 方法计算 `hashcode`，让后找到 `bucket` 位置来储存值对象。当获取对象时，通过键对象的 `equals()` 方法找到正确的键值对，然后返回值对象
  - HashMap 当两个不同的键对象的 `hashcode` 相同时，它们会储存在同一个 `bucket` 位置的链表中，可通过键对象的 `equals()` 方法用来找到键值对。如果链表大小超过阈值（`TREEIFY_THRESHOLD`, 8），链表就会被改造为树形结构
- `TreeMap`：红黑树；未实现 `Comparator` 接口时，key 不可为 `null`；整体顺序由 `key` 顺序决定；
- `TreeSet`：默认用 `TreeMap` 实现，Java 类库创建了一个 Dummy 对象 `PRESENT`作为 value，然后所有插入的元素其实是以 key 的形式放入 `TreeMap` 里；同理，`HashSet` 也是以 `HashMap` 为基础实现

# 10. 如何保证集合是线性安全的；ConcurrentHashMap 如何实现高效的线程安全

# 11. Java IO 方式；NIO 如何实现多路复用
- BIO 同步阻塞
- NIO 同步非阻塞
- NIO2(AIO) 异步非阻塞

# 12. Java 有几种文件拷贝方式；哪种最高效
- 利用 java.io 类库，直接为源文件构建一个 `FileOutputStream`，完成写入

```java
public static void copyFileByStream(File source, File dest) throws IOException {
    try (InputStream is = new FileInputStream(source);
         OutputStream os = new FileOutputStream(dest);){
        byte[] buffer = new byte[1024];
        int length;
        while ((length = is.read(buffer)) > 0) {
            os.write(buffer, 0, length);
        }
    }
 }
```
- 利用 java.nio 类库提供的 `transferTo` 或 `transferFrom` 方法实现

```java
public static void copyFileByChannel(File source, File dest) throws IOException {
    try (FileChannel sourceChannel = new FileInputStream(source).getChannel();
         FileChannel targetChannel = new FileOutputStream(dest).getChannel();){
        for (long count = sourceChannel.size(); count>0;) {
            long transferred = sourceChannel.transferTo(
                    sourceChannel.position(), count, targetChannel);            sourceChannel.position(sourceChannel.position() + transferred);
            count -= transferred;
        }
    }
 }
```

# 13. 接口和抽象类的区别
- 接口是对行为的抽象，它是抽象方法的集合，利用接口可以达到 API 定义和实现分离的目的
- 抽象类是不能实例化的类，用 abstract 关键字修饰 class，其目的主要是代码重用

# 14. 设计模式
- 创建型
  - 工厂模式（Factory、Abstract Factory）
  - 单例模式（Singleton）
  - 构建器模式（Builder）
  - 原型模式（ProtoType）
- 结构型
  - 桥接模式（Bridge）
  - 适配器模式（Adapter）
  - 装饰者模式（Decorator）
  - 代理模式（Proxy
  - 组合模式（Composite）
  - 外观模式（Facade）
  - 享元模式（Flyweight）
- 行为型
  - 略模式（Strategy）
  - 解释器模式（Interpreter）
  - 命令模式（Command）
  - 观察者模式（Observer）
  - 迭代器模式（Iterator）
  - 模板方法模式（Template Method）
  - 访问者模式（Visitor）

# 15. synchronized、ReentranLock
- synchronized 修饰代码块、方法
- ReentranLock 修饰代码块，必须手动释放锁

# 16. synchronized 底层实现；锁的升级、降级

# 17. 一个线程两次调用 start() 方法会出现什么情况

# 18. 什么情况下 Java 程序会产生死锁；如何定位、修复
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

# 19. Java 并发包提供了哪些并发工具类
java.util.concurrent 及其子包提供了：
- 比 `synchronized` 更加高级的同步结构，包括 `CountDownLatch`、`CyclicBarrie`、`Semaphore` 等，可以实现更加丰富的多线程操作，比如利用 `Semaphore` 作为资源控制器，限制同时进行工作的线程数量
- 线程安全的容器，比如最常见的 `ConcurrentHashMap`、有序的 `ConcunrrentSkipListMap`，或者通过类似快照机制，实现线程安全的动态数组 `CopyOnWriteArrayList` 等
- 并发队列实现，如各种 `BlockedQueue`，比较典型的 `ArrayBlockingQueue`、`SynchorousQueue` 或针对特定场景的 `PriorityBlockingQueue` 等
- `Executor` 框架，可以创建各种不同类型的线程池

# 20. 并发包中 ConcurrentLinkedQueue 和 LinkedBlockingQueue 区别