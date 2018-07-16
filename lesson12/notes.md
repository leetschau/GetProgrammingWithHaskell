# 12.1 Using type synonyms

> In Haskell, you can create new type synonyms by using the `type` keyword.

# 12.2 Creating new types

Creating a new type can be done with the `data` keyword:
```
data Sex = Male | Female
```

Here `Sex` is a *type constructor*, `Male` and `Female` are *data constructor*.

In this case, the type constructor is the name of the type,
but in later lessons you'll see that type constructors can take arguments.

A *data constructor* is used to create a concrete instance of the type,
and can be used just like values.
