# QC 11.3

```
makeAddress :: Int -> String -> String -> (Int, String, String)
makeAddress number street town = (number, street, town)
```
Now use `:t makeAddress 21`, `:t makeAddress 21 "Street 21"` and
`:t makeAddress 21 "Street 21" "blue town"` to list the returned 
type signatures.

# QC 11.4

Because the first argument (the function) of `map` has no need to keep the types
of return value and the its arguments the same.
For example: in `map show [1,2,3]`, the `show` convert the type from
*Int* to *String*.

# Q11.1

```
*Main> :t filter
filter :: (a -> Bool) -> [a] -> [a]
*Main> :t map
map :: (a -> b) -> [a] -> [b]
```

The returned list of `filter` has the same type of the input list,
while the length of the lists differs.

The returned list of `map` has the (mostly) different type of the input list,
while the length of the lists are the same.


