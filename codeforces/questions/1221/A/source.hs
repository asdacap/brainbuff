import Data.List
import Data.Int
import qualified Data.Array as A
import qualified Data.Map.Strict as MS
import Data.Array((!))
import Numeric

fastRead :: String -> Int64
fastRead ('-':s) = case readDec s of [(n, "")] -> -n
fastRead s = case readDec s of [(n, "")] -> n

main = interact solve

solve input =
  let asnums :: [Int]
      asnums = map read $ words input
      (n:xs) = asnums
      testcases :: [[Int]]
      testcases = parseTestCases xs
      answers = map (boolToString.solve') testcases
      boolToString True = "YES"
      boolToString False = "NO"
  in intercalate "\n" answers

parseTestCases :: [Int] -> [[Int]]
parseTestCases [] = []
parseTestCases (n:xs) =
  let (here,next) = splitAt n xs
  in (here:parseTestCases next)

solve' :: [Int] -> Bool
solve' [] = False
solve' inp =
  let baseSet :: MS.Map Int Int
      baseSet = foldl addToMap (MS.empty) inp
      reducedSet = reduceSet baseSet
      addToMap :: MS.Map Int Int -> Int -> MS.Map Int Int
      addToMap map num = MS.insertWith (+) num 1 map
      answer = case (MS.keys reducedSet) of (2048:_) -> True
                                            _ -> False
  in answer

reduceSet :: MS.Map Int Int -> MS.Map Int Int
reduceSet inp
  | isEmpty = MS.empty
  | lowestKey == 2048 = inp
  | lowestCount == 1 = reduceSet $ MS.delete lowestKey inp
  | otherwise = reduceSet $ MS.delete lowestKey $ MS.insertWith (+) (lowestKey*2) (div lowestCount 2) inp
  where
    isEmpty = (MS.size inp) == 0
    lowestKey :: Int
    (lowestKey:_) = MS.keys inp
    lowestCount :: Int
    Just lowestCount = MS.lookup lowestKey inp
