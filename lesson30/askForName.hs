askForName :: IO ()
askForName = putStrLn "What's your name?"

nameStatement :: String -> String
nameStatement name = "Hello " ++ name ++ "!"

helloName :: IO ()
helloName = askForName >>
            getLine >>=
            (\name -> return (nameStatement name)) >>=
            putStrLn

main :: IO ()
main = helloName
