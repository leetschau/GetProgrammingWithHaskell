{-# LANGUAGE OverloadedStrings #-}
import qualified Data.ByteString.Char8 as BC

bcInt :: BC.ByteString
bcInt = "6"

byte2Int :: BC.ByteString -> Int
byte2Int = read . BC.unpack

main :: IO ()
main = do
  print (byte2Int bcInt)
