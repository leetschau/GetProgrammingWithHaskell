main = do
  print (madeBy mybook)
  print (madeBy goldenDays)
  print (madeBy lego)
  print (madeBy pamphlet1)
  print (show (perimeter cir))
  print (show (perimeter sqr))
  print (show (perimeter recg))
  print (show (area cir))
  print (show (area sqr))
  print (show (area recg))


-- QC 16.1

data AuthorName = AuthorName {
     firstName :: String
   , lastName :: String
}

--QC 16.3

type FirstName = String
type MiddleName = String
type LastName = String

data Name = Name FirstName LastName
   | NameWithMiddle FirstName MiddleName LastName
   | TwoInitialsWithLast Char Char LastName
   deriving (Show)

data Author = Author Name deriving (Show)
data Artist = Person Name | Band String deriving (Show)
data Creator = AuthorCreator Author | ArtistCreator Artist deriving (Show)

data Book = Book {
     author :: Creator
   , isbn :: String
   , bookTitle :: String
   , bookYear :: Int
   , bookPrice :: Double
}

data VinylRecord = VinylRecord {
     artist :: Creator
   , recordTitle :: String
   , recordYear :: Int
   , recordPrice :: Double
}

data CollectibleToy = CollectibleToy {
     name :: String
   , description :: String
   , toyPrice :: Double
}

data StoreItem = BookItem Book
               | RecordItem VinylRecord
               | ToyItem CollectibleToy
               | PamphletItem Pamphlet

madeBy :: StoreItem -> String
madeBy (BookItem book) = show (author book)
madeBy (RecordItem vinyl) = show (artist vinyl)
madeBy _ = "unknown"

liChao :: Creator
liChao = AuthorCreator (Author (Name "Chao" "Li"))

mybook :: StoreItem
mybook = BookItem (Book { author = liChao,
                          isbn = "12345678",
                          bookTitle = "Lift is a trip",
                          bookYear = 2030,
                          bookPrice = 80.0
                        })

bsb :: Artist
bsb = Band "Backstreets boys"

goldenDays :: StoreItem
goldenDays = RecordItem (VinylRecord { artist = ArtistCreator bsb,
                                       recordTitle = "Golden old days",
                                       recordYear = 2060,
                                       recordPrice = 30.0
                                     })


lego :: StoreItem
lego = ToyItem (CollectibleToy { name = "lego",
                                 description = "a box of Lego",
                                 toyPrice = 35.30
                               })
                                   
-- Q16.1

data Pamphlet = Pamphlet {
     title :: String
   , desc :: String
   , contact :: String
}

pamphlet1 :: StoreItem
pamphlet1 = PamphletItem (Pamphlet { title = "Coca",
                                     desc = "pamphlet for Coca",
                                     contact = "123-4567"
                                   })

-- Q16.2

data Circle = Circle { xcircle :: Double, ycircle :: Double, radius :: Double }

data Square = Square { xsquare :: Double, ysquare :: Double, side :: Double }

data Rectangle = Rectangle { xrec :: Double, yrec :: Double,
                             width :: Double, height :: Double }

data Shape = ShapeO Circle | ShapeS Square | ShapeR Rectangle

perimeter :: Shape -> Double
perimeter (ShapeO circle) = pi * 2 * (radius circle)
perimeter (ShapeS square) = 4 * (side square)
perimeter (ShapeR rectangle) = 2 * (width rectangle + height rectangle)

area :: Shape -> Double
area (ShapeO circle) = pi * radius circle ^ 2
area (ShapeS square) = side square ^ 2
area (ShapeR rectangle) = width rectangle * height rectangle

cir :: Shape
cir = ShapeO (Circle { xcircle = 3.2, ycircle = 5.6, radius = 2 })

sqr :: Shape
sqr = ShapeS (Square { xsquare = 4.1, ysquare = 9.2, side = 3 })

recg :: Shape
recg = ShapeR (Rectangle { xrec = 9.2, yrec = 7.9, width = 3, height = 4 })
