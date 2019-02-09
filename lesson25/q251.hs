{-
 - Test with Unicode text: stack runhaskell q251.hs test.txt
 - Test with ASCII text:   stack runhaskell q251.hs q251.hs
 - Compare the result with `wc test.txt
-}

{-# LANGUAGE OverloadedStrings #-}
import System.Environment
import qualified Data.ByteString.Char8 as BC
import qualified Data.Text as T
import qualified Data.Text.IO as TI
import qualified Data.Text.Encoding as E

getCharCounts :: T.Text -> Int
getCharCounts text = T.length text

getByteCounts :: T.Text -> Int
getByteCounts text = BC.length bytes
  where bytes = E.encodeUtf8 text

getCharByteCounts :: T.Text -> String
getCharByteCounts text = mconcat ["Character counts: "
                                 , (show (getCharCounts text))
                                 ,"; Byte counts: "
                                 , (show (getByteCounts text))]

main :: IO ()
main = do
  args <- getArgs
  let fileName = head args
  input <- TI.readFile fileName
  print (getCharByteCounts input)
