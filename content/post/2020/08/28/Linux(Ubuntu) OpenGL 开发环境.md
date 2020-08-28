---
title: "Linux(Ubuntu) OpenGL 开发环境"
date: 2020-08-28T10:09:15+08:00
draft: false
# keywords:
#   -
tags:
  - OpenGL
categories:
  - 游戏
---

## 准备

```bash
sudo apt-get install build-essential
sudo apt-get install libgl1-mesa-dev  # OpenGL 库
sudo apt-get install libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev
```

## GLFW

下载编译源码

```bash
cd ~/Codes
git clone https://github.com/glfw/glfw.git
mkdir -p ~/Codes/glfw/glfw-build
cd ~/Codes/glfw/glfw-build
cmake ~/Codes/glfw
sudo make install
```

运行 example

```bash
./examples/wave
```

## GLAD

GLAD 是第三方的 OpenGL 开源库，需要到 [https://glad.dav1d.de/](https://glad.dav1d.de/) 生成 include 头文件.

选好 C++ OpenGL 版本，生成压缩包并下载.

```bash
cd ~/Downloads
unzip glad.zip
sudo cp -r glad /usr/include
sudo cp -r KHR /usr/include
```

src/glad.c 要保留.

## 第一个测试程序

新建目录

```bash
mkdir -p ~/Codes/glfw-test-application
cd ~/Codes/glfw-test-application
cp ~/Downloads/glad/src/glad.c . # 把 glad.c 复制到当前目录
```

新建 main.cpp

```cpp
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <iostream>

int main()
{
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    //glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
    GLFWwindow *window = glfwCreateWindow(800, 600, "LearnOpenGL", NULL, NULL);
    if (window == NULL)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
    {
        std::cout << "Failed to initialize GLAD" << std::endl;
        return -1;
    }
    glViewport(0, 0, 800, 600);
    glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
    while (!glfwWindowShouldClose(window))
    {
        glClear(GL_COLOR_BUFFER_BIT);
        glfwSwapBuffers(window);
        glfwPollEvents();
    }
    glfwTerminate();
    return 0;
}
```

新建 CMakeLists.txt

```plain
CMAKE_MINIMUM_REQUIRED(VERSION 3.16)
PROJECT(test)

FIND_PACKAGE(glfw3 REQUIRED)
FIND_PACKAGE(OpenGL REQUIRED)

SET(SOURCE_FILES main.cpp glad.c)

ADD_EXECUTABLE(test ${SOURCE_FILES})
TARGET_LINK_LIBRARIES(test glfw)
TARGET_LINK_LIBRARIES(test OpenGL::GL)
```

编译运行，即可看到暗绿色的窗口.

```bash
mkdir build
cd build
cmake ..
make
./test
```

## 参考资料

- [GLFW-Building applications](https://www.glfw.org/docs/latest/build_guide.html)
- [Linux(Ubuntu) OpenGL 开发环境](https://www.cnblogs.com/psklf/p/9705688.html)
- [how-to-build-install-glfw-3-and-use-it-in-a-linux-project](https://stackoverflow.com/questions/17768008/how-to-build-install-glfw-3-and-use-it-in-a-linux-project)
