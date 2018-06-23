以 C programming 为代表的计算机编程，只是编程活动中的一种类型，
即基于 von Neumann 架构的编程。

与之相对的，是函数式编程，尤其是以 Haskell 为代表的纯函数式编程。

# Section 2.2

Alonzo Church 发明了 lambda calculus （只包含函数和值的运算系统），
Church-Turing 命题证明了 lambda calculus 是图灵完全的。

图灵机：抽象的计算机，不一定是电子的或者数字的，定义了那些问题是可以计算的，
哪些问题是无法通过计算求解的。

使用普通的计算机语言，能解决的问题受到语言本身能力的限制，
函数式语言则使用数学工具编程，只要是数学上可解的问题，函数式编程都能求解。

# Section 2.3

Listing 2.2:

```
$ irb
irb(main):001:0> myList = [1,2,3]
=> [1, 2, 3]
irb(main):002:0> myList.reverse()
=> [3, 2, 1]
irb(main):003:0> myList
=> [1, 2, 3]
irb(main):004:0> newList = myList.reverse()
=> [3, 2, 1]
irb(main):005:0> newList
=> [3, 2, 1]

$ python
Python 3.6.4 |Anaconda, Inc.| (default, Jan 16 2018, 18:10:19) 
>>> myList = [1,2,3]
>>> myList.reverse()
>>> myList
[3, 2, 1]
>>> newList = myList.reverse()
>>> newList
>>> 

$ node
> myList = [1,2,3]
[ 1, 2, 3 ]
> myList.reverse()
[ 3, 2, 1 ]
> myList
[ 3, 2, 1 ]
> newList = myList.reverse()
[ 1, 2, 3 ]
> newList
[ 1, 2, 3 ]
```

Ruby 作为“纯粹的”面向对象语言，其 `reverse()` 函数却呈现出函数式风格：
只返回计算结果，不改变对象状态（`myList` 在调用 `reverse()` 后自身的值没变），
也就是没有副作用（side effect）；

Python 作为“不纯粹的”面向对象语言，其 `reverse()` 函数却表现出了纯粹的面向对象特点：
对象(`myList`）的方法(`reverse()`）只改变对象内部的状态，没有返回值，也就是只有副作用；

JavaScript 则既修改自身状态，又将自身的新状态作为返回值。

## QC 2.1

`++` can't exist in Haskell.
In Haskell *variables* can be bind only once, which means they are all constant.

## QC 2.2

`+=` can't exists here, too.
It bind a new value to the origin variable, which is forbidden in Haskell.

## QC 2.3

```
doublePlusTwo x = doubleX + 2
  where doubleX = x * 2
```

## QC 2.4

x = 6

# Summary

## Q2.1

如果只有 `if` 从句没有 `else`，当判断不成立时，函数没有返回值，
违背了Haskell对函数的定义。

## Q2.2

```
inc x = x + 1
double x = x * 2
square x = x * x
```

## Q2.3

```
myCalc n = if even n
           then n - 2
           else 3 * n + 1
```

