main :: IO ()
main = do
    print (addFirstTwo intExample)
    print (addFirstTwo intExampleEmpty)
    print (addFirstTwo intExampleSingle)
    print (addFirstTwo2 intExample)
    print (addFirstTwo2 intExampleEmpty)
    print (addFirstTwo2 intExampleSingle)

eitherHead :: [a] -> Either String a
eitherHead [] = Left "There is no head for empty list"
eitherHead (x:xs) = Right x

intExample :: [Int]
intExample = [1,2,3]

intExampleSingle :: [Int]
intExampleSingle = [1]

intExampleEmpty :: [Int]
intExampleEmpty = []

charExample :: [Char]
charExample = "cat"

charExampleEmpty :: [Char]
charExampleEmpty = ""

addFirstTwo :: [Int] -> Either String Int
addFirstTwo lst = (+) <$> (eitherHead lst) <*> (eitherHead rest)
  where rest = tail lst

addFirstTwo2 :: [Int] -> Either String Int
addFirstTwo2 [] = eitherHead []
addFirstTwo2 (x:xs) = (+ x) <$> (eitherHead xs)