import Data.List
import Data.Int
import qualified Data.Array as A
import Data.Array((!))
import Numeric

fastRead :: String -> Int64
fastRead ('-':s) = case readDec s of [(n, "")] -> -n
fastRead s = case readDec s of [(n, "")] -> n

main = interact solve

type Input = Int64
type Output = Int64

solve :: String -> String
solve input = intercalate "\n" formattedOutputs
    where
        _:xs = words input
        inputs = inputParser xs
        outputs = map solver inputs
        formattedOutputs = map outputFormatter outputs

inputParser :: [String] -> [Input]
inputParser [] = []
inputParser (x:xs) = (fastRead x):(inputParser xs)

outputFormatter :: Output -> String
outputFormatter x = show x

solver :: Input -> Output
solver x = x
