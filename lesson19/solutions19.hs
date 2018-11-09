import qualified Data.Map as Map
import Data.List

main = do
  print organCatalog
  print organInventory

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

-- QC 19.2

numOrZero :: Maybe Int -> Int
numOrZero Nothing = 0
numOrZero (Just i) = i
