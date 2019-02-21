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

main :: IO ()
main = putStrLn "What is the size of pizza 1" >>
  getLine >>= (\size1 ->
    putStrLn "What is the cost of pizza 1" >>
    getLine >>= (\cost1 -> 
      putStrLn "What is the size of pizza 2" >>
      getLine >>= (\size2 -> 
        putStrLn "What is the cost of pizza 2" >>
        getLine >>= (\cost2 -> return (
        describePizza (
          comparePizzas (read size1, read cost1)
                        (read size2, read cost2)
  )))))) >>= putStrLn

{-
实现 desugar *do-notation* 过程的方法是倒推：

第1步：从最后一句 putStrLn (describePizza betterPizza) 开始：
先不考虑IO，假设四个输入都已得到，则有：

main = putStrLn (
  describePizza (
    comparePizzas (read "8", read "88")
                  (read "6", read "66")
  ))

然后从后向前依次替换掉 4 个字符串即可。

第2步：替换掉 pizza2 的价格。由于不可能从 Context 中得到纯粹值，
只能将原来的 putStrLn str 模式改为 Monad m => m String >>= putStrLn 模式：
main = getLine >>= (\cost2 -> return (
  describePizza (
    comparePizzas (read "8", read "88")
                  (read "6", read cost2)
  ))) >>=  putStrLn

第3步：增加提示语：

main = putStrLn "What is the cost of pizza 2" >>
  getLine >>= (\cost2 -> return (
    describePizza (
      comparePizzas (read "8", read "88")
                    (read "6", read cost2)
  ))) >>=  putStrLn

第4步：增加第二个参数和提示语：

main = putStrLn "What is the size of pizza 2" >>
  getLine >>= (\size2 ->
    putStrLn "What is the cost of pizza 2" >>
    getLine >>= (\cost2 -> return (
      describePizza (
        comparePizzas (read "8", read "88")
                      (read "6", read cost2)
  )))) >>=  putStrLn

用同样的方法添加第2个和第1个参数即实现了完整的 desugar 过程。
-}
