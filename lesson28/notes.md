In page 348 of section 28.1:

> This is one of the limitations of *Functor*'s `fmap`: it only works on single-argument functions.

这句话很好地解释了为什么 Haskell 会有 *kind* 的概念：
类型系统可以很好地抽象一个参数的类型，例如 `Maybe a` 中的 `a` 可以代表任何类型，
但无法抽象参数的个数，所以添加了 *kind* 来根据参数的个数对函数分类：
`* -> *` 与 `* -> * -> *` 是无法用基本类型系统统一抽象的两类函数。
