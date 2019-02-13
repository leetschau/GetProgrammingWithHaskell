import qualified Data.Map as Map
import System.Environment
import Data.Maybe

-- Run this app with: `runhaskell robots.hs 3`
-- where `3` is the ID of the robotPart in map *partsDB* below
-- Change `3` to `5` and run again to test the invalid ID scenario

main :: IO ()
main = do
  print (Map.lookup 1 htmlPartsDB)

  args <- getArgs
  let partID = read (head args)
  print ((buildCostStr . getCost) partID)

  -- 答案使用 `getLine` 获得参数值，而非通过命令行参数获得参数值，交互性更好

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

type Html = String

renderHtml :: RobotPart -> Html
renderHtml part = mconcat ["<h2>", partName
                          ,"</h2><p><h3>desc</h3>", partDesc
                          ,"</p><p><h3>cost</h3>", partCost
                          ,"</p><p><h3>count</h3>", partCount, "</p>"]
  where partName = name part
        partDesc = description part
        partCost = show (cost part)
        partCount = show (count part)
 
partsDB :: Map.Map Int RobotPart
partsDB = Map.fromList keyVals
  where keys = [1,2,3]
        vals = [leftArm, rightArm, robotHead]
        keyVals = zip keys vals

--insertSnippet :: Maybe Html -> IO ()

partVal :: Maybe RobotPart
partVal = Map.lookup 1 partsDB

partHtml :: Maybe Html
partHtml = renderHtml <$> partVal

allParts :: [RobotPart]
allParts = snd <$> (Map.toList partsDB) -- quick check 27.3
-- Map.toList 将每条记录转换为 (1, RobotPart{1,...}) 这种形式，序号在第一位，
-- 代表具体记录的对象在第二位，所以用 `snd` 取出。

allPartsHtml :: [Html]
allPartsHtml = map renderHtml allParts

htmlPartsDB :: Map.Map Int Html
htmlPartsDB = renderHtml <$> partsDB
-- 这个函数很好的演示了如何通过 fmap 在两个 functor (Map 对象，partsDB 和 htmlPartsDB)
-- 之间用普通函数 (renderHtml) 实现转换

leftArmIO :: IO RobotPart
leftArmIO = return leftArm

htmlSnippet :: IO Html
htmlSnippet = renderHtml <$> leftArmIO

-- Q27.3

getCost :: Int -> Maybe Double
getCost id = cost <$> robotPart
  where robotPart = Map.lookup id partsDB

buildCostStr :: Maybe Double -> String
buildCostStr (Just theCost) = mconcat ["The cost is: ", show theCost]
buildCostStr Nothing = "Invalid ID"

