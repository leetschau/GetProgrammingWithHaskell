import Data.Char

inp = [1, 2, 3, 4]
inp2 = [1, 2, 4]

inpStr = "A man a plan a canal Panama"

main = do
  print (remove even inp)
  print (myProduct inp)
  print (myFoldl (+) 3 inp)
  print (myElemR 3 inp)
  print (myElem 3 inp)
  print (myElemR 3 inp2)
  print (myElem 3 inp2)
  print (isPalindrome inpStr)
  print (harmonic 5)
  print (harmonic0 5)
  print (harmonic1 5)

-- QC 9.1

remove test [] = []
remove test (x:xs) = if test x
                     then remove test xs
                     else x:remove test xs

-- QC 9.2

myProduct lst = foldl (*) 1 lst

-- Listing 9.5

myFoldl f init [] = init
myFoldl f init (x:xs) = myFoldl f newInit xs
  where newInit = f init x

-- Q9.1

myElemR k [] = False
myElemR k (x:xs) = (k == x) || myElem k xs

myElem k lst = length (filter (k ==) lst) > 0

-- Q9.2

isPalindrome str = reverse chars == chars
  where chars = filter (' ' /=) (map toLower str)

-- Q9.3

harmonic n = sum (take n (map (1 /) [1..]))

harmonic1 n = foldl (+) 0 series
  where series = take n (map (1 /) [1..])

harmonic0 n = sum (take n seriesValues)
  where seriesPairs = zip (cycle [1.0]) [1.0, 2.0 ..]
        seriesValues = map (\pair -> (fst pair)/(snd pair)) seriesPairs
