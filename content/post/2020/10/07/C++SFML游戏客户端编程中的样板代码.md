---
title: "C++SFML游戏客户端编程中的样板代码"
date: 2020-10-07T23:03:08+08:00
draft: false
tags:
  - c/c++
  - 游戏
  - SFML
categories:
  - 笔记
---

## 介绍

记录一些阅读 <<SFML Game Development>> <<SFML Game Development By Example>> 等的样板代码, 以及做些笔记.

## 主循环

```cpp
void Application::run()
{
	sf::Clock clock;
	sf::Time timeSinceLastUpdate = sf::Time::Zero;
	sf::Time timePerFrame = sf::seconds(1.f/60.f);
	while (mWindow.isOpen())
	{
		sf::Time dt = clock.restart();	// dt: deltaTime 两次循环时间差
		timeSinceLastUpdate += dt;		// 游戏世界中, 两帧之间的时间差
		while (timeSinceLastUpdate > timePerFrame)
		{
			timeSinceLastUpdate -= timePerFrame;
			processInput();	// 处理用户输入(比如键盘鼠标窗口)
			update(timePerFrame);
			if (mStateStack.isEmpty())
				mWindow.close();
		}
		updateStatistics(dt);	// 更新 FPS 等信息
		render();				// 渲染
	}
}
// 参考: http://sshpark.com.cn/2019/06/05/用C++和SFML写游戏-Game类的创建（2）/
```
