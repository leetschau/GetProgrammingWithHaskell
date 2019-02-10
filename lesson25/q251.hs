{-
 - Test with Unicode text: stack runhaskell q251.hs test.txt
 - Test with ASCII text:   stack runhaskell q251.hs q251.hs
 - Compare the result with `wc test.txt
-}

{-# LANGUAGE OverloadedStrings #-}
import System.Environment
import qualified Data.ByteString as B
import qualified Data.Text as T
import qualified Data.Text.IO as TI
import qualified Data.Text.Encoding as E

getCharCounts :: T.Text -> Int
getCharCounts text = T.length text

getByteCounts :: T.Text -> Int
getByteCounts text = B.length bytes
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

{- 这里的解法是先按 UTF-8 编码读取文件，算出字符数，再编码为字节数组，算出字节数；
 - 答案则反过来：先读入字节数组，算出字节数，再以 UTF-8 解码为文本，算出字符数。
 - 前者做了一次解码一次编码，后者只做了一次解码，更高效。
-}
