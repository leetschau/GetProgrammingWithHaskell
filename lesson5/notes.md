# Section 5.3

函数的参数，从左至右，普遍性应该依次递减，以方便 partial application.
例如由于居住地点比姓名普遍性更强（一个地方可以有很多人，一个人不能同时住在很多地方），
所以下面代码中 `addressLetterV2` 比 `addressLetter` 的参数顺序更方便生成
partial applied function:

```
addressLetterV2 location name = addressLetter name location
```
