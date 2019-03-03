succSafe :: (Enum a, Bounded a, Eq a) => a -> Maybe a
succSafe inp = if (inp == maxBound)
               then Nothing
               else Just (succ inp)

tailSafe :: Show a => [a] -> [a]
tailSafe [] = []
tailSafe (x:xs) = xs

maxLength :: Int
maxLength = 10

lastSafe :: [a] -> Either String a
lastSafe [] = Left "invalid for empty list"
lastSafe (x:xs) = lastWithLn maxLength (x:xs)

lastWithLn :: Int -> [a] -> Either String a
lastWithLn 0 _ = Left "too long to get last"
lastWithLn _ (x:[]) = Right x
lastWithLn n (x:xs) = lastWithLn (n - 1) xs

main :: IO ()
main = do
    print (succSafe (354 :: Int))
    print (succSafe 'x')
    print (succSafe (maxBound :: Int))
    print (tailSafe ([] :: [Int]))
    print (tailSafe [1,2,3])
    print (lastSafe ([] :: [Int]))
    print (lastSafe [1])
    print (lastSafe [1,2,3])
    print (lastSafe [1..30])

-- 当函数定义使用泛化类型 a 时，
-- 运行时（main 函数中）空序列必须指明数据类型，
-- 否则报 Ambiguous type variable ‘a0’ arising from a use of ‘print’ 错误，