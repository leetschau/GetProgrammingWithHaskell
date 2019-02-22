-- Q32.1 & Q32.2

monthDays :: [Int]
monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

calendar :: [[Int]]
calendar = [[1..last] | last <- monthDays]

calendarDo :: [[Int]]
calendarDo = do
  last <- monthDays
  return [1..last]

calendarMonad :: [[Int]]
calendarMonad = monthDays >>= (\x -> return [1..x])

dates :: [Int] -> [Int]
dates ends = [date | end <- ends, date <- [1..end]]

datesDo :: [Int] -> [Int]
datesDo ends = do
  end <- ends
  date <- [1..end]
  return date

datesMonad :: [Int] -> [Int]
datesMonad ends = ends >>=
  (\end ->               -- alpha
    ([1..end] >>= (\date -> return date)))

-- alpha 行中，箭头后面没有 return，是实现 flatMap 的关键，
-- 如果加上 return 就变成了与上面实现类似的双层 List 结构
-- 这里之所以能不写 return 的原因是内层返回值已经是 Monad 对象了

main :: IO ()
main = do
  print calendar
  print calendarDo
  print calendarMonad
  print (dates monthDays)
  print (datesMonad monthDays)
