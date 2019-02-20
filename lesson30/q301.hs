allFmapM :: Monad m => (a -> b) -> m a -> m b
allFmapM func mon = mon >>= (\x -> return (func x))

main :: IO ()
main = do
  print (allFmapM (+ 3) [1,2,3])
  print (allFmapM (+ 3) Nothing)
