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
  let aswords = words input
      n:p:_ = aswords
  in show . solve' $ p


solve' :: String -> Int
solve' = length . reducedStr
  where
    reducedStr :: String -> String
    reducedStr "" = ""
    reducedStr "1" = "1"
    reducedStr "0" = "0"
    reducedStr str
      | reduced == "" = f:[]
      | f == f' = f:reduced
      | otherwise = rest'
      where (f:rest) = str
            reduced = reducedStr rest
            (f':rest') = reduced

