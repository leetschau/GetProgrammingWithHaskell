{-# LANGUAGE OverloadedStrings #-}
import Data.Text (Text)
import qualified Data.Text.IO as TIO
import qualified Data.Text as T

toInts :: Text -> [Int]
toInts = map (read . T.unpack) . tLines

tLines :: Text -> [Text]
tLines text = filter (\x -> T.length x > 0) (T.splitOn "\n" text)

main :: IO ()
main = do
  TIO.putStrLn "Input some digits, one per line:"
  userInput <- TIO.getContents
  let numbers = toInts userInput
  print (sum numbers)

