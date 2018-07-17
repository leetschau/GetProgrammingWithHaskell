# 13.2 Type classes

*Type class* in Haskell are a way of describing groups of types that all behave in the same way.

See the information and must-implemented functions of a type class with:
`:info <type-class-name>` or simply `:i ...`. For example: `:i Num`.

So `:t` is used on a function, while `:i` is used on a type or type class.

# QC 13.2

Why isn't division included in the list of functions needed for a Num?

Because not all implemented type of Num (such as *Integer*) support division.
Note the *division* here is `(/)`, not the `div` supported by Integer.

# 13.4

Define a type class with keyword `class`.

# 13.6

Notice the way to display `minBound` for different types:
`minBound :: Int`, or `minBound :: Char`.

# Q13.1

```
*Main> :i Word
data Word = GHC.Types.W# GHC.Prim.Word#         -- Defined in ‘GHC.Types’
instance Eq Word -- Defined in ‘GHC.Classes’
instance Ord Word -- Defined in ‘GHC.Classes’
instance Show Word -- Defined in ‘GHC.Show’
instance Read Word -- Defined in ‘GHC.Read’
instance Enum Word -- Defined in ‘GHC.Enum’
instance Num Word -- Defined in ‘GHC.Num’
instance Real Word -- Defined in ‘GHC.Real’
instance Bounded Word -- Defined in ‘GHC.Enum’
instance Integral Word -- Defined in ‘GHC.Real’

*Main> minBound::Word
0
*Main> maxBound::Word
18446744073709551615
*Main> minBound::int
-9223372036854775808
*Main> maxBound::Int
9223372036854775807
```

This tells us the relationship between `Word` and `Int` in Haskell,
is the same with `unsigned int` and `signed int` in C.

# Q13.2

`inc` only works for `Int`, while `succ` works for all types implemented `Enum`.
For example: `succ False` returns `True`, `succ 'a'` returns `b`,
`succ 3` returns 4, etc.
