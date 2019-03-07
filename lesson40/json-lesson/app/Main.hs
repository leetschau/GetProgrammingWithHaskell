module Main where
import Data.Aeson
import qualified Data.Text as T
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Lazy.Char8 as BC
import GHC.Generics
import Control.Monad
import Lib

main :: IO ()
main = do
  print sampleErrorMessage
  print nameString
  print decodedName
  jsonData <- B.readFile "data.json"
  -- 若 printResult 不能正确解析数据，则用下面两行代码打印错误信息
  -- let noaaResponse = eitherDecode jsonData :: Either String NOAAResponse
  -- print noaaResponse
  let noaaResponse = decode jsonData :: Maybe NOAAResponse
  let noaaResults = results <$> noaaResponse
  printResult noaaResults
  -- Q40.2
  print intListExample
  print intListString
  let intListEx = decode intListString :: Maybe IntList
  print intListEx

-- quick check 40.2

data Name = Name
  { firstName :: T.Text
  , lastName :: T.Text
  } deriving (Show, Generic)

instance FromJSON Name
instance ToJSON Name

-- quick check 40.3

data Name2 = Name2
  { firstName2 :: T.Text
  , lastName2 :: T.Text
  } deriving (Show)

instance FromJSON Name2 where
  parseJSON (Object v) = 
    Name2 <$> v .: "firstName" <*> v .: "lastName"

-- quick check 40.4

instance ToJSON Name2 where
  toJSON (Name2 firstName2 lastName2) =
    object [ "firstName" .= firstName2
           , "lastName" .= lastName2
           ]

sampleName :: Name2
sampleName = Name2 {firstName2 = "Li", lastName2 = "Chao"}

nameString :: BC.ByteString
nameString = encode sampleName

decodedName :: Maybe Name2
decodedName = decode nameString

-- section 40.1 ~ 40.3

data ErrorMessage = ErrorMessage
                  { message :: T.Text
                  , errorCode :: Int
                  } deriving Show

instance FromJSON ErrorMessage where
  parseJSON (Object v) =
    ErrorMessage <$> v .: "message"
                 <*> v .: "error"

instance ToJSON ErrorMessage where
  toJSON (ErrorMessage message errorCode) =
    object [ "message" .= message
           , "error" .= errorCode
           ]

sampleError :: BC.ByteString
sampleError = "{\"message\": \"oops!\", \"error\": 123}"

sampleErrorMessage :: Maybe ErrorMessage
sampleErrorMessage = decode sampleError

-- section 40.4

data NOAAResult = NOAAResult
               { uid :: T.Text
               , mindate :: T.Text
               , maxdate :: T.Text
               , name :: T.Text
               -- , datacoverage :: Int
               -- 通过第18行输出的调试信息，可知第39课生成的 JSON 文件中，
               -- datacoverage 的数据类型是实数，而书中使用了 Int 类型，导致解析失败
               -- 所以下面改成了 Double 类型，解析成功
               , datacoverage :: Double
               , resultId :: T.Text
               } deriving Show

instance FromJSON NOAAResult where
  parseJSON (Object v) =
    NOAAResult <$> v .: "uid"
               <*> v .: "mindate"
               <*> v .: "maxdate"
               <*> v .: "name"
               <*> v .: "datacoverage"
               <*> v .: "id"

data ResultSet = ResultSet
               { offset :: Int
               , count :: Int
               , limit :: Int
               } deriving (Show, Generic)
instance FromJSON ResultSet

data Metadata = Metadata { resultset :: ResultSet } deriving (Show, Generic)
instance FromJSON Metadata

data NOAAResponse = NOAAResponse
                  { metadata :: Metadata
                  , results :: [NOAAResult]
                  } deriving (Show, Generic)
instance FromJSON NOAAResponse

printResult :: Maybe [NOAAResult] -> IO ()
printResult Nothing = print "error loading data"
printResult (Just results) = forM_ results (print . name)

-- Q40.1

instance ToJSON NOAAResult where
  toJSON (NOAAResult uid mindate maxdate name datacoverage resultId) =
    object [ "uid" .= uid
           , "mindate" .= mindate
           , "maxdate" .= maxdate
           , "name" .= name
           , "datacoverage" .= datacoverage
           , "id" .= resultId
           ]

instance ToJSON ResultSet
instance ToJSON Metadata
instance ToJSON NOAAResponse

-- Q40.2

data IntList = EmptyList
             | Cons Int IntList
             deriving (Show, Generic)

intListExample :: IntList
intListExample = Cons 1 $
                 Cons 2 EmptyList

instance FromJSON IntList
instance ToJSON IntList

intListString :: BC.ByteString
intListString = encode intListExample