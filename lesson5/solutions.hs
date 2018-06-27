main = do
  print (applyEven square)
  print (applyOdd square)
  print (myExampleUrlBuilderOnBook "1234")
  print (myExampleUrlonBookBuilder "1234")

-- QC 5.1

ifEven myFunc n = if even n
                  then myFunc n
                  else n

square x = x * x

genIfXEven x = (\f -> ifEven f x) 

applyEven = genIfXEven 4
applyOdd = genIfXEven 5

-- QC 5.2

getRequestURL host apiKey resource id = host ++ "/" ++ resource ++ "/" ++ id ++
                                        "?token=" ++ apiKey

genHostRequestBuilder host = (\apiKey resource id ->
                               getRequestURL host apiKey resource id)

exampleUrlBuilder = genHostRequestBuilder "http://example.com"

genApiRequestBuilder hostBuilder apiKey resource = (\id ->
    hostBuilder apiKey resource id)

myExampleUrlBuilderOnBook = genApiRequestBuilder exampleUrlBuilder "1337hAsk3ll" "book"

-- QC 5.3

myExampleUrlonBookBuilder = getRequestURL "http://example.com" "1337hAsk3ll" "book"

-- GC 5.4

subtract2 = flip (-) 2

subtract2v2 x = x - 2

-- Q5.1

inc x = x + 1

double x = x * 2

ifEvenInc = ifEven inc

ifEvenDouble = ifEven double

ifEvenSqure = ifEven square

-- Q5.2

binaryPartialApplication binaryFunction x = (\y -> binaryFunction x y)
