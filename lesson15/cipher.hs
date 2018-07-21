main = do
  print (decode myOTP (encode myOTP "Learn Haskell"))
  print (prngList 12345 15)
  print (applyStreamCipher 7744 "Learn Haskell")
  print (applyStreamCipher 7744 (applyStreamCipher 7744 "Learn Haskell"))
  print (encode mySC "Learn Haskell")
  print (decode mySC (encode mySC "Learn Haskell"))

data Rot = Rot

rotN :: (Bounded a, Enum a) => Int -> a -> a
rotN alphaSize c = toEnum rotation
  where halfAlphabet = alphaSize `div` 2
        offset = fromEnum c + halfAlphabet
        rotation = offset `mod` alphaSize

rotNdecoder :: (Bounded a, Enum a) => Int -> a -> a
rotNdecoder n c = toEnum rotation
  where halfN = n `div` 2
        offset = if even n
                 then fromEnum c + halfN
                 else 1 + fromEnum c + halfN
        rotation = offset `mod` n

rotEncoder :: String -> String
rotEncoder text = map rotChar text
  where alphaSize = 1 + fromEnum (maxBound :: Char)
        rotChar = rotN alphaSize

rotDecoder :: String -> String
rotDecoder text = map rotCharDecoder text
  where alphaSize = 1 + fromEnum (maxBound :: Char)
        rotCharDecoder = rotNdecoder alphaSize

instance Cipher Rot where
  encode Rot text = rotEncoder text
  decode Rot text = rotDecoder text

xorBool :: Bool -> Bool -> Bool
xorBool value1 value2 = (value1 || value2) && (not (value1 && value2))

xorPair :: (Bool, Bool) -> Bool
xorPair (v1, v2) = xorBool v1 v2

xor :: [Bool] -> [Bool] -> [Bool]
xor list1 list2 = map xorPair (zip list1 list2)

type Bits = [Bool]

maxBits :: Int
maxBits = length (intToBits' maxBound)

intToBits' :: Int -> Bits
intToBits' 0 = [False]
intToBits' 1 = [True]
intToBits' n = if (remainder == 0)
               then False : intToBits' nextVal
               else True : intToBits' nextVal
                 where remainder = n `mod` 2
                       nextVal = n `div` 2

intToBits :: Int -> Bits
intToBits n = leadingFalses ++ reverseBits
  where reverseBits = reverse (intToBits' n)
        misssingBits = maxBits - (length reverseBits)
        leadingFalses = take misssingBits (cycle [False])

charToBits :: Char -> Bits
charToBits char = intToBits (fromEnum char)

bitsToInt :: Bits -> Int
bitsToInt bits = sum (map (\x -> 2 ^ (snd x)) trueLocations)
  where size = length bits
        indices = [size - 1, size - 2 .. 0]
        trueLocations = filter (\x -> fst x == True)
                        (zip bits indices)

bitsToChar :: Bits -> Char
bitsToChar bits = toEnum (bitsToInt bits)


applyOTP' :: String -> String -> [Bits]
applyOTP' pad plaintext = map (\pair ->
                                (fst pair) `xor` (snd pair))
                          (zip padBits plaintextBits)
  where padBits = map charToBits pad
        plaintextBits = map charToBits plaintext

applyOTP :: String -> String -> String
applyOTP pad plaintext = map bitsToChar bitList
  where bitList = applyOTP' pad plaintext

class Cipher a where
  encode :: a -> String -> String
  decode :: a -> String -> String

data OneTimePad = OTP String

instance Cipher OneTimePad where
  encode (OTP pad) text = applyOTP pad text
  decode (OTP pad) text = applyOTP pad text
  
myOTP :: OneTimePad
myOTP = OTP (cycle [minBound .. maxBound])
-- 这里OTP后面的String长度是无限的，根据被加密文本的长度决定自己的长度

prng :: Int -> Int -> Int -> Int -> Int
prng a b maxNumber seed = (a * seed + b) `mod` maxNumber

myPRNG :: Int -> Int
myPRNG = prng 1123 58 100

prngList' :: Int -> [Int] -> [Int]
prngList' 0 lst = lst
prngList' n lst = prngList' (n - 1) (myPRNG (head lst):lst)
{-prngList' :: [Int] -> [Int]-}
{-prngList' (x:xs) = prngList' (myPRNG x : (x:xs))-}

prngList :: Int -> Int -> [Int]
prngList seed n =  prngList' n [seed]

applyStreamCipher' :: Int -> String -> [Bits]
applyStreamCipher' seed plaintext = map (\pair ->
                                          (fst pair) `xor` (snd pair))
                                        (zip seedBits plaintextBits)
  where seedBits = map intToBits (prngList seed (length plaintext))
        plaintextBits = map charToBits plaintext

applyStreamCipher :: Int -> String -> String
applyStreamCipher seed plaintext = map bitsToChar bitList
  where bitList = applyStreamCipher' seed plaintext

data StreamCipher = StreamCipher Int

instance Cipher StreamCipher where
  encode (StreamCipher n) text = applyStreamCipher n text
  decode (StreamCipher n) text = applyStreamCipher n text

mySC :: StreamCipher
mySC = StreamCipher 7744
