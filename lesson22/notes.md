```haskell
runhaskell qc223.hs
"123
456
\n654\n321"
```

qc223.hs 运行后，首先打印出双引号，表示第5行 `print` 语句开始执行，
由于 `rev` 和 `inp` 都是 lazy 的，程序返回 `getContents` 等待用户输入。
键盘输入 `123`，回车，`456`，回车，`Ctrl-D`，然后程序运行完成后退出。

在程序输出文本中，`123`、`456`是键盘输入的回显，不是 `print rev` 的输出，
但它们被包裹在输出文本中，体现了 lazy IO 的特点。

观察上面 `print inp` 和 `print (reverse inp)` 在键入换行符后不同的行为可知，
只有直接对 getContents 指向的变量 (`inp`) 做 `print` 或者 `putStr` 操作，
才有每次回车后响应的特点。
如果对直接变量进行了变换（如 `rev`），则只能在完整输入后才一次性地输出。
