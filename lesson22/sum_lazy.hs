main :: IO ()
main = do
  userInput <- getContents
  putStrLn userInput
  mapM_ print userInput
