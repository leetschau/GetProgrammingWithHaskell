plus2IO :: Num a => a -> IO a
plus2IO = \x -> return (x + 2)

readNum :: IO Double
readNum = read <$> getLine

main :: IO ()
main = readNum >>= plus2IO >>= print
