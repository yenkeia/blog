---
title: "用Vscode调试dotnet程序"
date: 2019-11-15T17:59:15+08:00
draft: false
# keywords:
#   -
tags: 
  - C#
categories:
  - 笔记
---

生成 dotnet 项目
```shell
dotnet new console -o demo5
```


在 .vscode/launch.json 中加上
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": ".NET Core Launch (console)",
            "type": "coreclr",
            "request": "launch",
            "preLaunchTask": "build demo5",
            "program": "${workspaceFolder}/dotnet/demo5/bin/Debug/netcoreapp3.0/demo5.dll",
            "args": [],
            "cwd": "${workspaceFolder}",
            "stopAtEntry": false,
            "console": "internalConsole",
            "logging": {
                "moduleLoad": false
            }
        }
    ]
}
```


在 .vscode/tasks.json 加上
```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "build demo5",
            "type": "process",
            "command": "dotnet",
            "args": [
                "build",
                "${workspaceFolder}/dotnet/demo5/demo5.csproj"
            ]
        }
    ]
}
```
这一步的目的是在 debug 前编译项目


打开 Program.cs, 打断点, 用 F5 调试
