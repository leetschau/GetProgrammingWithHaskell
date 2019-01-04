import Data.List
import qualified Data.Map as Map
import Data.Semigroup
import Data.Maybe

main = do
  print (fileToTS file1)
  print (ts1 <> ts2)
  print (mconcat [ts1, ts2])
  print (meanTS tsAll)
  print (makeTSCompare max (3, Just 200) (4, Just 10))
  -- 注意函数 max 的类型签名是：Ord a => a -> a -> a，
  -- 与 makeTSCompare 参数 func 的类型 CompareFunc a 吻合
  print (minTS tsAll)
  print (maxTS tsAll)
  print (meanTS (diffTS tsAll))
  print (movingAverageTS tsAll 3)
  print ("Median of list: " ++ (show (median [5,2,3,13,9])))
  print ("tsAll:")
  print tsAll
  print ("Moving median of time series:")
  print (movingMedianTS tsAll 3)

-- 20.1 Your data and the TS data type

file1 :: [(Int, Double)]
file1 = [ (1, 200.1), (2, 199.5), (3, 199.4)
        , (4, 198.9), (5, 199.0), (6, 200.2)
        , (9, 200.3), (10, 201.2), (12, 202.9)]

file2 :: [(Int,Double)]
file2 = [ (11, 201.6), (12, 201.5), (13, 201.5)
        , (14, 203.5), (15, 204.9), (16, 207.1)
        , (18, 210.5), (20, 208.8)]

file3 :: [(Int,Double)]
file3 = [ (10, 201.2), (11, 201.6), (12, 201.5)
        , (13, 201.5), (14, 203.5), (17, 210.5)
        , (24, 215.1), (25, 218.7)]

file4 :: [(Int,Double)]
file4 = [ (26, 219.8), (27, 220.5), (28, 223.8)
        , (29, 222.8), (30, 223.8), (31, 221.7)
        , (32, 222.3), (33, 220.8), (34, 219.4)
        , (35, 220.1), (36, 220.6)]

data TS a = TS [Int] [Maybe a]

createTS :: [Int] -> [a] -> TS a
createTS times values = TS completeTimes extendedValues
  where completeTimes = [minimum times .. maximum times]
        timeValueMap = Map.fromList (zip times values)
        extendedValues = map (\v -> Map.lookup v timeValueMap) completeTimes

fileToTS :: [(Int, a)] -> TS a
fileToTS tvPairs = createTS times values
  where (times, values) = unzip tvPairs

showTVPair :: Show a => Int -> (Maybe a) -> String
showTVPair time (Just value) = mconcat [show time, "|", show value, "\n"]
showTVPair time Nothing = mconcat [show time, "|NA\n"]

instance Show a => Show (TS a) where
  show (TS times values) = mconcat rows
    where rows = zipWith showTVPair times values

ts1 :: TS Double
ts1 = fileToTS file1

ts2 :: TS Double
ts2 = fileToTS file2

ts3 :: TS Double
ts3 = fileToTS file3

ts4 :: TS Double
ts4 = fileToTS file4

-- 20.2 Stiching together TS data with Semigroup and Monoid

insertMaybePair :: Ord k => Map.Map k v -> (k, Maybe v) -> Map.Map k v
insertMaybePair myMap (_, Nothing) = myMap
insertMaybePair myMap (key, (Just value)) = Map.insert key value myMap

combineTS :: TS a -> TS a -> TS a
combineTS (TS [] []) ts2 = ts2
combineTS ts1 (TS [] []) = ts1
combineTS (TS t1 v1) (TS t2 v2) = TS completeTimes combinedValues
  where bothTimes = mconcat [t1, t2]
        completeTimes = [minimum bothTimes .. maximum bothTimes]
        tvMap = foldl insertMaybePair Map.empty (zip t1 v1)
        updatedMap = foldl insertMaybePair tvMap (zip t2 v2)
        combinedValues = map (\v -> Map.lookup v updatedMap) completeTimes

instance Semigroup (TS a) where
  (<>) = combineTS

instance Monoid (TS a) where
  mempty = TS [] []
  mappend = (<>)

tsAll :: TS Double
tsAll = mconcat [ts1, ts2, ts3, ts4]

-- 20.3 Performing calculations on your time series

mean :: (Real a) => [a] -> Double
mean xs = total/count
  where total = (realToFrac . sum) xs
        count = (realToFrac . length) xs

-- 这里 `(Real a) =>` 中的 `Real` 是一个 typeclass，类似于 OOP 中的 interface：
-- 许多 Type 可以实现同一个 typeclass，参考 Learn You a Haskell for Great Good! 中
-- Types and Typeclasses 中的 "Typeclasses 101" 一节。

