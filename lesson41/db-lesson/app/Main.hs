module Main where

import Control.Applicative
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Data.Time
import Lib

data Tool = Tool
  { toolId :: Int
  , name :: String
  , description :: String
  , lastReturned :: Day
  , timeBorrowed :: Int
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
                      ，".) "
                      , name tool
                      , "\n description: "
                      , description tool
                      , "\n last returned: "
                      , show $ lastReturned tool
                      , "\n times borrowed: "
                      , show $ timeBorrowed tool
                      , "\n" ]

main :: IO ()
main = someFunc