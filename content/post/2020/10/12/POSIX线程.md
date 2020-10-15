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

最初设计 POSIX 规范时只考虑了一个进程只有一个执行线程, 这在多线程程序中会出问题,
比如用于获取某个函数调用失败的 `errno` 变量, 在多线程环境下会被多个线程共享,
一个线程准备获取刚才的错误代码时, 该变量很容易被另一个线程中的函数调用所改变.
为了解决这些问题需要编写*可重入*的代码, 即被多个线程调用仍然正常工作, 可重入部分只使用局部变量.
`_REENTRANT` 宏告诉编译器需要可重入功能, 这个宏位于任何的 `#include` 语句之前.

- 它会对部分函数重新定义它们的可安全重入版本, 只是在函数尾加上 `_r` 字符串, 比如 `gethostbyname` 变为 `gethostbyname_r`
- stdio.h 中原来以宏的形式实现的一些函数将变为可重入函数
- 在 errno.h 中定义的变量 `errno` 将成为一个函数调用, 它能够以多线程安全的方式获取 `errno` 值

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
(线程开始执行)
thread_function is running. argument was hello world
(3秒后)
thread joined, it returned thread_function finished.
message is now bye!
/*
```

## 线程的同步, 信号量, 互斥量

### 用信号量进行同步

- 二进制信号量, 只有 0 和 1 两种取值, 一般常用来保护一段代码使其每次只能被一个执行线程运行.

- 计数信号量, 允许有限数目的线程执行一段指定的代码

计数信号量仅仅是二进制信号量的一种逻辑拓展, 两者实际调用的函数都一样.

```cpp
// 使用信号量同步
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>
void *thread_function(void *arg);
sem_t bin_sem;
#define WORK_SIZE 1024
char work_area[WORK_SIZE];
int main()
{
    int res;
    pthread_t a_thread;
    void *thread_result;
    // 初始化由 sem 指向的信号量对象, 设置它的共享选项, 并给它一个初始的整数值 0
    res = sem_init(&bin_sem, 0, 0);
    if (res != 0)
    {
        perror("semaphore initialization failed");
        exit(EXIT_FAILURE);
    }
    res = pthread_create(&a_thread, NULL, thread_function, NULL);
    if (res != 0)
    {
        perror("thread creation failed");
        exit(EXIT_FAILURE);
    }
    // 从键盘读取一些文本并把它们放到工作区 work_area 数组中, 然后调用 sem_post 增加信号量的值.
    // 另一个线程此时已经调用 sem_wait 阻塞, sem_post 令另一个线程从 sem_wait 的等待中返回并开始执行.
    // 在统计完字符个数后, 它(另一个线程)再次调用 sem_wait 并再次阻塞, 直到主线程再次调用 sem_post 增加信号量的值.
    printf("input some text. enter 'end' to finish.\n");
    while (strncmp("end", work_area, 3) != 0)
    {
        fgets(work_area, WORK_SIZE, stdin);
        // sem_post 的作用是以原子操作的方式给信号量的值加 1
        sem_post(&bin_sem);
    }
    // 在新线程中调用 sem_wait 等待信号量, 然后统计输入的字符个数
    printf("\nwaiting for thread to finish.\n");
    res = pthread_join(a_thread, &thread_result);
    if (res != 0)
    {
        perror("thread join failed");
        exit(EXIT_FAILURE);
    }
    printf("thread joined\n");
    sem_destroy(&bin_sem);
    exit(EXIT_SUCCESS);
}
// 在新线程中调用 sem_wait 等待信号量, 然后统计输入的字符个数
// sem_wait 会等待直到信号量有个非零值才会减 1
// 如果对值为 0 的信号量调用 sem_wait, 这个函数会等待(阻塞), 直到有其他线程增加了该信号量的值使其不再是 0 为止
void *thread_function(void *arg)
{
    sem_wait(&bin_sem);
    while (strncmp("end", work_area, 3) != 0)
    {
        printf("you input %d characters\n", strlen(work_area) - 1);
        sem_wait(&bin_sem);
    }
    pthread_exit(NULL);
}
/*
gcc -D_REENTRANT thread3.c -lpthread
./a.out

input some text. enter 'end' to finish.
asdfgh
you input 6 characters
aaa
you input 3 characters
asdf
you input 4 characters
end

waiting for thread to finish.
thread joined
*/
```

### 用互斥量进行同步

为了控制对关键代码的访问, 必须在进入这段代码之前锁住一个互斥量, 然后在完成操作之后解锁它.

下面的实例代码只是演示互斥量怎么用, 并不是最佳实践, 在实际编程中应该避免用轮询来获得结果.

```cpp
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>
void *thread_function(void *arg);
pthread_mutex_t work_mutex; // 声明一个互斥量
#define WORK_SIZE 1024
char work_area[WORK_SIZE];  // 工作区
int time_to_exit = 0;
int main()
{
    int res;
    pthread_t a_thread;
    void *thread_result;
    // 初始化互斥量
    res = pthread_mutex_init(&work_mutex, NULL);
    if (res != 0)
    {
        perror("mutex initialization failed");
        exit(EXIT_FAILURE);
    }
    // 启动新线程
    res = pthread_create(&a_thread, NULL, thread_function, NULL);
    if (res != 0)
    {
        perror("thread creation failed");
        exit(EXIT_FAILURE);
    }
    // 主线程先给工作区(work_area字符数组)加锁, 读入文本到它里面
    pthread_mutex_lock(&work_mutex);
    printf("input some text. enter 'end' to finish\n");
    while (!time_to_exit)
    {
        fgets(work_area, WORK_SIZE, stdin);
        // 然后解锁允许其他线程对它访问(统计字符串长度)
        pthread_mutex_unlock(&work_mutex);
        while (1)
        {
            // 周期性对互斥量再加锁, 检查字符串数目是否已经统计完成(另一个线程).
            pthread_mutex_lock(&work_mutex);
            if (work_area[0] != '\0')
            {
                // 如果还需要等待(用户没有输入 end, 第一个元素就不为 \0 null)
                // 则释放互斥量
                pthread_mutex_unlock(&work_mutex);
                sleep(1);
            }
            else
            {
                break;
            }
        }
    }
    pthread_mutex_unlock(&work_mutex);
    printf("\nwaiting for thread to finish.\n");
    res = pthread_join(a_thread, &thread_result);
    if (res != 0)
    {
        perror("thread join failed");
        exit(EXIT_FAILURE);
    }
    printf("thread joined\n");
    pthread_mutex_destroy(&work_mutex);
    exit(EXIT_SUCCESS);
}
// 新线程中执行的函数
void *thread_function(void *arg)
{
    sleep(1);
    // 新线程首先试图对互斥量加锁, 如果它已经被锁住, 这个调用将被阻塞直到互斥量被释放.
    pthread_mutex_lock(&work_mutex);
    // 获得访问权
    // 如果用户不输入 end 则进入循环
    while (strncmp("end", work_area, 3) != 0)
    {
        printf("you input %d characters\n", strlen(work_area) - 1);
        work_area[0] = '\0';    // 用第一个字符设置为 null 的方法通知已经完成统计
        pthread_mutex_unlock(&work_mutex);
        sleep(1);
        pthread_mutex_lock(&work_mutex);
        while (work_area[0] == '\0')
        {
            pthread_mutex_unlock(&work_mutex);
            sleep(1);
            pthread_mutex_lock(&work_mutex);
        }
    }
    // 如果用户输入 end 则退出上面的循环,
    // 将工作区 work_area (就是用来存屏幕输入的字符数组) 的第一个字符设置为 \0 (null)
    time_to_exit = 1;
    work_area[0] = '\0';
    pthread_mutex_unlock(&work_mutex);
    pthread_exit(0);
}
```

## 线程的属性

TODO

## 多线程

在一个程序中创建多个线程, 然后又以不同于其启动的顺序将他们合并到一起.

```cpp
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>
#define NUM_THREADS 6
void *thread_function(void *arg);
int main()
{
    int res;
    pthread_t a_thread[NUM_THREADS];
    void *thread_result;
    int lots_of_threads;
    for (lots_of_threads = 0; lots_of_threads < NUM_THREADS; lots_of_threads++)
    {
        res = pthread_create(&(a_thread[lots_of_threads]), NULL, thread_function, (void *)lots_of_threads);
        if (res != 0)
        {
            perror("thread creation failed");
            exit(EXIT_FAILURE);
        }
        // sleep(1);
    }
    printf("waiting for threads to finish.\n");
    for (lots_of_threads = NUM_THREADS - 1; lots_of_threads >= 0; lots_of_threads--)
    {
        res = pthread_join(a_thread[lots_of_threads], &thread_result);
        if (res == 0)
        {
            printf("picked up a thread\n");
        }
        else
        {
            perror("pthread_join failed");
        }
    }
    printf("all done\n");
    exit(EXIT_SUCCESS);
}

void *thread_function(void *arg)
{
    int my_number = (int)arg;
    int rand_num;
    printf("thread_function is running. argument was %d\n", my_number);
    rand_num = 1 + (int)(9.0 * rand() / (RAND_MAX + 1.0));
    sleep(rand_num);
    printf("bye from %d\n", my_number);
    pthread_exit(NULL);
}
/*
thread_function is running. argument was 0
thread_function is running. argument was 3
thread_function is running. argument was 4
thread_function is running. argument was 1
thread_function is running. argument was 2
waiting for threads to finish.
thread_function is running. argument was 5
bye from 5
picked up a thread
bye from 3
bye from 0
bye from 4
bye from 1
picked up a thread
picked up a thread
bye from 2
picked up a thread
picked up a thread
picked up a thread
all done
*/
```

## 参考

- <<Linux 程序设计(第四版)>>
