exampleMaybe :: Maybe Int
exampleMaybe = (pure (*)) <*> ((pure (+)) <*> (pure 2) <*>  (pure 4)) <*> (pure 6)

main :: IO ()
main = do
  putStrLn (mconcat ["exampleMaybe is ", (show exampleMaybe)])

-- Q29.1 和 Q29.2 表明任何使用 fmap 的场合 `func <$> arg1`
-- 都可以使用 `(pure func) <*> arg1` 代替
