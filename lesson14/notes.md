# 14.4 Default implementation and minimum complete definitions

> To say that `Eq` is a *superclass* of `Ord` means that every instance of
> `Ord` must also be an instance of `Eq`.

```
*Main> :i Eq
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
  {-# MINIMAL (==) | (/=) #-}
        -- Defined in ‘GHC.Classes’
```

Here the *MINIMAL* part in the output of `:i Eq` is the
*Minimum complete definition*.

# QC 14.2

The minimum complete definition of [RealFrac](http://hackage.haskell.org/package/base-4.11.1.0/docs/Prelude.html#t:RealFrac)
is [properFraction](http://hackage.haskell.org/package/base-4.11.1.0/docs/Prelude.html#v:properFraction).

Using `instance` implements unique hehaviour of *Type* defined in *type class*:
```
instance <TypeClassName> <TypeName> where
  <functionName> <args> = <functionBody>
```

while *type class* has a defualt implementation of this function.

For example:
```
data Name = Name (String, String) deriving (Show, Eq)
instance Ord Name where
  compare (Name (f1, l1)) (Name (f2, l2)) = compare (l1, f1) (l2, f2)
```

implements type *Name*'s unique behaviour *compare*,
which is defined in type class *Ord*.
