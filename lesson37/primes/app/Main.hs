module Main where

import Primes

ansStatement :: Maybe Bool -> String
ansStatement Nothing = "Sorry, this number is not a valid candidate for primality testing"
ansStatement (Just True) = "It is a prime!"
ansStatement (Just False) = "It is not a prime!"

main :: IO ()
main = do
  putStrLn "Enter a number to check if it's prime:"
  inp <- getLine
  putStrLn (ansStatement (isPrime (read inp)))

