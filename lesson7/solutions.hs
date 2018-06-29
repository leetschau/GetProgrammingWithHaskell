main = do
  print (myTail [2,3,4])
  -- print (myTail [])
  -- why there is a compile error in above line, while you can run `myTail []` in ghci?
  print (myGCD 20 16)
  print (myGCD 16 4)

-- QC 7.3 and Q7.1

myTail [] = []
myTail (_:xs) = xs

-- Q7.2

myGCD a 0 = a
myGCD a b = myGCD b (mod a b)

-- Note: for checking these solutions in GHCi,
-- you have to use `:l solutions.hs` instead of copy/type each line by hand.
-- Because in GHCi the latter definition (`myGCD a b` for example) will OVERWRITE
-- the preceding definition (`myGCD a 0` here).
-- What you got is only the latter definition, resulting in infinite loop.
