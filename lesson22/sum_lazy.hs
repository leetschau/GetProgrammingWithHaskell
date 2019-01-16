toInts :: String -> [Int]
toInts = map read . lines  -- this equals to `(map read) . lines`

main :: IO ()
main = do
  userInput <- getContents  -- 此处没有执行读取输入动作，只是约定将用户输入放入userInput里
  {-print "---------"-}
  {-putStr userInput     -- Lazy IO 以换行符（交互式命令行中是回车键）为单位处理文本，-}
                       {--- 每遇到一个换行符代码执行一次，直到文件末尾（交互式命令行中是Ctrl-D）-}
  {-print "---------"-}
  {-mapM_ print userInput -- Lazy IO 变量无状态，可多次使用，Python Iterator 有状态，只能用一次-}
  {-print "---------"-}
  {-print userInput-}
  {-print "---------"-}
  {-putStr userInput-}
  {-print "---------"-}
  let numbers = toInts userInput
  print (sum numbers)
