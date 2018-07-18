main = do
  print (roll F4)
  print (roll F1)

-- QC 14.1

data SixSidedDie = S1 | S2 | S3 | S4 | S5 | S6
instance Show SixSidedDie where
  show S1 = "1"
  show S2 = "2"
  show S3 = "3"
  show S4 = "4"
  show S5 = "5"
  show S6 = "6"

-- QC 14.4

data SixSidedDie2 = SI | SII | SIII | SIV | SV | SVI deriving (Eq, Ord, Show)

-- If you want define own definitions of `show`, you must not add `deriving Show`.
-- Or there will be a *duplicate definition* error.

-- Q14.1

data Number = One | Two | Three deriving (Enum)

instance Eq Number where
  (==) n1 n2 = (fromEnum n1) == (fromEnum n2)

instance Ord Number where
  compare n1 n2 = compare n1 n2

-- Using default implementation instead of manual implementation above:
data Number2 = N1 | N2 | N3 deriving (Enum, Eq, Ord)
-- Here you must add `Eq` in *deriving* list, or there will be a *No instance* error.
-- Does this mean when deriving a type class, you must also deriving all its parents?

-- Q14.2

class (Eq a, Enum a) => Die a where -- build inheritance between type classes
  roll :: a -> Int

data FiveSidedDie = F1 | F2 | F3 | F4 | F5 deriving (Show, Eq, Enum)

instance Die FiveSidedDie where   -- make type *FiveSidedDie* an instance of type class *Die*
  roll F1 = fromEnum F1
  roll F2 = fromEnum F2
  roll F3 = fromEnum F3
  roll F4 = fromEnum F4
  roll F5 = fromEnum F5


-- This exercise demonstrates:
-- how to define a type with *data* keyword;
-- how to define a type class with *class* keyword;
-- how to define inheritance between type classes;
-- how to let a type using a type class's default implementation with *deriving* keyword
-- how to let a type implementing a type class's method with *instance* keyword
