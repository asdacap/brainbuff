import Data.List
import Data.Int
import qualified Data.Array as A
import Data.Array((!))
import Numeric

fastRead :: String -> Int64
fastRead ('-':s) = case readDec s of [(n, "")] -> -n
fastRead s = case readDec s of [(n, "")] -> n

main = interact solve

type Input = String
type Output = Int

solve :: String -> String
solve input = intercalate "\n" formattedOutputs
    where
        _:xs = words input
        inputs = inputParser xs
        outputs = map solver inputs
        formattedOutputs = map outputFormatter outputs

inputParser :: [String] -> [Input]
inputParser x = x

outputFormatter :: Output -> String
outputFormatter x = show x

solver :: Input -> Output
solver x =
    let 
        nums = sortBy (\a b -> compare b a) . map length . filter (('1' ==) . head) $ group x 
        folder :: [Int] -> Int
        folder [] = 0
        folder (x:[]) = x 
        folder (x:xx:[]) = x 
        folder (x:xx:xs) = x + folder xs 
    in folder nums


