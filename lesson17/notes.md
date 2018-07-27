# 17.3.2 Monoid Laws

> Note that the reason `mconcat` uses `foldr` instead of `foldl` is due to the way
> that `foldr` can work with infinite lists, whereas `foldl` will force the evaluation.


# Summary

Lesson 16 研究如何组合不同的类型得到新类型：
使用 *and* 的 product types 和 使用 *or* 的 sum types.
Lesson 17 研究如何组合多个值得到新的值，参与组合的值与返回值必须是相同的类型，
类似于 Python 或者 C++ 的运算符重载，但比它们的抽象层次更高，范围更大。

*solutions.hs* 中的 Events, Probs 使用了 record syntax，
*ptable.hs* 则直接将 list 作为 Events 和 Probs 的数据体。

前者的优点是可以在结构体中增加新的字段值，如 *name*，扩展性更好；
后者的优点是结构更紧凑，在需要提取数据的时候都使用 pattern matching 技术
解决处理函数拿不到类型值中数据的问题（例如如何从 `Probs [0.3, 0.7]` 中提取出
`[0.3, 0.7]`做进行计算）。
