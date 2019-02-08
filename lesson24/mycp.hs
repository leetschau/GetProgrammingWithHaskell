-- Q24.1
-- build and run:
-- stack ghc mycp.hs
-- ./mycp input.txt output.txt

import System.IO
import System.Environment

main :: IO ()
main = do
  args <- getArgs
  let inpFilename = head args
  let outFilename = (head . tail) args
  input <- readFile inpFilename
  writeFile outFilename input
