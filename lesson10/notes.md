# Section 10.1

对象的两种表示方法：

1. Java, Ruby 风格：`obj.method()`;

1. Lisp, R, Haskell 风格：`method obj`.

Python 则兼而有之，既有 `lst.append(item)`，也有 `len(lst)`，
无论哪种书写风格，表达的含义是一样的：
向对象 `obj` 发送一个消息 `method`，改变 `obj` 内部的状态。

## Section 10.1.2

When run the following codes in GHCi:
```
:l cup.hs
coffeeCup = cup 12
getOz coffeeCup
```

The constructor `cup` is a high order function.
It returns another function, which is used as a *object* here.

`coffeeCup` is `\message -> message 12`.
It is used as an object in this context.
Under the hood it's a closure, so actually a *function*.

Next `getOz coffeeCup` is transformed to `(\message -> message 12) (\prop -> prop)`.
Then the `message` is replaced by `(\prop -> prop)` (the *message* is a function, too).
So the return value of `getOz coffeeCup` is `(\prop -> prop) 12`, which is 12.

这一节实现的对象和消息的机制是：计算出消息对对象内部状态的修改，返回一个包含新状态的新对象，
而原来接收消息的对象的内部状态并没有改变。这是以JavaScript为代表的基于原型的面向对象，
而不是以Java为代表的基于类的面向对象，类风格的对象（类的实例）接收消息后改变自身的状态，

# Section 10.3

Lazy evaluation 结合 stateless OOP 就可以实现程序中值的求值不依赖于代码的书写顺序，
以 Listing 10.16 为例，以上机制保证了无论如何修改代码中的几个变量的前后顺序，
执行结果都不变。

但如果是 state OOP + eager evaluation，代码书写（和执行）顺序就会影响对象的内部状态，
在异步场景下这个要求很难达到。
