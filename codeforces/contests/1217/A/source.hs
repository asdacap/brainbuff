import Data.List
import Data.Int
import qualified Data.Array as A
import Data.Array((!))
import Numeric

fastRead :: String -> Int64
fastRead ('-':s) = case readDec s of [(n, "")] -> -n
fastRead s = case readDec s of [(n, "")] -> n

main = interact solve

solve input = 
  let asNums :: [Int]
      asNums = map read $ words input
      idx:xs = asNums
      inp = asthree xs
      mapped = map solve' inp
  in intercalate "\n" $ map show mapped

asthree :: [Int] -> [(Int, Int, Int)]
asthree [] = [] 
asthree (a:b:c:xs) = (a, b, c):(asthree xs)


solve' :: (Int, Int, Int) -> Int
solve' (str, int, exp)
  | exp <= 0 && str > int = 1
  | left <= 0 && str <= int = 0
  | otherwise = max 0 (exp - adds + 1)
  -- | str >= int = min (div (base' + exp + 1) 2) exp
  -- | otherwise = div' left 2
  where
      base = min str int
      str' = str - base
      int' = int - base
      base' = max str' int'
      left = exp - base'
      adds = max 0 (div (exp + int - str + 2) 2) 

div' it n2 = (div it n2) + (mod it n2)
