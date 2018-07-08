-- QC 11.1

halve :: Int -> Int
halve x = div x 2

-- QC 11.2

printDouble :: Int -> String
printDouble x = show (2 * x)

-- Q11.2

{-
myHead :: [a] -> a
myHead (x:xs) = x
myHead :: [] -> []
myHead [] = []
can't write a tail function on empty list, for empty list and a value
can't be combine in one type signature
-}

myTail :: [a] -> [a]
myTail (x:xs) = xs
myTail [] = []

-- Q11.3

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f init [] = init
myFoldl f init (x:xs) = myFoldl f newInit xs
  where newInit = f init x
