import Data.List
import Data.Int
import qualified Data.Array as A
import Data.Array((!))
import Numeric

fastRead :: String -> Int64
fastRead ('-':s) = case readDec s of [(n, "")] -> -n
fastRead s = case readDec s of [(n, "")] -> n

main = interact solve

solve :: String -> String
solve input = joinedansert
  where
      asnumbers :: [Int64]
      asnumbers = map read $ words input
      n:others = asnumbers
      byfour = splitbyfour others
      solved :: [String]
      solved = map solve' byfour
      joinedansert = intercalate "\n" solved

splitbyfour :: [Int64] -> [(Int64, Int64, Int64, Int64)]
splitbyfour [] = []
splitbyfour (a:b:c:d:xs) = (a, b, c, d):(splitbyfour xs)

solve' :: (Int64, Int64, Int64, Int64) -> String 
solve' (a, b, c, n) -- = show a
    | required > n = "NO"
    | extra `mod` 3 == 0 = "YES"
    | otherwise = "NO"
     where
        maxNum :: Int64
        maxNum = maximum (a:b:c:[])
        required = (maxNum - a) + (maxNum - b) + (maxNum - c)
        extra = n - required
