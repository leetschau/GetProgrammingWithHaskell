main = do
  print (Chocolate > Vanilla)
  -- returns `False`, so Haskell believe Vanilla is suporior than Chocolate
  print (Chocolate2 > Vanilla2)
  -- returns `True`, which demonstrates the order of the data constructors
  -- determines the comparison result
  print (cycleSuccInt 238)
  print (cycleSuccInt maxBound::Int)
  print (cycleSucc 'a')
  print (cycleSucc maxBound::Word)

-- QC 13.1

aList :: [String]
aList = ["cat", "dog", "mouse"]

-- QC 13.3

data IceCream = Chocolate | Vanilla deriving (Show, Eq, Ord)
data IceCream2 = Vanilla2 | Chocolate2 deriving (Show, Eq, Ord)

-- Q13.3

cycleSuccInt :: Int -> Int
cycleSuccInt n = if n == (maxBound :: Int)
              then minBound::Int
              else succ n

cycleSucc :: (Bounded a, Enum a, Eq a) => a -> a
cycleSucc n = if n == maxBound
              then minBound
              else succ n

-- Here you can't write `maxBound::a`, or the compiler raise an error.
-- Maybe the reason is type variable can't be written in function body.
-- After all the type of `maxBound` can be deduced by the type of `n`
-- and function `==`.
