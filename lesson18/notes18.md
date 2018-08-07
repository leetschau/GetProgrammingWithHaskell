# Concepts

## Parameterized types

Like functions, types can also take arguments.
Types take arguments by using type variables in their definitions
(so their arguments are always other types). Types defined using 
Parameters are called Parameterized types. Example:
`data Triple a = Triple a a a deriving Show`.

## Kinds
The *kind of a type* indicates the number of parameters the type takes,
which are expressed using a asterrisk `*`.
Type that take no parameters have a kind of `*`,
types that take 1 parameter have a kind of `* -> *`,
types that take 2 parameters have a kind of `* -> * -> *`,
and so forth.

Use `:k` to print the kind of a type in REPL.

The *Int* type contains no type parameters:
```
Prelude> :k Int
Int :: *
```
The *list* contains only 1 type parameter *a*:
```
Prelude> :i []
data [] a = [] | a : [a]
Prelude> :k []
[] :: * -> *
```

The two-tuple contains 2 type parameters *a* and *b*:
```
Prelude> :i (,)
data (,) a b = (,) a b
Prelude> :k (,)
(,) :: * -> * -> *
```

# QC 18.1

The type of `wrap (Box 'a')` is `Box (Box Char)`.

# QC 18.2

The function argument of `transform` doesn't change argument's type: `a -> a`,
while the function of `map` changes: `a -> b`.

# QC 18.3

It would cause an error, because the type of `("Paper", 12.4)`
is `(String, Double)`, which is different from
the type definition `(String, Int)`.


# QC 18.4

The three-tuple contains 3 type parameters:
```
Prelude> :i (,,)
data (,,) a b c = (,,) a b c
Prelude> :k (,,)
(,,) :: * -> * -> * -> *
```
