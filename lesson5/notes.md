# Section 5.1

> When you capture a value inside a lambda function, this is referred to as a closure.

这里被捕捉的值是一个以参数方式传入的函数，这里的参数不是匿名函数自己的参数，
而是返回匿名函数的外层函数的参数。
由于 Haskell 不区分函数和值，可以认为包含外层函数参数的匿名函数就是闭包，
这里的参数包括值（简单值、列表、记录等）和函数。

# Section 5.3

函数的参数，从左至右，普遍性应该依次递减，以方便 partial application.
例如由于居住地点比姓名普遍性更强（一个地方可以有很多人，一个人不能同时住在很多地方），
所以下面代码中 `addressLetterV2` 比 `addressLetter` 的参数顺序更方便生成
partial applied function:

```
addressLetterV2 location name = addressLetter name location
```
