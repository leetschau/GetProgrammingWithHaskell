import qualified Data.Map as Map
import Data.List

main = do
  print organCatalog
  print organInventory
  print (showOrgan (Just Heart))
  print cleanList

  print (process Brain)
  print (process Heart)
  print (process Spleen)
  print (process Kidney)
  print (report (process Brain))
  print (report (process Spleen))

  print (processRequest 13 organCatalog)
  print (processRequest 12 organCatalog)

  print availableOrgans
  print (emptyDrawers availableOrgans)

  print (maybeMap show [Just 3, Nothing, Just 2])

data Organ = Heart | Brain | Kidney | Spleen deriving (Show, Eq, Ord)

organs :: [Organ]
organs = [Heart, Spleen, Heart, Brain, Kidney, Brain, Spleen, Heart, Heart]

ids :: [Int]
ids = [2,3,5,9,12,18,25,27,31]

pairs = zip ids organs

organCatalog :: Map.Map Int Organ
organCatalog = Map.fromList pairs

organInventory :: Map.Map Organ Int
organInventory = Map.fromList (zip uniqItems itemCnt)
  where items = Map.elems organCatalog
        uniqItems = nub items
        itemIdx = map (`elemIndices` items) uniqItems
        itemCnt = map length itemIdx

-- 用反斜杠包裹函数名，将一个接收2个参数的前缀函数转换为一个中缀函数，
-- 所以 (`elemIndices` items) 可以看作是 \x -> elemIndices x items 的简写
-- 参考本书 6.3.4 elem 一节。

possibleDrawers :: [Int]
possibleDrawers = [1 .. 50]

getDrawerContents :: [Int] -> Map.Map Int Organ -> [Maybe Organ]
getDrawerContents ids catalog = map getContents ids
  where getContents = \id -> Map.lookup id catalog

availableOrgans :: [Maybe Organ]
availableOrgans = getDrawerContents possibleDrawers organCatalog

countOrgan :: Organ -> [Maybe Organ] -> Int
countOrgan organ available = length (filter
                                            (\x -> x == Just organ)
                                            available)

isSomething :: Maybe Organ -> Bool
isSomething Nothing = False
isSomething (Just _) = True

justTheOrgans :: [Maybe Organ]
justTheOrgans = filter isSomething availableOrgans

showOrgan :: Maybe Organ -> String
showOrgan (Just organ) = show organ
showOrgan Nothing = ""

organList :: [String]
organList = map showOrgan justTheOrgans

cleanList :: String
cleanList = intercalate ", " organList

-- QC 19.2

numOrZero :: Maybe Int -> Int
numOrZero Nothing = 0
numOrZero (Just i) = i

-- 19.4 Back to the lab! More-complex computation with Maybe

data Container = Vat Organ | Cooler Organ | Bag Organ

instance Show Container where
  show (Vat organ) = show organ ++ " in a vat"
  show (Cooler organ) = show organ ++ " in a cooler"
  show (Bag organ) = show organ ++ " in a bag"

data Location = Lab | Kitchen | Bathroom deriving Show

organToContainer :: Organ -> Container
organToContainer Brain = Vat Brain
organToContainer Heart = Cooler Heart
organToContainer organ = Bag organ

placeInLocation :: Container -> (Location, Container)
placeInLocation (Vat a) = (Lab, Vat a)
placeInLocation (Cooler a) = (Lab, Cooler a)
placeInLocation (Bag a) = (Kitchen, Bag a)

process :: Organ -> (Location, Container)
process organ = placeInLocation (organToContainer organ)

report :: (Location, Container) -> String
report (location, container) = show container ++ " in the " ++
                               show location

-- type not match:
-- processRequest :: Int -> Map.Map Int Organ -> String
-- processRequest id catelog = report (process organ)
  -- where organ = Map.lookup id catelog

processAndReport :: (Maybe Organ) -> String
processAndReport (Just organ) = report (process organ)
processAndReport Nothing = "error, id not found"

processRequest :: Int -> Map.Map Int Organ -> String
processRequest id catelog = processAndReport organ
  where organ = Map.lookup id catelog

-- QC 19.3

report193 :: (Maybe (Location, Container)) -> String
report193 (Just (location, container)) = show container ++
                                         " in the " ++
                                         show location
report193 Nothing = "error, report Nothing"

-- Q19.1

emptyDrawers :: [Maybe Organ] -> Int
emptyDrawers someOrgans = length (elemIndices Nothing someOrgans)

-- Q19.2

maybeFunc :: (a -> b) -> Maybe a -> Maybe b
maybeFunc func (Just val) = Just (func val)
maybeFunc func Nothing = Nothing

maybeMap :: (a -> b) -> [Maybe a] -> [Maybe b]
maybeMap func inp = map (maybeFunc func) inp
