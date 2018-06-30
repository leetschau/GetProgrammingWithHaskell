main = do
  print (myLength [1, 2, 3])
  print (take 8 (myCircle [1, 2, 3]))
  print (ackermann  3 4)
  print (myReverse [1, 2, 3])
  print (fastFib 1 1 1000)

-- QC 8.1

myLength [] = 0
myLength (x:xs) = 1 + myLength xs

-- Section 8.2

myCircle (x:xs) = x:myCircle (xs ++ [x])

-- Section 8.3

ackermann 0 n = n + 1
ackermann m 0 = ackermann (m - 1) 1
ackermann m n = ackermann (m - 1) (ackermann m (n - 1))

-- Q8.1

myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

-- Q8.2

fastFib a b 0 = b
fastFib a b n = fastFib b (a + b) (n - 1)
