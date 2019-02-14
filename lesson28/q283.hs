import qualified Data.Map as Map
import System.Environment
import Data.Maybe

-- Run this app with: `runhaskell robots.hs 3`
-- where `3` is the ID of the robotPart in map *partsDB* below
-- Change `3` to `5` and run again to test the invalid ID scenario

main :: IO ()
main = do
  putStrLn "Enter 2 IDs [1 ~ 5]:"
  id1 <- getLine
  id2 <- getLine
  let part1 = Map.lookup (read id1) partsDB
  let part2 = Map.lookup (read id2) partsDB
  let res = getCheaper <$> part1 <*> part2
  putStrLn (reportResult res)

data RobotPart = RobotPart
  { name :: String
  , description :: String
  , cost :: Double
  , count :: Int
  } deriving Show

leftArm :: RobotPart
leftArm = RobotPart
  { name = "left arm"
  , description = "left arm for face punching!"
  , cost = 1000.00
  , count = 3
  }
    
rightArm :: RobotPart
rightArm = RobotPart
  { name = "right arm"
  , description = "right arm for kind hand gestures"
  , cost = 1025.00
  , count = 5
  }

robotHead :: RobotPart
robotHead = RobotPart
  { name = "robot head"
  , description = "this head looks mad"
  , cost = 5092.25
  , count = 2
  }

gun :: RobotPart
gun = RobotPart
  { name = "robot gun"
  , description = "a powerful weapon"
  , cost = 12380
  , count = 2
  }

armor :: RobotPart
armor = RobotPart
  { name = "robot armor"
  , description = "best for defence"
  , cost = 2023
  , count = 4
  }

partsDB :: Map.Map Int RobotPart
partsDB = Map.fromList keyVals
  where keys = [1,2,3,4,5]
        vals = [leftArm, rightArm, robotHead, gun, armor]
        keyVals = zip keys vals

getCheaper :: RobotPart -> RobotPart -> RobotPart
getCheaper p1 p2 = if cost1 < cost2
                   then p1
                   else p2
  where cost1 = cost p1
        cost2 = cost p2

reportResult :: Maybe RobotPart -> String
reportResult Nothing = "Invalid ID"
reportResult (Just part) = mconcat ["The cheapter:\n", (show part)]

-- 程序应尽量减少包含副作用（即 IO）的函数，所以这里的实现优于答案的实现
