# Type Class, Functor, Applicative and Monad

Haskell 的 Type 是一组值的集合，可能是有限个（例如布尔值），也可能是无限个（例如整数集），
Type class 是函数（或者叫运算）的集合，例如 `Eq` 包含相等 `(==)` 和不等 `(/=)` 两种运算，
如果一个 Type `a` 的值支持 class `A` 中定义的所有运算，则称 `a` 是 `A` 的一个 *instance*，
`instance A a where` 下面要给出 `A` 中定义的所有函数在 `a` 上实现的方法。

从编程者的角度看，`newtype` 和 `data` 没有区别，但对于编译器来说二者区别很大。
例如对于定义 `data Foo = Foo Int`，`Foo 3` 和 `3` 是两个完全不同类型的值，
而对于 `newtype Bar = Bar Int`，虽然编译时 `Bar 3` 和 `3` 类型不同，
但运行时 `Bar 3` 会被转换为 `3` 参与计算。

P.S.: 要在 ghci 里运行上述代码，需要写成 `data Foo = Foo Int deriving Show`
      才能运行 `Foo 3`.

另外 `data` 可以有多个 constructor，例如 `data Either a b = Left a | Right b`,
`newtype` 只能有一个 constructor.

Monad 的作用是保证内部的表达式被 **顺序执行**，而不是默认的惰性执行。
因为在 Monad 场景中（例如文件 IO），顺序是很重要的。

Monad 是一个 type class，它继承了 Applicative，Applicative 又继承自 functor，
三者之间的关系见 30.3 节，以及 30.1 节的图示。

这种继承关系导致 Monad 具有最广泛的处理 context 中信息的能力，
因为一个 monad 也有 functor 的 `fmap` 和 applicative 的 `<*>` 方法，
所有不纯粹 (pure) 的计算都可以用 monad 解决。

Monad 的 `>>` 方法对应 Applicative 的 `*>` 方法，
Monad 的 `return` 方法对应 Applicative 的 `pure` 方法。
Monad 的 `ap` 方法对应 Applicative 的 `<*>` 方法。
Monad 的 `liftM` 方法对应 Functor 的 `fmap` 方法。
Monad 的 `return` 方法对应 Applicative 的 `pure` 方法。
Monad 的 `return` 方法对应 Applicative 的 `pure` 方法。

## Monad 与 命令式语言

所谓命令式语言，指使用大括号和分号组织的，以带副作用的语句 (statement) 为基本单位的编程语言。

*Notions of Computation* in [Understanding monads] 定义了命令式代码和 monad 代码间互相转换的方法，
以及7种具体 Monad 实现（例如 Maybe, IO, 列表等）在 Haskell 和命令式语言中的实现方法。

## Monad 与 Category Theory

详见 *Monads and Category Theory* in [Understanding monads] 一节。

将 monad 理解成一个箱子，则 monad 核心的三个函数可以看作：

* `fmap`: 对箱子里的值应用函数；

* `return`: 将一个纯粹值装箱；

* `join`: 将嵌套的多个（可能不同类型的）箱子合并成一个箱子。

在此基础上定义 *将多个处理步骤连接在一起*：`m >>= g = join (fmap g m)`。

# Monad Transformers

> The whole point of monad transformers is that *they transform monads into monads*.

Monad transformer 将多个 monad 叠加在一起，形成一个 monad 洋葱，
其 `lift` 和 `run...`（例如这里的 `runMaybeT`）方法是相对的：
前者将 IO 中的操作 *提升* 到 `MaybeT IO` 中，后者则 *运行* stack 外层的 monad，
*取出* 内里包裹的 monad。

P.S.:
[Monad Transformers Step by Step] 给出了一个从纯函数式实现到 monad，再到 monad transformers 的演进实例，
可惜代码在当前的 Haskell 版本下无法运行。

参考文献：

* [Understanding monads]: https://en.wikibooks.org/wiki/Haskell/Understanding_monads

* [Monad transformers]: https://en.wikibooks.org/wiki/Haskell/Monad_transformers

* [Monad Transformers Step by Step]: https://page.mi.fu-berlin.de/scravy/realworldhaskell/materialien/monad-transformers-step-by-step.pdf

* [Simplest non-trivial monad transformer example for “dummies”, IO+Maybe]: https://stackoverflow.com/questions/32579133/simplest-non-trivial-monad-transformer-example-for-dummies-iomaybe<Paste>
