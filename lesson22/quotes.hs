showQuotes :: [String] -> [String]
showQuotes ("1":xs) = "道法自然":(showQuotes xs)
showQuotes ("2":xs) = "实事求是":(showQuotes xs)
showQuotes ("3":xs) = "相濡以沫，不如相忘于江湖":(showQuotes xs)
showQuotes ("4":xs) = "大道至简，大音希声":(showQuotes xs)
showQuotes ("5":xs) = "c'est la vie":(showQuotes xs)
showQuotes ("n":xs) = []

{-continueOrNot :: String -> IO ()-}
{-continueOrNot "n" = putStrLn "bye"-}
{-continueOrNot line = do-}
  {-putStrLn "Please input a number between 1 ~ 5:"-}
  {-putStrLn (showQuotes line)-}

main :: IO ()
main = do
  putStrLn "Please input a number between 1 ~ 5:"
  userInput <- getContents
  let inp = lines userInput
  mapM_ putStrLn (showQuotes inp)
  {-mapM_ continueOrNot inp-}

-- 实现“根据用户输入决定继续处理新输入还是退出”的关键在于：
-- `mapM_ putStrLn` 后函数的返回值，如果返回空列表，则程序结束
-- 否则继续处理下一个用户输入。
-- 这里第二个关键技巧是用模式匹配和递归调用实现循环处理。

