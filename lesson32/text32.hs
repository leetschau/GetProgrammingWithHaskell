import Control.Monad
import Data.Char

main :: IO ()
main = do
  print (pairSquares 10)
  print (evensGuard 100)
  print (myFilter even [1..30])
  print nameList
  print nameList2

powerOfTwoAndThree :: Int -> [(Int, Int)]
powerOfTwoAndThree n = do
  value <- [1 .. n]
  let powerOfTwo = 2 ^ value
  let powerOfThree = 3 ^ value
  return (powerOfTwo, powerOfThree)

powerOfTwoAndThree2 :: Int -> [(Int, Int)]
powerOfTwoAndThree2 n = [(powerOfTwo, powerOfThree)
                        | value <- [1 .. n]
                        , let powerOfTwo = 2 ^ value
                        , let powerOfThree = 3 ^ value]

allEvenOdds :: Int -> [(Int, Int)]
allEvenOdds n = do
  evenVal <- [2,4..n]
  oddVal <- [1,3..n]
  return (evenVal, oddVal)

allEvenOdds2 :: Int -> [(Int, Int)]
allEvenOdds2 n = [(evenVal, oddVal) | evenVal <- [2,4..n]
                                    , oddVal <- [1,3..n]]

-- quick check 32.1

pairSquares :: Int -> [(Int, Int)]
pairSquares n = do
  v1 <- [1..n]
  v2 <- [1..n]
  return (v1 ^ 2, v2 ^ 2)

evensGuard :: Int -> [Int]
evensGuard n = do
  value <- [1..n]
  guard (even value)
  -- there should be a space after `guard`, but codes can run without it
  return value

evensGuard2 :: Int -> [Int]
evensGuard2 n = [value | value <- [1..n], even value]

-- quick check 32.2

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter predicate lst = do
  val <- lst
  guard (predicate val)
  return val

-- quick check 32.3

colorList :: [String]
colorList = ["brown", "blue", "pink", "orange"]

nameList :: [String]
nameList = [name | color <- colorList
                 , let name = mconcat ["Mr. "
                                      ,[(toUpper . head) color]
                                      ,tail color]]

nameList2 :: [String]
nameList2 = [ "Mr. " ++ capName | color <- colorList
            , let capName = (\(x:xs) -> toUpper x : xs) color]
-- pattern matching is amazing concise and  beautiful!
