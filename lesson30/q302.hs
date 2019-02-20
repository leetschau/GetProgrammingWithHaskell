allApp :: Monad m => m (a -> b) -> m a -> m b
allApp func mon = func >>= (\f -> (mon >>= (\x -> return (f x))))
-- >>= 操作符的核心功能在于将被封在 Monad 里的值取出来，
-- 变成第二个参数的自变量。
-- 例如上面的代码中，func 和 mon 都是被封在 Monad 里的：
-- func = m f; mon = m x
-- 经过两次嵌套的 >>= 加 lambda，
-- 提取出了 f 和 x，也就是 (a -> b) 和 a
-- 从而得到了 b，再用 return 包装成 m b

example1 :: Maybe Int
example1 = allApp (pure (+ 2)) (Just 3)

example2 :: Maybe Int
example2 = allApp (pure (+ 2)) Nothing

main :: IO ()
main = do
  putStrLn (mconcat ["example1 is ", (show example1)])
  putStrLn (mconcat ["example2 is ", (show example2)])
