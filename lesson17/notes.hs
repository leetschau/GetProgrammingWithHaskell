import Data.Semigroup

main = do
  print (myAny even [1,2,3])
  print (myAny even [1,5,3])
  print (Green <> Blue <> Yellow)
  print (Green <> (Blue <> Yellow))
  print (Purple <> (Blue <> Yellow))
  print (isElem 3)
  print (isElem 4)
  print (3 <> 4 <> 8)
  print (3 <> (4 <> 8))

-- QC 17.1

myAny :: (a -> Bool) -> [a] -> Bool
myAny testFunc = (foldr (||) False) . (map testFunc)

-- QC 17.2

instance Semigroup Int where
  (<>) x y = div x y
-- you can't use '/' to accomplish this because
-- the type `x / y` is differenct from x and y

-- Listing 17.5

data Color = Red | Yellow | Blue | Green | Purple | Orange | Brown deriving (Show, Eq)

instance Semigroup Color where
  {-(<>) Red Blue = Purple-}
  {-(<>) Blue Red = Purple-}
  {-(<>) Yellow Blue = Green-}
  {-(<>) Blue Yellow = Green-}
  {-(<>) Yellow Red = Orange-}
  {-(<>) Red Yellow = Orange-}
  (<>) a b | a == b = a
           | all (`elem` [Red, Blue, Purple]) [a, b] = Purple
           | all (`elem` [Yellow, Blue, Green]) [a, b] = Green
           | all (`elem` [Red, Yellow, Orange]) [a, b] = Orange
           | otherwise = Brown

-- as you see, the first 6 lines are unnecessary.
-- *all* is a function: `all even [1,2,3]` returns False; `all even [2,4,6]` returns True
-- *elem* is prefix function, `elem` is the corresponding infix function:

isElem :: (Eq a, Num a) => a -> Bool
isElem = (`elem` [1,3,8])

-- QC 17.3

instance Semigroup Integer where
  (<>) a b = a + b

-- Yes, this implementation support associativity

-- <> 表示“组合”，这个概念具体的实现方法由 Semigroup 的 instance 类来定义
-- 例如 Integer 对它的定义是相加， Color 对它的定义是穷举所有颜色的组合结果
-- 所以一个 Monoid 类型的值就表示一个“可以用 mappend 或者 <> 组合的东西”。
