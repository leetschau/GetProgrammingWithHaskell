import Test.QuickCheck
import Test.QuickCheck.Instances
import Data.Char(isPunctuation, isSpace, toLower)
import qualified Data.Text as T
import Lib

assert :: Bool -> String -> String -> IO ()
assert test passStatement failStatement = if test
                                          then putStrLn passStatement
                                          else putStrLn failStatement

-- quick check 36.4
prop_reverseInvariant text = (isPalindrome text) == (isPalindrome (T.reverse text))

prop_punctuationInvariant text = preprocess text == preprocess noPuncText
  where noPuncText = T.filter (not . isPunctuation) text

prop_spaceInvariant text = preprocess text == preprocess noSpaceText
  where noSpaceText = T.filter (not . isSpace) text

prop_capitalizationInvariant text = preprocess text == preprocess noCapText
  where noCapText = T.toLower text

main :: IO ()
main = do
  putStrLn "Running tests ..."
  assert (isPalindrome "racecar") "Passed 'racecar'" "failed 'racecar'"
  assert (isPalindrome "racecar!") "Passed 'racecar!'" "failed 'racecar!'"
  assert (isPalindrome ":racecar:") "Passed ':racecar:'" "failed ':racecar:'"  -- quick check 36.3
  assert ((not . isPalindrome) "cat") "Passed 'cat'" "failed 'cat'"
  quickCheck prop_punctuationInvariant
  quickCheckWith stdArgs {maxSuccess = 1000} prop_punctuationInvariant
  quickCheck prop_reverseInvariant   -- quick check 36.5
  -- Q36.1
  quickCheck prop_spaceInvariant
  quickCheck prop_capitalizationInvariant
  putStrLn "done"
