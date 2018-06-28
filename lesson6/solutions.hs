main = do
  print (take 5 (myRepeat 3))
  print (subseq 2 5 [1 .. 10])
  print (inFirstHalf 1 [1,2,3])
  print (inFirstHalf 3 [1,2,3])

-- Q6.1

myRepeat x = cycle [x]

-- Q6.2

subseq start end list = drop start theTail where theTail = take end list

-- Q6.3

inFirstHalf ele list = elem ele ((\lst -> take (div (length lst) 2) lst) list)
