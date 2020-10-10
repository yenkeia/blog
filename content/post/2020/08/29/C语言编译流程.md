---
title: "C语言编译流程"
date: 2020-08-29T13:54:50+08:00
draft: false
# keywords:
#   -
tags:
  - C/C++
categories:
  - 编程语言
---

## GCC

GCC 的目标是生成可执行文件.

假设有两个源文件 `fun.c` 和 `main.c`, `fun.c` 中包含了 `main.c` 中声明的函数主体, 可以通过 `gcc fun.c main.c -o main` 生成可执行程序 `main`.

```bash
gcc -c fun.c
gcc -c main.c
gcc fun.o main.o -o main
```

过程: 源文件(.c) -> 编译(gcc) -> 可执行程序

## 编译

编译分为多个步骤:

1. 预编译: 处理源文件里的预编译指令(以`#`开头), 如 `#include`
2. 翻译: `gcc -c`, 对源代码进行语法检查并翻译成机器指令, 生成目标文件(.o)
3. 链接: 将多个目标文件链接成可执行文件

也可以用源文件和目标文件生成可执行文件:

```bash
gcc -c fun.c
gcc main.c fun.o -o main
```

## 函数库

假设有 `main.c`:

```c
void write(char *); // 函数声明
int add(int, int);  // 函数声明
int sub(int, int);  // 函数声明
int main(void){
  write("123\n");
  int a = add(1, 2);
  int b = sub(1, 2);
}
```

`main.c` 的函数实现分散在 `fun1.c`, `fun2.c`, `fun3.c` 三个文件中,
执行 `gcc -c fun1.c fun2.c fun3.c` 得到三个中间文件 `fun1.o fun2.o fun3.o`,
链接 `gcc fun1.o fun2.o fun3.o main.c` 得到可执行文件.

当生成的中间文件越来越多时, 可以用 `ar` 命令将所有中间文件存储在一起: `ar r libxxx.a fun1.o fun2.o fun3.o`, 得到**函数库(库文件)** `libxxx.a`. 最后通过 `gcc main.c libxxx.a` 生成可执行程序.

函数库中的函数(实现)称为**库函数**.

## 静态库和共享库

函数库分为两种, 以 `.a` 结尾的称为**静态库**, 以 `.so` 结尾的称为**共享库**(动态库/动态链接库).

源文件和静态库链接生成的可执行程序中, 包含了程序执行所用到的函数体(函数实现)的代码, 因此程序体积相对较大. 可执行程序运行时, 只载入了它需要的函数, 而不是载入静态库中所有的函数.

生成共享库的方式: `gcc -shared -o libxxx.so fun1.o fun2.o fun3.o`
源文件和共享库链接生成可执行程序: `gcc main.c libxxx.so`

源文件和共享库链接生成的可执行程序中, 不包含它所用到的函数的代码, 因此程序体积相对较小. 程序启动后, 当执行到共享库中的函数时, 程序会找到共享库的位置, 然后将其所需要的函数从共享库中加载到内存中.

程序找到共享库的方式: `export LD_LIBRARY_PATH = ./`.
环境变量 `LD_LIBRARY_PATH` 主要用于指定查找共享库时除了默认路径之外的其他路径.

## 头文件, 预处理指令, 文件包含指令

当需要大量且频繁地使用库函数时, 在程序开头声明函数原型就变得非常麻烦, 因此可以把一个函数库中所有函数实现的函数原型的*声明*, 集中到一个 `.h` 结尾的文件中, 这个文件称为**头文件**.

程序中 `#` 是预处理指令标识, `#include` 是其中的一种预处理指令: 文件包含指令, 作用是把指令自身替换为它所指定的文件的内容.

## include 的两种形式和预处理器的搜索路径

- `#include "stdio.h"`

  1. 源文件所在的路径
  2. `-I` 选项所指定的路径
  3. 环境变量 `C_INCLUDE_PATH` 包含的路径 (`export C_INCLUDE_PATH = ...`)
  4. 预配置的路径 (预处理器 `cpp -v`)

- `#include <stdio.h>`
  1. `-I` 选项所指定的路径
  2. 环境变量 `C_INCLUDE_PATH` 包含的路径
  3. 预配置的路径

## linkname, soname, realname

TODO...
参考: https://www.limitedwish.org/threethings/2012/07/16/linkname-soname-realname/
