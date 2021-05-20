---
title: "Go defer 笔记"
date: 2021-05-20T17:29:45+08:00
draft: false
tags:
  - 日常记录
---

### 例子

可以把 `defer ...` 分成三部分:

1. 调用 `defer`, 计算函数的参数
2. 执行 `defer`, 把函数推入栈
3. **在 return 或者 panic** 之后, 执行栈中的函数

例子:

```golang
func test() (x int) {
  defer func(n int) {
    fmt.Printf("in defer x as parameter: x = %d\n", n)
    fmt.Printf("in defer x after return: x = %d\n", x)
  }(x)

  x = 7
  return 9
}

func main() {
  fmt.Println("test")
  fmt.Printf("in main: x = %d\n", test())
}
```

这例子 `defer` 执行分为三部分:

1. 调用 `defer`, 计算 *n* 的值, *n = x = 0*, 所以作为参数的 x 为 0.
2. 执行 `defer`, 将 `func(n int)(0)` 入栈.
3. 在 `return 9` 之后执行 `func(n int)(0)`, n 在 `fmt.Printf("in defer x as parameter: x = %d\n", n)` 中已经被计算过了, x 在 `fmt.Printf("in defer x after return: x = %d\n", x)` 将被计算得到 9.

例子的输出结果:

```plain
test
in defer x as parameter: x = 0
in defer x after return: x = 9
in main: x = 9
```

### 参考资料

- [Is golang defer statement execute before or after return statement?](https://stackoverflow.com/questions/52718143/is-golang-defer-statement-execute-before-or-after-return-statement)
