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

-- QC 19.2

numOrZero :: Maybe Int -> Int
numOrZero Nothing = 0
numOrZero (Just i) = i
