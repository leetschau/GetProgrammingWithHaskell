module Main where

import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Data.Time
import Lib

main :: IO ()
main = do
  print "Enter a command:"
  command <- getLine
  performCommand command

-- section 41.2

data Tool = Tool
  { toolId :: Int
  , name :: String
  , description :: String
  , lastReturned :: Day
  , timesBorrowed :: Int
  }

data User = User
  { userId :: Int
  , userName :: String
  }

instance Show User where
  show user = mconcat [ show $ userId user
                      , ".) "
                      , userName user]

instance Show Tool where
  show tool = mconcat [ show $ toolId tool
                      , ".) "
                      , name tool
                      , "\n description: "
                      , description tool
                      , "\n last returned: "
                      , show $ lastReturned tool
                      , "\n times borrowed: "
                      , show $ timesBorrowed tool
                      , "\n" ]

-- section 41.3

addUser :: String -> IO ()
addUser userName = do
  conn <- open "tools.db"
  execute conn "INSERT INTO users (username) VALUES (?)" (Only userName)
  print "user added"   -- 书中此处缩进错误
  close conn

withConn :: String -> (Connection -> IO ()) -> IO ()
withConn dbName action = do
  conn <- open dbName
  action conn
  close conn

-- quick check 41.2

addUserWithName :: String -> Connection -> IO ()
addUserWithName user conn = do
  execute conn "INSERT INTO users (username) VALUES (?)" (Only user)
  print "user added"

addUserWithConn :: String -> IO ()
addUserWithConn userName = withConn "tools.db" (addUserWithName userName)
-- 书中的实现使用了闭包技术，也就是在匿名函数体中直接引用外部函数的参数
-- 我的使用则借助于 partial 函数技术

checkout :: Int -> Int -> IO ()
checkout userId toolId = withConn "tools.db" $
                         \conn -> do
                           execute conn
                             "INSERT INTO checkedout (user_id,tool_id) VALUES (?,?)"
                             (userId,toolId)

-- section 41.4

instance FromRow User where
  fromRow = User <$> field <*> field

instance FromRow Tool where
  fromRow = Tool <$> field
                 <*> field
                 <*> field
                 <*> field
                 <*> field

printUsers :: IO ()
printUsers = withConn "tools.db" $
             \conn -> do
               resp <- query_ conn "SELECT * FROM users;" :: IO [User]
               mapM_ print resp

printToolQuery :: Query -> IO ()
printToolQuery q = withConn "tools.db" $
                   \conn -> do
                     resp <- query_ conn q :: IO [Tool]
                     mapM_ print resp

printTools :: IO ()
printTools = printToolQuery "SELECT * FROM tools;"

printAvailable :: IO ()
printAvailable = printToolQuery $ mconcat [ "select * from tools "
                                          , "where id not in "
                                          , "(select tool_id from checkedout);"]

printCheckedout :: IO ()
printCheckedout = printToolQuery $
                  mconcat [ "select * from tools "
                          , "where id in "
                          , "(select tool_id from checkedout);"]

-- section 41.5

selectTool :: Connection -> Int -> IO (Maybe Tool)
selectTool conn toolId = do
  resp <- query conn
          "SELECT * FROM tools WHERE id = (?)"
          (Only toolId) :: IO [Tool]
  return $ firstOrNothing resp

firstOrNothing :: [a] -> Maybe a
firstOrNothing [] = Nothing
firstOrNothing (x:xs) = Just x

updateTool :: Tool -> Day -> Tool
updateTool tool date = tool
  { lastReturned = date
  , timesBorrowed = 1 + timesBorrowed tool
  }

updateOrWarn :: Maybe Tool -> IO ()
updateOrWarn Nothing = print "id not found"
updateOrWarn (Just tool) = withConn "tools.db" $
                           \conn -> do
                             let q = mconcat [ "UPDATE TOOLS SET "
                                             , "lastReturned = ?, "
                                             , "timesBorrowed = ? "
                                             , "WHERE ID = ?;"]
                             execute conn q (lastReturned tool
                                            , timesBorrowed tool
                                            , toolId tool)
                             print "tool updated"

updateToolTable :: Int -> IO ()
updateToolTable toolId = withConn "tools.db" $
                         \conn -> do
                           tool <- selectTool conn toolId
                           currentDay <- utctDay <$> getCurrentTime
                           let updatedTool = updateTool <$> tool <*> pure currentDay
                           updateOrWarn updatedTool

-- section 41.6

checkin :: Int -> IO ()
checkin toolId = withConn "tools.db" $
                 \conn -> do
                   execute conn
                     "DELETE FROM checkedout WHERE tool_id = (?);"
                     (Only toolId)

checkinAndUpdate :: Int -> IO ()
checkinAndUpdate toolId = do
  checkin toolId
  updateToolTable toolId

-- section 41.7

promptAndAddUser :: IO ()
promptAndAddUser = do
  print "Enter new user name:"
  userName <- getLine
  addUser userName

promptAndCheckout :: IO ()
promptAndCheckout = do
  print "Enter the id of user"
  userId <- pure read <*> getLine
  print "Enter the id of the tool"
  toolId <- pure read <*> getLine
  checkout userId toolId

promptAndCheckin :: IO ()
promptAndCheckin = do
  print "Enter the ID of the tool"
  toolId <- pure read <*> getLine
  checkinAndUpdate toolId

performCommand :: String -> IO ()
performCommand command
  | command == "users" = printUsers >> main  -- found definition of `>>` at page 381
  | command == "tools" = printTools >> main
  | command == "adduser" = promptAndAddUser >> main
  | command == "addtool" = promptAndAddTool >> main
  | command == "checkout" = promptAndCheckout >> main
  | command == "checkin" = promptAndCheckin >> main
  | command == "in" = printAvailable >> main
  | command == "out" = printCheckedout >> main
  | command == "quit" = print "bye!"
  | otherwise = print "command not found" >> main

-- Q41.1

addTool :: String -> String -> IO ()
addTool toolName desc = do
  conn <- open "tools.db"
  currentDay <- utctDay <$> getCurrentTime
  execute conn
          "INSERT INTO tools (name,description,lastReturned,timesBorrowed) VALUES (?,?,?,?)"
          (toolName,desc,currentDay,0 :: Int)
  print "tool added"   -- 书中此处缩进错误
  close conn

-- Q41.2

promptAndAddTool :: IO ()
promptAndAddTool = do
  print "Enter new tool name:"
  toolName <- getLine
  print "Enter new tool description:"
  toolDesc <- getLine
  addTool toolName toolDesc

