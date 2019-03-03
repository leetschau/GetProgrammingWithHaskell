import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Lazy.Char8 as LC
import Network.HTTP.Simple

main :: IO ()
main = do
  response <- httpLBS "http://news.ycombinator.com"  -- quick check 39.2
  print (getResponseHeaders response)
  print (getResponseHeader "Date" response)