echoVerbaose :: IO ()
echoVerbaose = putStrLn "Enter a String and we'll echo it" >>
  getLine >>= putStrLn

main :: IO ()
main = echoVerbaose
