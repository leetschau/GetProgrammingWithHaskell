solveEqu :: [String] -> String
solveEqu [x, "+", y] = show ((read x :: Int) + (read y :: Int))
solveEqu [x, "*", y] = show ((read x :: Int) * (read y :: Int))
solveEqu [_] = show 0

showResult :: [String] -> [String]
showResult inp = map solveEqu aEq
  where aEq = map words inp

main :: IO ()
main = do
  userInput <- getContents
  mapM_ putStrLn (showResult (lines userInput))
