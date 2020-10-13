---
title: "POSIX线程"
date: 2020-10-12T05:35:44+08:00
draft: false
tags:
  - C/C++
---

## 什么是线程

线程是一个进程内部的一个控制序列.
当在进程中创建一个新线程时, 新的执行线程将拥有自己的栈 (因此也有自己的局部变量), 但与它的创建者共享全局变量, 文件描述符, 信号处理函数, 当前目录状态.
线程切换的操作系统开销比进程之间的切换少的多.

## \_REENTRANT 宏

TODO

## 第一个例子

```cpp
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
// 定义一个函数原型, 这个函数接收任意参数, 返回任意类型
void *thread_function(void *arg);
char message[] = "hello world";
int main()
{
    int res;
    pthread_t a_thread;
    void *thread_result;
    // pthread_create 函数传递一个 pthread_t 类型对象的地址(a_thread), 之后可以用这个地址来引用新线程.
    // 第二个参数 NULL 表示不改变默认的线程属性.
    // 最后两个参数表示将要调用的函数和一个传递给该函数的参数. 注意这里的 message 是全局变量.
    res = pthread_create(&a_thread, NULL, thread_function, (void *)message);
    if (res != 0)
    {
        perror("thread creation failed");
        exit(EXIT_FAILURE);
    }
    printf("waiting for thread to finish.\n");
    // pthread_join 将等到它所指定的线程(a_thread)终止后才返回.
    // 第二个参数是前面定义的线程的返回值 thread_result
    res = pthread_join(a_thread, &thread_result);
    if (res != 0)
    {
        perror("thread join failed");
        exit(EXIT_FAILURE);
    }
    printf("thread joined, it returned %s\n", (char *)thread_result);
    printf("message is now %s\n", message); // 全局变量 message 被改变了
    exit(EXIT_SUCCESS);
}
void *thread_function(void *arg)
{
    printf("thread_function is running. argument was %s\n", (char *)arg);
    sleep(3);
    strcpy(message, "bye!");
    pthread_exit("thread_function finished."); // 这里是线程的返回值. thread_result
}
/* 程序输出:
waiting for thread to finish.
thread_function is running. argument was hello world
(阻塞等待3秒后)
thread joined, it returned thread_function finished.
message is now bye!
/*
```

## 线程的同步, 信号量, 互斥量

TODO

## 线程的属性

TODO

## 参考

- <<Linux 程序设计(第四版)>>