meanTS :: (Real a) => TS a -> Maybe Double
meanTS (TS _ []) = Nothing
meanTS (TS times values) = if all (== Nothing) values
                           then Nothing
                           else Just avg
  where justVals = filter isJust values
        cleanVals = map fromJust justVals
        avg = mean cleanVals

-- 这是一个典型的顺序计算流程：
-- justVals = f1(values)
-- cleanVals = f2(justVals)
-- avg = f3(cleanVals)
-- returnValue = f4(avg)

type CompareFunc a = a -> a -> a
type TSCompareFunc a = (Int, Maybe a) -> (Int, Maybe a) -> (Int, Maybe a)

makeTSCompare :: Eq a => CompareFunc a -> TSCompareFunc a
makeTSCompare func = newFunc
  where newFunc (i1, Nothing) (i2, Nothing) = (i1, Nothing)
        newFunc (_, Nothing) (i, val) = (i, val)
        newFunc (i, val) (_, Nothing) = (i, val)
        newFunc (i1, Just val1) (i2, Just val2) = if func val1 val2 == val1
                                                  then (i1, Just val1)
                                                  else (i2, Just val2)

-- 根据 makeTSCompare 的类型签名可知 newFunc 的类型是 TSCompareFunc a，
-- 可知 newFunc 的两个参数类型都是 (Int, Maybe a)

compareTS :: Eq a => (a -> a -> a) -> TS a -> Maybe (Int, Maybe a)
compareTS func (TS [] []) = Nothing
compareTS func (TS times values) = if all (== Nothing) values
                                      then Nothing
                                      else Just best
  where pairs = zip times values
        best = foldl (makeTSCompare func) (0, Nothing) pairs

-- L133 中的 TS 是 L38 代码等号左边的 TS，是类型名称
-- L134, 135 中的 TS 是 L38 代码等号右边的 TS，是数据构造器

minTS :: Ord a => TS a -> Maybe (Int, Maybe a)
minTS = compareTS min

maxTS :: Ord a => TS a -> Maybe (Int, Maybe a)
maxTS = compareTS max

-- 20.4 Transforming time series

diffPair :: Num a => Maybe a -> Maybe a -> Maybe a
diffPair Nothing _ = Nothing
diffPair _ Nothing = Nothing
diffPair (Just x) (Just y) = Just (x - y)

diffTS :: Num a => TS a -> TS a
diffTS (TS [] []) = TS [] []
diffTS (TS times values) = TS times (Nothing : diffValues)
  where shiftValues = tail values
        diffValues = zipWith diffPair shiftValues values

meanMaybe :: (Real a) => [Maybe a] -> Maybe Double
meanMaybe vals = if any (== Nothing) vals
                 then Nothing
                 else (Just avg)
  where avg = mean (map fromJust vals)

movingAvg :: (Real a) => [Maybe a] -> Int -> [Maybe Double]
movingAvg [] n = []
movingAvg vals n = if length nextVals == n
                   then meanMaybe nextVals : movingAvg restVals n
                   else []
  where nextVals = take n vals
        restVals = tail vals

movingAverageTS :: (Real a) => TS a -> Int -> TS Double
movingAverageTS (TS [] []) n = TS [] []
movingAverageTS (TS times values) n = TS times smoothedValues
  where ma = movingAvg values n
        nothings = replicate (n `div` 2) Nothing
        smoothedValues = mconcat [nothings, ma, nothings]

-- Summary

median :: (Ord a) => [a] -> a
median inp = sorted !! (div len 2)
  where sorted = sort inp
        len = length inp

medianMaybe :: (Real a) => [Maybe a] -> Maybe a
medianMaybe vals = if any (== Nothing) vals
                   then Nothing
                   else (Just medianVal)
  where medianVal = median (map fromJust vals)

movingMedian :: (Real a) => [Maybe a] -> Int -> [Maybe a]
movingMedian [] n = []
movingMedian vals n = if length nextVals == n
                      then medianMaybe nextVals : movingMedian restVals n
                      else []
  where nextVals = take n vals
        restVals = tail vals

movingMedianTS :: (Real a) => TS a -> Int -> TS a
movingMedianTS (TS [] []) n = TS [] []
movingMedianTS (TS times values) n = TS times smoothedValues
  where ma = movingMedian values n
        nothings = replicate (n `div` 2) Nothing
        smoothedValues = mconcat [nothings, ma, nothings]
