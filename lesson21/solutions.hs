import qualified Data.Map as Map
import Data.Maybe

main :: IO ()
main = do
  let res = fromJust maybeMain
  putStrLn res
  putStrLn "Which rank in Fib do you want?"
  no <- getLine
  putStrLn ("The " ++ (show no) ++  "th of Fib is " ++
    (show (calcFib no)))

-- Q21.1

personsMap :: Map.Map Int String
personsMap = Map.fromList [(1, "Tom"), (2, "Jerry")]

helloPerson :: String -> String
helloPerson name = "Hello" ++ " " ++ name ++ "!"

maybeMain :: Maybe String
maybeMain = do
  name1 <- Map.lookup 1 personsMap
  name2 <- Map.lookup 2 personsMap
  return (helloPerson name1)

-- Q21.2

fastFib :: Int -> Int -> Int -> Int
fastFib a b 0 = b
fastFib a b n = fastFib b (a + b) (n - 1)

calcFib :: String -> Int
calcFib n = fastFib 0 1 (read n :: Int)
