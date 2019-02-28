module Primes
    ( primes
    , isPrime
    , upperBound
    , primeFactors
    ) where

upperBound :: Int
upperBound = 10000

primes :: [Int]
primes = sieve [2 .. upperBound]

timesOfThePrime :: Int -> Int -> Bool
timesOfThePrime prime num = (mod num prime) == 0

sieve :: [Int] -> [Int]
sieve [] = []
sieve (nextPrime:rest) = nextPrime : (sieve noTimesOfThisPrime)
  where noTimesOfThisPrime = filter (not . (timesOfThePrime nextPrime)) rest

isPrime :: Int -> Maybe Bool
isPrime n | n < 2 = Nothing
          | n >= upperBound = Nothing
          | otherwise = Just (elem n primes)

-- section 37.5

unsafePrimeFactors :: Int -> [Int] -> [Int]
unsafePrimeFactors 0 [] = []
unsafePrimeFactors n [] = []
unsafePrimeFactors n (next:primes) = if n `mod` next == 0
                                     then next:unsafePrimeFactors (n `div` next) (next:primes)
                                     else unsafePrimeFactors n primes

primeFactors :: Int -> Maybe [Int]
primeFactors n | n < 2 = Nothing
               | n >= upperBound = Nothing
               | otherwise = Just (unsafePrimeFactors n primesLessThanN)
  where primesLessThanN = filter (<=  n) primes
  --where primesLessThanN = filter (<= 1 + (ceiling (sqrt (fromIntegral n)))) primes
  -- 一个数的质因子不会大于自己的平方根 仅对合数成立，所以不能用于这里的筛选条件
