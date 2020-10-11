---
title: "JavaScript V8 引擎入门"
date: 2020-10-10T08:26:23+08:00
draft: false
tags:
  - C/C++
  - JavaScript
---

## 什么是 V8?

V8 是谷歌开源的 JavaScript 解析器.

## 编译

编译的第一步是获取源码.
通过 git 拉取的 V8 项目源码是不完整的, 缺少依赖, 只能通过 gclient 方式拉取源码.
但是由于防火墙的原因, gclient 方式获取源码在国内是不可能的.
nodejs 是依赖 V8 作为 JavaScript 的运行环境的, 因此本文不通过 V8 项目源码编译, 而是采用曲线救国的方式, 通过 nodejs 的源码编译出动态库, 这其中就包括了 V8 的函数实现.

首先拉取 nodejs 源码, 如果访问 github 速度太慢, 可以通过国内的 gitee 加速.

```shell
cd ~/Codes
git clone https://github.com/nodejs/node.git
```

获取 nodejs 源码后, 就可以进行漫长的编译了.

```shell
cd node
# 编译出 nodejs 动态库, 如果不加 --shared, 则会编译出可执行文件
./configure --shared
make -j 8
```

耗时大概 35 分钟, 编译完成.
可以看到 `out/Release/obj.target` 目录下有编译出的 `libnode.so.86` 即 node 的动态库.

## Hello World!

新建一个 C++ 的项目:

```shell
cd ~/Codes/temp
mkdir include
mkdir lib
touch main.cpp
# 把 nodejs 项目里的 V8 头文件复制到 include/v8 文件夹下:
cp -r ~/Codes/node/deps/v8/include ~/Codes/temp/include/v8
# 复制编译好的动态库
# 这里不是很理解 linkname, soname, realname
cp ~/Codes/node/out/Release/obj.target/libnode.so.86 ~/Codes/temp/lib/libnode.so # 注意 这里去掉了后缀 .86
sudo cp ~/Codes/node/out/Release/obj.target/libnode.so.86 /lib
```

打开 main.cpp 输入以下内容:

```cpp
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "libplatform/libplatform.h"
#include "v8.h"
int main(int argc, char *argv[])
{
    // 初始化v8
    v8::V8::InitializeICUDefaultLocation(argv[0]);
    v8::V8::InitializeExternalStartupData(argv[0]);
    std::unique_ptr<v8::Platform> platform = v8::platform::NewDefaultPlatform();
    v8::V8::InitializePlatform(platform.get());
    v8::V8::Initialize();
    // 创建一个isolate
    v8::Isolate::CreateParams create_params;
    create_params.array_buffer_allocator =
        v8::ArrayBuffer::Allocator::NewDefaultAllocator();
    v8::Isolate *isolate = v8::Isolate::New(create_params);
    //构建好isolate开始编程
    {
        v8::Isolate::Scope isolate_scope(isolate);
        // 构建一个handle_scope管理即将分配的各种变量
        v8::HandleScope handle_scope(isolate);
        // 构建一个上下文context
        v8::Local<v8::Context> context = v8::Context::New(isolate);
        // 将context放进scope中v8会进行管理
        v8::Context::Scope context_scope(context);
        // 构建一段string类型的handle，这一段内容就是javascript了
        v8::Local<v8::String> source =
            v8::String::NewFromUtf8(isolate, "'Hello' + ', World!'",
                                    v8::NewStringType::kNormal)
                .ToLocalChecked();
        // 编译代码
        v8::Local<v8::Script> script =
            v8::Script::Compile(context, source).ToLocalChecked();
        // 跑代码
        v8::Local<v8::Value> result = script->Run(context).ToLocalChecked();
        // 转换成utf8的变量
        v8::String::Utf8Value utf8(isolate, result);
        // c语言经典打印函数
        printf("%s\n", *utf8);
        // 输出v8版本号
        printf("v8 version: %s\n", v8::V8::GetVersion());
    }
    // 关闭v8并且清理内存
    isolate->Dispose();
    v8::V8::Dispose();
    v8::V8::ShutdownPlatform();
    delete create_params.array_buffer_allocator;
    return 0;
}
```

编译:

```shell
g++ -I ./include -I ./include/v8 ./main.cpp -L ./lib -lnode
# -I 指定头文件目录
# -L ./lib 指定动态库目录
# -lnode 使用 ./lib 目录下的 libnode.so, 连接器 ld 会去 /lib 目录下找到 libnode.so.86
```

运行:

```shell
./a.out
```

即可看到:

```plain
Hello, World!
v8 version: 8.4.371.19-node.16
```

## 参考资料

- [V8 概念以及编程入门](https://zhuanlan.zhihu.com/p/35371048)
- [how to build nodejs as a shared library from source code](https://stackoverflow.com/questions/15977901/how-to-build-nodejs-as-a-shared-library-from-source-code)
