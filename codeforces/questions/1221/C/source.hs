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
  let n :: Int
      (n:xs) = map read $ words input
      queries = bythree xs
      answers = map solve' queries
  in intercalate "\n" $ map show answers

bythree :: [Int] -> [(Int, Int, Int)]
bythree [] = []
bythree (a:b:c:xs) = (a, b, c):(bythree xs)

solve' :: (Int, Int, Int) -> Int
solve' (a, b, c) =
  let base = minimum (a:b:c:[])
      a' = a - base
      b' = b - base
      c' = c - base
      cleft = c == base
  in if cleft then
       base + min (div (a' + b') 3) (min a' b')
    else
       base
