{-# LANGUAGE OverloadedStrings #-}
module MainText where

import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import PalindromeText(isPalindrome)

main :: IO ()
main = do
  TIO.putStrLn "Enter a word and I'll let you know if it's a palindrome!"
  text <- TIO.getLine
  --   TIO.putStrLn "get input:"
  --   TIO.putStrLn text
  let response = if isPalindrome text
                 then "it is!"
                 else "it's not!"
  TIO.putStrLn response

