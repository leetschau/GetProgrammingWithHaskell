minOfThree :: (Ord a) => a -> a -> a -> a
minOfThree val1 val2 val3 = min val1 (min val2 val3)

readInt :: IO Int
readInt = read <$> getLine

minOfInts :: IO Int
minOfInts = minOfThree <$> readInt <*> readInt <*> readInt

data User = User
  { name :: String
  , gameId :: Int
  , score :: Int
  } deriving Show

user1 = User "Sue" 1337 9001

serverUsername :: Maybe String
serverUsername = Just "Sue"

serverGameId :: Maybe Int
serverGameId = Just 1337

serverScore :: Maybe Int
serverScore = Just 9001

mbUser1 = User <$> serverUsername <*> serverGameId <*> serverScore

main :: IO ()
main = do
  print (minOfThree <$> Just 10 <*> Just 3 <*> Just 6)  -- QC 28.4
  print user1
  print (mbUser1)
  putStrLn "------\n"
  putStrLn "Enter three numbers:"
  minInt <- minOfInts
  putStrLn (show minInt ++ " is the smallest")
  putStrLn "------\n"
  putStrLn "Enter a username, gameId and score:"
  user <- User <$> getLine <*> readInt <*> readInt
  print user
  putStrLn "------\n"
  print (User <$> Nothing <*> serverGameId <*> serverScore)  -- QC 28.5

