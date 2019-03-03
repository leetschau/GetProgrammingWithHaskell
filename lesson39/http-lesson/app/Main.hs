module Main where

import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Lazy.Char8 as LC
import Network.HTTP.Simple
import Lib

main :: IO ()
main = do
  response <- httpLBS request
  let status = getResponseStatusCode response
  if status == 200
    then do
      let jsonBody = getResponseBody response
      L.writeFile "data.json" jsonBody
      putStrLn "Saved response to file data.json"
    else do                                    -- Q39.2
      print "Request failed with error:"
      let responseStatus = getResponseStatus response
      print responseStatus

myToken :: BC.ByteString
myToken = "uNNIcbccYFINJIFAiGytFkIDFYCXpUeP"

noaaHost :: BC.ByteString
noaaHost = "www.ncdc.noaa.gov"

apiPath :: BC.ByteString
apiPath = "/cdo-web/api/v2/datasets"

buildRequest :: BC.ByteString -> BC.ByteString -> BC.ByteString -> BC.ByteString -> Request
buildRequest token host method path = setRequestMethod method
                                    $ setRequestHost host
                                    $ setRequestHeader "token" [token]
                                    $ setRequestPath path
                                    $ setRequestSecure True
                                    $ setRequestPort 443
                                    $ defaultRequest

request :: Request
request = buildRequest myToken noaaHost "GET" apiPath

-- Q39.1

buildRequestNOSSL :: BC.ByteString -> BC.ByteString -> BC.ByteString -> BC.ByteString -> Request
buildRequestNOSSL token host method path = setRequestMethod method
                                    $ setRequestHost host
                                    $ setRequestHeader "token" [token]
                                    $ setRequestPath path
                                    $ setRequestSecure False
                                    $ setRequestPort 80
                                    $ defaultRequest