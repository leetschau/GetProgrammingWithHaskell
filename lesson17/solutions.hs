import Data.Semigroup

main = do
  print (mconcat [Red, Yellow, White])
  print (mconcat [White, Blue, White, Green])
  print (mconcat [roll, getCol])
  print (mconcat [rollp, colp])
  print (createTalbe roll rollp)
  print (coin <> spinner)
  print (mconcat [coin, coin, coin])

-- Q17.1

data Color = Red | Yellow | Blue | Green | Purple | Orange | Brown | White
  deriving (Show, Eq)

instance Semigroup Color where
  (<>) White color = color
  (<>) color White = color
  (<>) a b | a == b = a
           | all (`elem` [Red, Blue, Purple]) [a, b] = Purple
           | all (`elem` [Yellow, Blue, Green]) [a, b] = Green
           | all (`elem` [Red, Yellow, Orange]) [a, b] = Orange
           | otherwise = Brown

instance Monoid Color where
  mempty = White
  mappend = (<>)

-- Q17.2

cartCombine :: (a -> b -> c) -> [a] -> [b] -> [c]
cartCombine func l1 l2 = zipWith func (flatList newL1) cycledL2
  where flatList = foldl (++) []
        nToAdd = length l2
        newL1 = map (take nToAdd . repeat) l1
        cycledL2 = cycle l2

data Events = Events { evts :: [String] }

instance Show Events where
  show evt = mconcat (map (++ "; ") (evts evt))

combineStr :: String -> String -> String
combineStr "" str = str
combineStr str "" = str
combineStr str1 str2 = mconcat [str1, "-", str2]

instance Semigroup Events where
  (<>) e1 e2 = Events (cartCombine combineStr en1 en2)
         where en1 = evts e1
               en2 = evts e2

eventID :: Events
eventID = Events { evts = [""] }

instance Monoid Events where
  mempty = eventID
  mappend = (<>)

roll :: Events
roll = Events {evts = ["head", "tail"]}

getCol :: Events
getCol = Events {evts = ["red", "blue"]}

data Probs = Probs { probs :: [Double] } deriving (Show)

instance Semigroup Probs where
  (<>) p1 p2 = Probs (cartCombine (*) pv1 pv2)
         where pv1 = probs p1
               pv2 = probs p2

probID :: Probs
probID = Probs { probs = [1] }

instance Monoid Probs where
  mempty = probID
  mappend = (<>)

rollp :: Probs
rollp = Probs { probs = [0.5, 0.5] }

colp :: Probs
colp = Probs { probs = [0.3, 0.7] }

data PTable = PTable Events Probs

createTalbe :: Events -> Probs -> PTable
createTalbe events probNos = PTable events normalizedProbs
  where totalProbs = sum (probs probNos)
        normalizedProbs = Probs (map ( / totalProbs) (probs probNos))

showPair :: String -> Double -> String
showPair event prob = mconcat [event, "|", show prob, "\n"]

instance Show PTable where
  show (PTable evs prs) = mconcat pairs
    where pairs = zipWith showPair (evts evs) (probs prs)

instance Semigroup PTable where
  {-(<>) ptable1 (PTable eventID probID) = ptable1-}
  {-(<>) (PTable eventID probID) ptable2 = ptable2-}
  (<>) (PTable e1 p1) (PTable e2 p2) = PTable newEvent newProb
    where newEvent = mconcat [e1, e2]
          newProb = mconcat [p1, p2]

instance Monoid PTable where
  mempty = PTable eventID probID
  mappend = (<>)
  
coin :: PTable
coin = PTable (Events {evts = ["head", "tail"]}) (Probs {probs = [0.5, 0.5]})

spinner :: PTable
spinner = PTable (Events { evts = ["red", "blue", "green"] })
                 (Probs { probs = [0.1, 0.2, 0.7] })
