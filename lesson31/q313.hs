type Pizza = (Double, Double)

areaGivenDiameter :: Double -> Double
areaGivenDiameter size = pi * (size / 2)^2

costPerInch :: Pizza -> Double
costPerInch (size, cost) = cost / areaGivenDiameter size

comparePizzas :: Pizza -> Pizza -> Pizza
comparePizzas p1 p2 = if costP1 < costP2
                      then p1
                      else p2
  where costP1 = costPerInch p1
        costP2 = costPerInch p2

describePizza :: Pizza -> String
describePizza (size, cost) = "The " ++ show size ++ " pizza " ++
                             "is cheaper at " ++ show costSqInch ++
                             " per square inch"
  where costSqInch = costPerInch (size, cost)

monadMain :: Monad m => m Double -> m Double -> m Double -> m Double -> m String
monadMain m1 m2 m3 m4 = do
  size1 <- m1
  cost1 <- m2
  size2 <- m3
  cost2 <- m4
  let pizza1 = (size1, cost1)
  let pizza2 = (size2, cost2)
  let betterPizza = comparePizzas pizza1 pizza2
  return (describePizza betterPizza)

sizeList1 :: [Double]
sizeList1 = [6]

costList1 :: [Double]
costList1 = [34.2]

sizeList2 :: [Double]
sizeList2 = [6, 12]

costList2 :: [Double]
costList2 = [32.3, 64]

main :: IO ()
main = do
  mapM_ putStrLn (monadMain sizeList1 costList1 sizeList2 costList2)
