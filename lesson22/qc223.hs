main :: IO ()
main = do
  inp <- getContents
  let rev = reverse inp
  -- print inp
  -- print (reverse inp)
  print rev
