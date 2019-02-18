boughtLastNight :: [Int]
boughtLastNight = [6, 12]

drunkLastNight :: [Int]
drunkLastNight = [2 * 2]

peopleTonight :: [Int]
peopleTonight = (+ 2) <$> [2, 3]  -- 2 hosts plus 2 or 3 friends
-- 此处表明 <$> 处理 List 时，List 作为 Container 的 map 行为，
-- 和作为 Context 的 nondeterministic 行为，效果是一样的

beersPerPeople :: [Int]
beersPerPeople = [3, 4]

beersNeededTotal :: [Int]
beersNeededTotal = pure (*) <*> peopleTonight <*> beersPerPeople

beersNeedPurchase :: [Int]
beersNeedPurchase = pure (-) <*>
  (pure (-) <*> beersNeededTotal <*> drunkLastNight)
  <*> boughtLastNight

main :: IO ()
main = do
  putStrLn (mconcat ["You need to purchase "
                   ,(show (maximum beersNeedPurchase))
                   ," beers for party tonight."])
