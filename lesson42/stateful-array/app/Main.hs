module Main where

import Data.Array.Unboxed
import Data.Array.ST
import Control.Monad
import Control.Monad.ST
import Data.STRef
import Lib

main :: IO ()
main = do
  print qcArray
  print (beansInBuckets ! 1)
  print updatedBiB
  print updatedB2
  print updatedB3
  print $ listToUArray [1,2,3]
  print $ listToUArray2 [1,2,3]
  print $ swapST (3,5)
  print $ swapStateless (3,5)
  print $ bubbleSort myData
  -- print $ crossover1 myData 3
  print $ crossover q421 3
  print $ replaceZeros myData2

-- section 42.1
-- quick check 42.1
qcArray :: UArray Int Bool
qcArray = array (0,4) [(1, True), (2, True)]

-- quick check 42.2
beansInBuckets :: UArray Int Int
beansInBuckets = array (0,3) []

updatedBiB :: UArray Int Int
updatedBiB = beansInBuckets // [(1,5),(3,6)]

updatedB2 :: UArray Int Int
updatedB2 = accum (+) updatedBiB $ zip [0..3] $ cycle [2]

-- quick check 42.3
updatedB3 :: UArray Int Int
updatedB3 = accum (*) updatedB2 $ zip [0..3] $ cycle [2]

-- section 42.2

listToSTUArray :: [Int] -> ST s (STUArray s Int Int)  -- what does `s` mean?
listToSTUArray vals = do
  let end = length vals - 1
  myArray <- newArray (0,end) 0
  forM_ [0..end] $ \i -> do
    let val = vals !! i
    writeArray myArray i val
  return myArray

-- section 42.3

listToUArray :: [Int] -> UArray Int Int
listToUArray vals = runSTUArray $ listToSTUArray vals

listToUArray2 :: [Int] -> UArray Int Int
listToUArray2 vals = runSTUArray $ do
  let end = length vals - 1
  myArray <- newArray (0,end) 0
  forM_ [0..end] $ \i -> do
    let val = vals !! i
    writeArray myArray i val
  return myArray

swapST :: (Int,Int) -> (Int,Int)
swapST (x,y) = runST $ do
  x' <- newSTRef x
  y' <- newSTRef y
  writeSTRef x' y
  writeSTRef y' x
  xFinal <- readSTRef x'
  yFinal <- readSTRef y'
  return (xFinal, yFinal)

swapStateless :: (Int,Int) -> (Int,Int)
swapStateless (x,y) = (y,x)

-- section 42.4

myData :: UArray Int Int
myData = listArray (0,5) [7,6,4,8,10,2]

-- quick check 42.4
myData2 :: UArray Int Int
myData2 = listToUArray [7,0,4,8,0,2]

bubbleSort :: UArray Int Int -> UArray Int Int
bubbleSort myArray = runSTUArray $ do
  stArray <- thaw myArray
  let end = (snd . bounds) myArray
  forM_ [1..end] $ \i -> do
    forM_ [0 .. (end - i)] $ \j -> do
      val <- readArray stArray j
      nextVal <- readArray stArray (j + 1)
      let outOfOrder = val > nextVal
      when outOfOrder $ do
        writeArray stArray j nextVal
        writeArray stArray (j + 1) val
  return stArray

-- Q42.1

q421 :: (UArray Int Int, UArray Int Int)
q421 = (array (0,5) [], array (0,5) $ zip [0..5] $ cycle [1])

