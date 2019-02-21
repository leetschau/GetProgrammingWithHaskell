import qualified Data.Map as Map

main :: IO ()
main = do
  print (viable cand1)  -- quick check 31.2
  print (assessCandidateMaybe 1)
  print (assessCandidateMaybe 4)
  print (assessCandidateList candidates)
  print (assessCandidateList [])  -- quick check 31.5: yes
  res <- assessCandidateIO
  putStrLn res


-- quick check 31.1

echo :: IO ()
echo = do
  inp <- getLine
  putStrLn inp

-- section 31.2.1

data Grade = F | D | C | B | A deriving (Eq, Ord, Enum, Show, Read)

data Degree = HS | BA | MS | PhD deriving (Eq, Ord, Enum, Show, Read)

data Candidate = Candidate
  { candidateId :: Int
  , codeReview :: Grade
  , cultureFit :: Grade
  , education :: Degree } deriving Show

viable :: Candidate -> Bool
viable candidate = all (== True) tests
-- not work: viable candidate = all tests
  where passedCoding = codeReview candidate > B
        passedCultureFit = cultureFit candidate > C
        educationMin = education candidate >= MS
        tests = [passedCoding, passedCultureFit, educationMin]

cand1 = Candidate 15 A B MS

-- section 31.2.2

readInt :: IO Int
readInt = getLine >>= (return . read)

readGrade :: IO Grade
-- readGrade = getLine >>= (return . read)
readGrade = do  -- quick check 31.3
  gd <- getLine
  let gdInt = read gd
  return gdInt

readDegree :: IO Degree
readDegree = getLine >>= (return . read)

readCandidate :: IO Candidate
readCandidate = do
  putStrLn "Enter ID:"
  cId <- readInt
  putStrLn "Enter code grade:"
  codeGrade <- readGrade
  putStrLn "Enter culture fit grade:"
  cultureFitGrade <- readGrade
  putStrLn "Enter education:"
  degree <- readDegree
  return (Candidate cId codeGrade cultureFitGrade degree)

assessCandidateIO :: IO String
assessCandidateIO = do
  candidate <- readCandidate
  let passed = viable candidate
  let statement = if passed
                  then "passed"
                  else "failed"
  return statement

-- section 31.2.3

candidate1 :: Candidate
candidate1 = Candidate 1 A A BA

candidate2 :: Candidate
candidate2 = Candidate 2 C A PhD

candidate3 :: Candidate
candidate3 = Candidate 3 A B MS

candidateDB :: Map.Map Int Candidate
candidateDB = Map.fromList [(1, candidate1)
                           ,(2, candidate2)
                           ,(3, candidate3)]

assessCandidateMaybe :: Int -> Maybe String
assessCandidateMaybe cId = do
  candidate <- Map.lookup cId candidateDB
  let passed = viable candidate
  let statement = if passed
                  then "passed"
                  else "failed"
  return statement

-- quick check 31.4

betterStatement :: Maybe String -> String
betterStatement (Just stm) = stm
betterStatement Nothing = "error id not found"

-- section 31.2.4

candidates :: [Candidate]
candidates = [candidate1, candidate2, candidate3]

assessCandidateList :: [Candidate] -> [String]
assessCandidateList candidates = do
  candidate <- candidates
  let passed = viable candidate
  let statement = if passed
                  then "passed"
                  else "failed"
  return statement

-- section 31.2.5

assessCandidate :: Monad m => m Candidate -> m String
assessCandidate candidates = do
  candidate <- candidates
  let passed = viable candidate
  let statement = if passed
                  then "passed"
                  else "failed"
  return statement

