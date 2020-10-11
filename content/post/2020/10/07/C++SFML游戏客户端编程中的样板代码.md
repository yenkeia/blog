---
title: "C++SFML游戏客户端编程中的样板代码"
date: 2020-10-07T23:03:08+08:00
draft: false
tags:
  - C/C++
  - 游戏
  - SFML
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
		timeSinceLastUpdate += dt;	// 游戏世界中, 两帧之间的时间差
		while (timeSinceLastUpdate > timePerFrame)
		{
			timeSinceLastUpdate -= timePerFrame;
			processInput();	// 处理用户输入(比如键盘鼠标窗口)
			update(timePerFrame);
			if (mStateStack.isEmpty())
				mWindow.close();
		}
		updateStatistics(dt);	// 更新 FPS 等信息
		render();	// 渲染
	}
}
// 参考: http://sshpark.com.cn/2019/06/05/用C++和SFML写游戏-Game类的创建（2）/
```

## 代码命名规则

类成员变量以 `m` 开头, 如: `mWindow`, `mIsMovingUp`. 类成员函数(方法)以小写开头: `update()`, 类静态变量及静态函数以大写开头: `PlayerSpeed`, 和 Java 驼峰命名一致.

## 资源加载

资源加载一般在程序入口 `Application`(也叫`Game`) 类初始化时一同初始化.

```cpp
// Application.h
class Application
{
	// 省略一些函数以及成员变量
	private:
		sf::RenderWindow mWindow;	// 窗口
		TextureHolder mTextures;	// 素材加载
	  	FontHolder mFonts;	// 字体加载
};
// Application.cpp
Application::Application()
: mWindow(sf::VideoMode(1024, 768), "Graphics", sf::Style::Close)
, mTextures() // 素材资源初始化
, mFonts() // 素材资源初始化
{
	mWindow.setKeyRepeatEnabled(false);
	mWindow.setFramerateLimit(60);
	mFonts.load(Fonts::Main, "Media/Sansation.ttf"); // 素材加载
	mTextures.load(Textures::TitleScreen, "Media/Textures/TitleScreen.png"); // 素材加载
	mTextures.load(Textures::Buttons, "Media/Textures/Buttons.png");// 素材加载
}
```

`TextureHolder`, `FontHolder` 在 `ResourceHolder.hpp` 中定义:

```cpp
// ResourceHolder.hpp
template <typename Resource, typename Identifier>
class ResourceHolder
{
	public:
		template <typename Parameter>
		void load(Identifier id, const std::string& filename, const Parameter& secondParam);
		Resource& get(Identifier id);
		const Resource& get(Identifier id) const;
	private:
		std::map<Identifier, std::unique_ptr<Resource>>	mResourceMap;
};

typedef ResourceHolder<sf::Texture, Textures::ID> TextureHolder; // Textures 是命名空间, ID 是枚举类型
typedef ResourceHolder<sf::Font, Fonts::ID> FontHolder;

namespace Textures
{
	enum ID
	{
		Entities,
		Jungle,
		TitleScreen,
		Buttons,
		Explosion,
		Particle,
		FinishLine,
	};
}
```

在 `Application` 初始化时候, 调用 `TextureHolder`(也就是`ResourceHolder`) 的 `load` 方法加载素材并存入 `mResourceMap`:

```cpp
mTextures.load(Textures::TitleScreen, "Media/Textures/TitleScreen.png");
```

通过 `mTextures.get(Textures::TitleScreen)` 调用素材.
