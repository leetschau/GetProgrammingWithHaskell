import System.Random

randomChar :: IO Char
randomChar = do
  charVal <- randomRIO (0, 255)
  return (toEnum charVal)

main :: IO ()
main = do
  res <- randomChar
  print res
