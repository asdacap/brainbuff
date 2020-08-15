import Data.List
import Data.Int
import qualified Data.Array as A
import Data.Array((!))
import qualified Data.Map as M
import Numeric
import Data.Char

fastRead :: String -> Int64
fastRead ('-':s) = case readDec s of [(n, "")] -> -n
fastRead s = case readDec s of [(n, "")] -> n

main = interact solve

type Input = [Int64]
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
inputParser (_:x:xs) = (readStr x):(inputParser xs)

readStr :: [Char] -> [Int64]
readStr = map (fromIntegral . Data.Char.digitToInt)

outputFormatter :: Output -> String
outputFormatter x = show x

type FoldState = (M.Map Int64 Int64, Int64)

solver :: Input -> Output
solver x = 
    let
        sutr = map (\x -> x - 1) x
        sutr :: [Int64]
        cumul = scanl (+) 0 sutr
        cumul :: [Int64]
        (_, answer) = foldl' folder (M.empty, 0) cumul
    in answer

folder :: FoldState -> Int64 -> FoldState
folder (mm, cur) x 
    | M.null mm = (M.insert x 1 mm, cur)
    | otherwise = (M.insertWith (+) x 1 mm, cur + (M.findWithDefault 0 x mm) )
