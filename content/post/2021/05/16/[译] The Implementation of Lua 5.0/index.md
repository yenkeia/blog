---
title: "[译] The Implementation of Lua 5.0"
date: 2021-05-16T19:55:06+08:00
draft: false
tags:
  - 翻译练习
  - Lua
---

> 原文地址: [The implementation of Lua 5.0](http://www.lua.org/doc/jucs05.pdf)
>
> 原文作者: R. Ierusalimschy, L. H. de Figueiredo, W. Celes

## 1. Introduction (介绍)

Lua was born in an academic laboratory as a tool for in-house software development but somehow was adopted by several industrial projects around the world
and is now widely used in the game industry.

Lua 诞生于一个学术实验室作为一种工具用于内部的软件开发, 适用于世界上多数行业, 如今广泛用于游戏行业.

How do we account for this widespread use of Lua? We believe that the
answer lies in our design and implementation goals: to provide an embeddable
scripting language that is simple, efficient, portable, and lightweight.

我们如何解释 Lua 的广泛使用呢? 我们相信答案在于我们的设计和实现目标: 提供一门简单, 高效, 便捷, 轻量的嵌入式脚本语言.

These have been our main goals since the birth of Lua in 1993 and they have been respected
during its evolution. These features, plus the fact that Lua has been
designed from the start to be embedded into larger applications, account for its
early adoption by the industry.

自从 1993 年 Lua 诞生以来这是我们的主要目标. 这些特性, 加上事实上 Lua 从设计之初便被嵌入到大型应用中, 说明它很早就被业界采用了.

Widespread use generates demand for language features. Several features
of Lua have been motivated by industrial needs and user feedback. Important
examples are the introduction of coroutines in Lua 5.0 and the implementation of incremental garbage collection in the upcoming Lua 5.1. Both features are
specially important for games.

广泛的使用产生了对语言特性的需求. Lua 的许多特性都是以解决产业的需求和用户的反馈为目的. 例子就是 Lua 5.0 引入的协程 (coroutine) 和即将到来的 Lua 5.1 引入的增量式垃圾回收 (incremental garbage collection). 这两种特性对游戏来说都很重要.

In this paper, we discuss the main novelties of the implementation of Lua 5.0,
compared to Lua 4.0:

在这篇论文中, 我们讨论了 Lua 5.0 相对于 Lua 4.0 实现上的创新:

- _Register-based virtual machine_: Traditionally, most virtual machines intended
  for actual execution are stack based, a trend that started with Pascal’s Pmachine and continues today with Java’s JVM and Microsoft’s .Net environment. Currently, however, there has been a growing interest in registerbased virtual machines (for instance, the planned new virtual machine for Perl 6 (Parrot) will be register based). As far as we know, the virtual
  machine of Lua 5.0 is the first register-based virtual machine to have a wide
  use. This virtual machine is presented in Section 7.

  _基于寄存器 (Register-based) 的虚拟机_: 大多数虚拟机都是基于栈的虚拟机, 例如 Pascal 的 Pmachine, Java 的 JVM, 微软的 .Net environment. 然而目前寄存器式虚拟机在增长 (例如 Perl 6 的新的虚拟机 Parrot 将使用寄存器式虚拟机). 目前我们所知道的是 Lua 5.0 是第一个广泛使用的基于寄存器的虚拟机. 这将在第七部分阐述.

- _New algorithm for optimizing tables used as arrays_: Unlike other scripting languages, Lua does not offer an array type. Instead, Lua programmers use
  regular tables with integer indices to implement arrays. Lua 5.0 uses a new
  algorithm that detects whether tables are being used as arrays and automatically stores the values associated to numeric indices in an actual array,
  instead of adding them to the hash table. This algorithm is discussed in
  Section 4.

  _新的算法使用数组 (array) 来优化表 (table)_: Lua 不像其它语言一样提供数组类型 (array type). Lua 程序员使用常见的表加上整数索引来实现数组. Lua 5.0 使用一种新的算法来检测表是否被用来当做数组来使用, 并自动存储关联到数组中的数字索引的值, 而不是将它们添加到哈希表. 这个算法将在第四部分讨论.

- _The implementation of closures_: Lua 5.0 supports first-class functions with lexical scoping. This mechanism poses a well-known difficulty for languages
  that use an array-based stack to store activation records. Lua uses a novel
  approach to function closures that keeps local variables in the (array-based)
  stack and only moves them to the heap if they go out of scope while being
  referred by nested functions. The implementation of closures is discussed in
  Section 5.

  _闭包 (closure) 的实现_: Lua 5.0 的词法作用域 (lexical scoping) 支持第一等 (first-class) 函数. 这一机制造成了语言众所周知的困难, 就是使用基于数组的栈 (array-based stack) 来存储活动记录 (activation record). 对于函数闭包 (function closure) Lua 使用一种新颖的方法, 保留本地变量到基于数组的栈中, 同时如果它们被嵌套式的函数引用而超出了范围 (scope), 那也仅移动它们到堆 (heap) 中.

- _The addition of coroutines_: Lua 5.0 introduced coroutines in the language.
  Although the implementation of coroutines is more or less traditional, we
  present a short overview in Section 6 for completeness.

  _新增的协程 (coroutine)_: Lua 5.0 引入了协程, 尽管实现协程的是传统方法, 我们将在第六部分简要概述.

The other sections complement or give background to this discussion. In Section 2 we present an overview of Lua’s design goals and how those goals have
driven its implementation. In Section 3 we describe how Lua represents its values. Although the representation itself has no novelties, we need this material
for the other sections. Finally, in Section 8 we present a small benchmark and
draw some conclusions.

其他部分补充或提供了本讨论的背景. 在第二部分我们大致浏览了 Lua 的设计目标以及这些目标是如何指引其实现的. 在第三部分我们描述了 Lua 如何表现它的值 (value). 尽管这些没有新意但我们需要这些基础来继续剩下的部分. 最终在第八部分, 我们展现了基准测试以及画出结果.

## 2. An Overview of Lua’s Design and Implementation (Lua 设计与实现概述)

As mentioned in the introduction, the goals in our implementation of Lua are:

正如介绍里提到的那样, 我们实现 Lua 的目的是:

- _Simplicity_: We seek the simplest language we can afford and the simplest C code
  that implements this language. This implies a simple syntax with a small
  number of language constructs, not far from the tradition.

- _Efficiency_: We seek fast compilation and fast execution of Lua programs. This
  implies a fast, smart, one-pass compiler and a fast virtual machine.

- _Portability_: We want Lua to run on as many platforms as possible. We want to
  be able to compile the Lua core unmodified everywhere and to run Lua programs unmodified on every platform that has a suitable Lua interpreter. This
  implies a clean ANSI C implementation with special attention to portability
  issues, such as avoiding dark corners of C and its libraries, and ensuring that
  it also compiles cleanly as C++. We seek warning-free compilations.

- _Embeddability_: Lua is an extension language; it is designed to provide scripting
  facilities to larger programs. This and the other goals imply the existence
  of a C API that is simple and powerful, but which relies mostly on built-in
  C types.

- _Low embedding cost_: We want it to be easy to add Lua to an application without
  bloating it. This implies tight C code and a small Lua core, with extensions
  being added as user libraries.

These goals are somewhat conflicting. For instance, Lua is frequently used as a
data-description language, for storing and loading configuration files and sometimes quite large databases (Lua programs with a few megabytes are not uncommon). This implies that we need a fast Lua compiler. On the other hand, we want
Lua programs to execute fast. This implies a smart compiler, one that generates
good code for the virtual machine. So, the implementation of the Lua compiler
has to balance between these two requirements. However, the compiler cannot
be too large; otherwise it would bloat the whole package. Currently the compiler
accounts for approximately 30% of the size of the Lua core. For memory-limited
applications, such as embedded systems, it is possible to embed Lua without the
compiler. Lua programs are then precompiled off-line and loaded at run time by a tiny module (which is also fast because it loads binary files).

Lua uses a hand-written scanner and a hand-written recursive descent parser.
Until version 3.0, Lua used a parser produced by yacc, which proved a valuable tool when the language’s syntax was less stable. However, the hand-written
parser is smaller, more efficient, more portable, and fully reentrant. It also provides better error messages.

The Lua compiler uses no intermediate representation. It emits instructions
for the virtual machine “on the fly” as it parses a program. Nevertheless, it does
perform some optimizations. For instance, it delays the generation of code for
base expressions like variables and constants. When it parses such expressions, it
generates no code; instead, it uses a simple structure to represent them. Therefore, it is very easy to check whether an operand for a given instruction is a
constant or a local variable and use those values directly in the instruction, thus
avoiding unnecessary and costly moves (see Section 3).

To be portable across many different C compilers and platforms, Lua cannot use several tricks commonly used by interpreters, such as direct threaded
code [8, 16]. Instead, it uses a standard while–switch dispatch loop. Also, at
places the C code seems unduly complicated, but the complication is there to ensure portability. The portability of Lua’s implementation has increased steadily
throughout the years, as Lua got compiled under many different C compilers
in many different platforms (including several 64-bit platforms and some 16-bit
platforms).

We consider that we have achieved our design and implementation goals. Lua
is a very portable language: it runs on any machine with an ANSI C compiler,
from embedded systems to mainframes. Lua is really lightweight: for instance, on
Linux its stand-alone interpreter, complete with all standard libraries, takes less
than 150 Kbytes; the core is less than 100 Kbytes. Lua is efficient: independent benchmarks [2, 4] show Lua as one of the fastest language implementations in the
realm of scripting languages (i.e., interpreted and dynamically-typed languages).
We also consider Lua a simple language, being syntactically similar to Pascal
and semantically similar to Scheme, but this is subjective.

## 3. The Representation of Values (值的表现形式)

## 4. Tables (表)

## 5. Functions and Closures (函数和闭包)

## 6. Threads and Coroutines (线程和协程)

## 7. The Virtual Machine (虚拟机)

## 8. Conclusion (结论)
