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
  let asNum :: Int
      asNum = read input
      numArray = [(i, i2) | i <- [1..asNum], i2 <- [1..asNum]]
      asStrs = map numMapper numArray
      numMapper :: (Int, Int) -> String
      numMapper (i, i2)
        | (mod (i+i2) 2) == 1 && i2 == asNum = "W\n"
        | (mod (i+i2) 2) == 0 && i2 == asNum = "B\n"
        | (mod (i+i2) 2) == 1 = "W"
        | (mod (i+i2) 2) == 0 = "B"
  in concat asStrs
