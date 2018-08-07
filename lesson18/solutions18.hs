import qualified Data.Map as Map
import Data.List

main = do
  print (boxMap show [Box 1, Box 2, Box 3])
  print (boxMap2 show (Box 1))
  print (tripleMap show (Triple 1 2 3))
  print organCatalog
  print organInventory

--Q18.1

data Box a = Box a deriving (Show)

wrap :: a -> Box a
wrap x = Box x

unwrap :: Box a -> a
unwrap (Box x) = x

boxMap :: (a -> b) -> [Box a] -> [Box b]
boxMap func x = map wrap (map func (map unwrap x))

boxMap2 :: (a -> b) -> Box a -> Box b
boxMap2 func (Box x) = Box (func x)

data Triple a = Triple a a a deriving Show

tripleMap :: (a -> b) -> Triple a -> Triple b
tripleMap func (Triple x y z) = Triple (func x) (func y) (func z)

-- Q18.2

data Organ = Heart | Brain | Kidney | Spleen deriving (Show, Eq, Ord)

organs :: [Organ]
organs = [Heart, Spleen, Heart, Brain, Kidney, Brain, Spleen, Heart, Heart]

ids :: [Int]
ids = [2,3,5,9,12,18,25,27, 31]

pairs = zip ids organs

organCatalog :: Map.Map Int Organ
organCatalog = Map.fromList pairs

organInventory :: Map.Map Organ Int
organInventory = Map.fromList (zip uniqItems itemCnt)
  where items = Map.elems organCatalog
        uniqItems = nub items
        itemIdx = map (`elemIndices` items) uniqItems
        itemCnt = map length itemIdx
