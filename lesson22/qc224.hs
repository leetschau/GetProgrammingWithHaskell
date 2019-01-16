toInts :: String -> [Int]
toInts = map read . lines

sumSquares :: [Int] -> Int
sumSquares inp = sum (map (\x -> x * x) inp)

main :: IO ()
main = do
  userInput <- getContents
  let numbers = toInts userInput
  print (sumSquares numbers)

-- 与答案中的实现相比，我的实现更符合“最大限度抽取出 pure 部分”的原则
