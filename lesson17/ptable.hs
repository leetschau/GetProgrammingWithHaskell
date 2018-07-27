import Data.Semigroup

main = do
  print (mconcat [roll, getCol])
  print (mconcat [rollp, colp])
  print (createTalbe roll rollp)
  print (coin <> spinner)
  print (mconcat [coin, coin, coin])

cartCombine :: (a -> b -> c) -> [a] -> [b] -> [c]
cartCombine func l1 l2 = zipWith func (flatList newL1) cycledL2
  where flatList = foldl (++) []
        nToAdd = length l2
        newL1 = map (take nToAdd . repeat) l1
        cycledL2 = cycle l2

data Events = Events [String]

instance Show Events where
  show (Events evt) = mconcat (map (++ "; ") evt)

combineStr :: String -> String -> String
combineStr "" str = str
combineStr str "" = str
combineStr str1 str2 = mconcat [str1, "-", str2]

instance Semigroup Events where
  (<>) (Events e1) (Events e2) = Events (cartCombine combineStr e1 e2)

eventID :: Events
eventID = Events [""]

instance Monoid Events where
  mempty = eventID
  mappend = (<>)

roll :: Events
roll = Events ["head", "tail"]

getCol :: Events
getCol = Events ["red", "blue"]

data Probs = Probs [Double] deriving (Show)

instance Semigroup Probs where
  (<>) (Probs p1) (Probs p2) = Probs (cartCombine (*) p1 p2)

probID :: Probs
probID = Probs [1]

instance Monoid Probs where
  mempty = probID
  mappend = (<>)

rollp :: Probs
rollp = Probs [0.5, 0.5]

colp :: Probs
colp = Probs [0.3, 0.7]

data PTable = PTable Events Probs

createTalbe :: Events -> Probs -> PTable
createTalbe (Events e) (Probs p) = PTable (Events e) (Probs normalizedProbs)
  where totalProbs = sum p
        normalizedProbs = map ( / totalProbs) p

showPair :: String -> Double -> String
showPair event prob = mconcat [event, "|", show prob, "\n"]

instance Show PTable where
  show (PTable (Events evs) (Probs prs)) = mconcat pairs
    where pairs = zipWith showPair evs prs

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
coin = PTable (Events ["head", "tail"]) (Probs [0.5, 0.5])

spinner :: PTable
spinner = PTable (Events ["red", "blue", "green"])
                 (Probs [0.1, 0.2, 0.7])
