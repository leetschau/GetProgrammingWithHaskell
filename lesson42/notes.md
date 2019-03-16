第548页第一段，结合 `aLargeList` 给出了 `thunk` 的定义：
在惰性执行过程中，一个 action 触发的一系列计算过程。

> To use the UArray type, you’ll import D`Data.Array.Unboxed`
> to the top of your module. Additionally, if using stack,
> you need to add `array` to the list of *dependencies*.

注意书中是 *build-depends*，与目前的 stack 语法不符，
故改为 `dependencies*.

Q42.1:
题目明确说返回值是 *new pair of arrays*，
即交换尾部后的两个数组，但 Appendix 中的答案只返回了一个数组，
与题目要求不符。
