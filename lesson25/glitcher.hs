import System.Environment
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC
import System.Random

intToChar :: Int -> Char
intToChar int = toEnum safeInt
  where safeInt = int `mod` 255

intToBC :: Int -> BC.ByteString
intToBC int = BC.pack [intToChar int]

replaceByte :: Int -> Int -> BC.ByteString -> BC.ByteString
replaceByte loc charVal bytes = mconcat [before, newChar, after]
  where (before, rest) = BC.splitAt loc bytes
        after = BC.drop 1 rest
        newChar = intToBC charVal

randomReplaceByte :: BC.ByteString -> IO BC.ByteString
randomReplaceByte bytes = do
  let bytesLength = BC.length bytes
  location <- randomRIO (1, bytesLength)
  charVal <- randomRIO (0, 255)
  return (replaceByte location charVal bytes)

main :: IO ()
main = do
  args <- getArgs
  let fileName = head args
  imageFile <- BC.readFile fileName
  glitched <- randomReplaceByte imageFile
  let glitchedFileName = mconcat ["glitched_", fileName]
  BC.writeFile glitchedFileName glitched
  print "all done"

