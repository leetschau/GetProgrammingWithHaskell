main :: IO ()
main = do
  print ((take 5) <$> (morePresents mybox))  -- Q27.1
  print wrapped  -- Q27.2
  print (fmap unwrap wrapped)

data Box a = Box a deriving Show

instance Functor Box where
  fmap func (Box a) = Box (func a)

morePresents :: Box a -> Box [a]
morePresents box = repeat <$> box

mybox :: Box Int
mybox = Box 1

wrapped = fmap (\x -> Box x) mybox

unwrap :: Box a -> a
unwrap (Box val) = val
