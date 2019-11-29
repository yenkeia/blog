---
title: "<<Go语言核心36讲>>学习笔记"
date: 2018-11-29T12:27:47+08:00
draft: true
# keywords:
#   -
tags: 
  - Go
categories:
  - 学习笔记
---
极客时间[Go语言核心36讲](https://time.geekbang.org/column/112)

# 1. 工作区和GOPATH
环境变量 `GOPATH` 指向的是一个或多个工作区。
工作区用于放置 Go 语言的源码文件（source file），以及安装（install）后的归档文件（archive file，也就是以 `.a` 为扩展名的文件）和可执行文件（executable file）

# 2. 命令源码文件
- 源码文件分三种：命令源码文件、库源码文件、测试源码文件
- 命令源码文件是程序的运行入口，是每个可独立运行的程序必须拥有的，声明属于 `main` 包，并包含无参数无返回值的 `main` 函数

```go
package main
import "fmt"
func main() {fmt.Println("Hello, world!")}
```

- 命令源码文件通过 `flag` 包接收、解析命令参数

# 3. 库源码文件

# 4. 程序实体

# 7. 数组和切片

# 8. container包中的那些容器

# 9. 字典的操作和约束

# 10. 通道的基本操作

# 11. 通道的高级玩法

# 12. 使用函数的正确姿势

# 13. 结构体及其方法的使用法门

# 14. 接口类型的合理运用

# 15. 关于指针的有限操作

# 16. go语句及其执行规则（上）

# 17. go语句及其执行规则（下）

# 18. if语句、for语句和switch语句

# 19. 错误处理（上）

# 20. 错误处理 （下）

# 21. panic函数、recover函数以及defer语句 （上）

# 22. panic函数、recover函数以及defer语句（下）

# 23. 测试的基本规则和流程 （上）

# 24. 测试的基本规则和流程（下）

# 25. 更多的测试手法

# 26. sync.Mutex与sync.RWMutex

# 27. 条件变量sync.Cond （上）

# 28. 条件变量sync.Cond （下）

# 29. 原子操作（上）

# 30. 原子操作（下）

# 31. sync.WaitGroup和sync.Once

# 32. context.Context类型

# 33. 临时对象池sync.Pool

# 34. 并发安全字典sync.Map （上）

# 35. 并发安全字典sync.Map (下)

# 36. unicode与字符编码

# 37. strings包与字符串操作

# 38. bytes包与字节串操作（上）