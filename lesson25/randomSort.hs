import System.Environment
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC
import System.Random

sortSection :: Int -> Int -> BC.ByteString -> BC.ByteString
sortSection start size bytes = mconcat [before, changed, after]
  where (before, rest) = BC.splitAt start bytes
        (target, after) = BC.splitAt size rest
        changed = BC.reverse (BC.sort target)

randomSortSection :: BC.ByteString -> IO BC.ByteString
randomSortSection bytes = do
  let sectionSize = 25
  let bytesLength = BC.length bytes
  start <- randomRIO (0, bytesLength - sectionSize)
  return (sortSection start sectionSize bytes)

main :: IO ()
main = do
  args <- getArgs
  let fileName = head args
  imageFile <- BC.readFile fileName
  glitched <- randomSortSection imageFile
  let glitchedFileName = mconcat ["glitched_", fileName]
  BC.writeFile glitchedFileName glitched
  print "all done"

