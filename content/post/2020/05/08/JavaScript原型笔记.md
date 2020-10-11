---
title: "JavaScript原型笔记"
date: 2020-05-08T19:53:51+08:00
draft: false
tags:
  - JavaScript
---

## 0. 对象 (object) 和实例 (instance)

- 对象是一个具有多种属性的内容结构
- 实例是类的具象化产品，可以使用 `new` 运算符在原型 (prototype) 基础上新建一个实例

```js
function doSomething() {}
var doSomething = function () {};
var doSomeInstancing = new doSomething();
// new 操作等价于
// var doSomeInstancing = {}; doSomeInstancing.__proto__ = doSomething.prototype
```

- 每一个对象拥有**原型对象**，对象以其原型为模板、从原型继承方法和属性。原型对象也可能拥有原型，并从中继承方法和属性，一层一层、以此类推。这种关系常被称为**原型链 (prototype chain)**

## 1. 原型 (prototype)

- 每个函数都有一个特殊的属性叫作原型（prototype）

```js
function doSomething() {}
console.log(doSomething.prototype);
```

## 2. `__proto__`

- 是每个实例 (instance) 上都有的属性
- 实例的 `__proto__` 就是函数的 `prototype` 属性

```js
function doSomething() {}
doSomething.prototype.foo = "bar"; // add a property onto the prototype
var doSomeInstancing = new doSomething();
doSomeInstancing.__proto__ === doSomething.prototype; // true
// 实例 doSomeInstancing 的 __proto__ 属性就是函数 doSomething 的 prototype 属性
```

## 参考链接

- [MDN JavaScript 对象原型](https://developer.mozilla.org/zh-CN/docs/Learn/JavaScript/Objects/Object_prototypes)
- [说说原型（prototype）、原型链和原型继承](https://zhuanlan.zhihu.com/p/35790971)

```

```
