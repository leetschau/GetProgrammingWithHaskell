module Lib
    ( crossover
    -- , crossover1
    , replaceZeros
    ) where

import Data.Array.Unboxed
import Data.Array.ST
import Control.Monad

flipByCutoff :: Int -> Int -> Int -> Int
flipByCutoff elem cutoff index = if (cutoff > index)
                                 then elem
                                 else (1 - elem)

crossover1 :: UArray Int Int -> Int -> UArray Int Int
crossover1 arr cutoff = runSTUArray $ do
  stA <- thaw arr
  let end = (snd . bounds) arr
  forM_ [0..end] $ \i -> do
    valA <- readArray stA i
    writeArray stA i (flipByCutoff valA cutoff i)
  return stA

crossover :: (UArray Int Int, UArray Int Int) -> Int -> (UArray Int Int, UArray Int Int)
crossover (arrA, arrB) cutoff = (crossover1 arrA cutoff
                                ,crossover1 arrB cutoff)

replaceZeros :: UArray Int Int -> UArray Int Int
replaceZeros inp = runSTUArray $ do
  stArr <- thaw inp
  let end = (snd . bounds) inp
  forM_ [0..end] $ \i -> do
    val <- readArray stArr i
    writeArray stArr i (if val == 0
                        then -1
                        else val)
  return stArr
