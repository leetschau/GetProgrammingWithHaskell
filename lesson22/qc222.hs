import Control.Monad

-- Quick check 22.2

myReplicateM :: Monad m => Int -> m a -> m [a]
myReplicateM n action = mapM (\_ -> action) (take n (repeat 0))

main :: IO [()]
main = do
  myReplicateM 3 (print 5)
