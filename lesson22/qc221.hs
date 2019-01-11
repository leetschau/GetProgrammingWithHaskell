-- Quick check 22.1

main :: IO ()
main = do
  inp <- mapM (\_ -> getLine) [1..3]
  mapM_ putStrLn inp
