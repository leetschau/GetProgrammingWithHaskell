# Unit 3

Haskell 风格的应用开发流程：

1. 将程序看成是一系列的变换 (transformation).

1. 用类 (type) 表达这一系列的变换；

1. 用函数 (function) 实现变换。

具体实例参考 Unit 3 中 将文档中所有数字提取出来相加 的例子。

# Concepts

* Algibraic data types: any types that can be made by combining other types;

* product types: types combined other types with *and*;

* sum types: types combined other types with *or*;

*product types* 类似于 *组合* 或者 *串联*，
*sum types* 类似于 *并联*。

# QC 16.2

In Haskell: `data SportsCar = SportsCar Car Spoiler`.

In Java:
```
public class SportsCar extends Car {
  Spoiler spoiler;
}
```

# Summary

从本章对 C, Java 和 Haskell 的比较不难看出，
所有这些语言都是通过“自定义类型”实现对业务领域对象的描述，
C 用 *struct* 实现自定义类型，Java 通过定义 *class* 实现自定义类型。

但由于 C, Java 都只有 product types，也就是串联模式，
导致 Java 中的业务对象建模非常笨拙（只有 抽象 -> 特殊 一种方式），
经常由于业务领域出现新概念而修改原有部分，例如一些属性在父类和子类间反复移动。

以 Name 类为例，为了能够处理带中间名和不带中间名两种情况，Java 的实现方法：
```
public class Name {}
public class CommonNmae extends Name {}
public class NameWithMiddle extends Name {}
```

理论上看这样抽象很好，但由于子类必须包含父类所有属性和方法，
导致父类和子类耦合过紧（情况发生变换时，父类和子类必须同时变），
继承同一父类的不同子类间同样耦合过紧。

Haskell 的实现方法：
```
data Name = CommonName FirstName LastName
   | NameWithMiddle FirstName MiddleName LastName
```

可以看到高一级抽象 `Name` 和低一级抽象 `CommonNmae`, `NameWithMiddle`
之间没有必须一致的东西，`CommonNmae` 和 `NameWithMiddle` 之间也没有必须保持一致的东西。
这些特点，加上 sum types，使得 Haskell 的类型定义非常灵活，
开发者能灵活调节不同概念间的耦合强度，所以用 Haskell 描述的业务模型更精确。
