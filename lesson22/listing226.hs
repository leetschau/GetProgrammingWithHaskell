import System.Environment
import Control.Monad

main :: IO ()
main = do
  args <- getArgs
  print args
  let linesToRead = if length args > 0
                    then read (head args)
                    else 0 :: Int
  numbers <- replicateM linesToRead getLine
  -- `replicateM n actions` 执行 actions 动作（这里是getLine）n次（这里 n = linesToRead）
  let ints = map read numbers :: [Int]
  print (sum ints)
