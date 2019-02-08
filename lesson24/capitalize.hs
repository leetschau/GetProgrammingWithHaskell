-- Q24.2
-- build and run:
-- stack ghc capitalize.hs
-- ./capitalize capitalize.hs

{-# LANGUAGE OverloadedStrings #-}
import System.Environment
import qualified Data.Text as T
import qualified Data.Text.IO as TI

main :: IO ()
main = do
  args <- getArgs
  let fileName = head args
  input <- TI.readFile fileName
  let res = T.toUpper input
  TI.writeFile fileName res

