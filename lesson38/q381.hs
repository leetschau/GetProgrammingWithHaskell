import Data.Char(isDigit)

parseStr2Int :: String -> Either String Int
parseStr2Int inp = if (all isDigit inp)
                   then Right (read inp)
                   else Left "not a digit"

addStrInts :: String -> String -> Either String Int
addStrInts p1 p2 = (+) <$> parseStr2Int p1 <*> parseStr2Int p2

main :: IO ()
main = do
    print (addStrInts "a" "32")
    print (addStrInts "34" "a")
    print (addStrInts "a" "b")
    print (addStrInts "69" "123")