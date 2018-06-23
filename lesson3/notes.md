# QC 3.2

```
doubleDouble x = (\m -> m * 2) x * 2
```

# Section 3.3

见 *overwrite.hs* 文件，由于同一个函数中不同的 `x` 处于不同的作用域，
所以实际上不存在 overwrite。
`overwrite`函数的求解过程是：

1. 求解最内层的 `let x = 4 in x`，返回4；

1. 求解 `let x = 3 in ...`，带入上一步返回值，变为 `let x = 3 in 4`，返回4；

1. 求解 `let x = 3 in ...`，带入上一步返回值，变为 `let x = 2 in 4`，返回4；

1. 原函数变为：`overwrite x = 4`；

`overwrite2` 函数验证了上述求解过程：即使最内层变量发生了变化，`x = 3`没有被覆盖，
`x` 的值仍然不会被保留。

Quich check 3.3 见 `overwriteLambda` 函数。

# Section 3.4

在下面的库函数定义中：
```
var libraryAdd = function(a,b){
  c = a + b;
  return c;
}
```

正确的写法是 `var c = a + b;`，所以现在的写法 `c` 变成了全局变量。
当库的使用者写出如下代码时：
```
var a = 2;
var b = 3;
var c = a + b;
var d = libraryAdd(10,20);
console.log(c);
```

第3行中的 `c` 是全局变量，所以被第4行的 `libraryAdd` 覆盖。
当使用 IIFE 格式时，`var c = a + b` 中的 `c` 不再是全局变量，
因此 `libraryAdd` 无法覆盖它。

## Figure 3.4

```
*Main> x = 4
*Main> add1 y = y + x
*Main> add1 5
9
*Main> add2 y = (\x -> y + x) 3
*Main> add2 23
26
*Main> add3 y = (\y -> (\x -> y + x) 1 ) 2
*Main> add3 43
3
*Main> add3 98
3
```

`add3` 中，等号右边第2个 `y` 查找离自己最近的作用域，找到等号右边第一个 `y`，而不是等号左边的 `y`，
所以 `(\y -> (\x -> y + x) 1 ) 2` 的值是3，此函数相当于：
`add3 y = 3`.

`add2` 中 `(\x -> y + x)` 应该是一个闭包，因为其中包含了自由变量 `y`。

# Summary

## Q3.1

以 `doubleDouble` 函数为例：
```
doubleDouble = \x -> (\m -> m * 2) x * 2
```

其他改写方式相同，以等号右边为 lambda 表达式主体，
然后左侧加上 `\x ->` （假设函数参数名称为 `x`）。

## Q3.2

错误的答案：`counter x = (\n -> (\m -> x + 1) (x + 1)) x`

正确的答案见 *counter.hs*.
