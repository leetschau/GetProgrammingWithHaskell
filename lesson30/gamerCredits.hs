import qualified Data.Map as Map

main :: IO ()
main = do
  print (creditsFromId 6)
  print (creditsFromId 23)

type UserName = String
type GamerId = Int
type PlayerCredits = Int

userNameDB :: Map.Map GamerId UserName
userNameDB = Map.fromList [(1, "nYarlathoTep")
                          ,(2, "KINGinYELLOW")
                          ,(3, "dagon1997")
                          ,(4, "rcarter1919")
                          ,(5, "xCTHULHUx")
                          ,(6, "yogSOThoth")]

creditsDB :: Map.Map UserName PlayerCredits
creditsDB = Map.fromList [("nYarlathoTep", 2000)
                         ,("KINGinYELLOW", 15000)
                         ,("dagon1997", 300)
                         ,("rcarter1919", 12)
                         ,("xCTHULHUx", 50000)
                         ,("yogSOThoth", 150000)]  

creditsFromId :: GamerId -> Maybe PlayerCredits
creditsFromId = altLookupCredits .lookupUserName
-- creditsFromId id = altLookupCredits (lookupUserName id)

creditsFromId2 :: GamerId -> Maybe PlayerCredits
creditsFromId2 id = lookupUserName id >>= lookupCredits

creditsFromIdStrange :: GamerId -> Maybe (Maybe PlayerCredits)  -- Quick check 30.1
creditsFromIdStrange id = pure lookupCredits <*> lookupUserName id

lookupUserName :: GamerId -> Maybe UserName
lookupUserName id = Map.lookup id userNameDB

lookupCredits :: UserName -> Maybe PlayerCredits
lookupCredits username = Map.lookup username creditsDB

altLookupCredits :: Maybe UserName -> Maybe PlayerCredits
altLookupCredits Nothing = Nothing
altLookupCredits (Just username) = lookupCredits username


