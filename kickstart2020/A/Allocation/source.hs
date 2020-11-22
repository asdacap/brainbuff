import Data.List
import Data.Int
import qualified Data.Array.Unboxed as A
import Data.Array((!))
import Numeric

type IInt = Int64

fastRead :: String -> IInt
fastRead' ('-':s) = case readDec s of [(n, "")] -> -n
fastRead' s = case readDec s of [(n, "")] -> n

fastRead str = answer `seq` answer
    where
        answer = fastRead' str

main = interact solve

type Input = (IInt,[IInt])  -- B,Ai
type Output = IInt

solve :: String -> String
solve input = intercalate "\n" formattedOutputs
    where
        _:xs = words input
        inputs = inputParser xs
        outputs = map solver inputs
        formattedOutputs = map outputFormatter (zip [1..] outputs)

inputParser :: [String] -> [Input]
inputParser = inputParser' . map fastRead

inputParser' :: [IInt] -> [Input]
inputParser' [] = []
inputParser' (n:b:xs) = xs `seq` (b, as):(inputParser' rest)
    where
        (as,rest) = splitAt (fromIntegral n) xs

outputFormatter :: (Int,Output) -> String
outputFormatter (idx,x) = x `seq` "Case #" ++ (show idx) ++ ": " ++ (show x)

solver :: Input -> Output
solver (b,xs) = answer `seq` answer
    where
        (answer, _) = foldl' folder (0,0) sorted 
        sorted = sort xs
        folder :: (IInt, IInt) -> IInt -> (IInt, IInt)
        folder (count, total) x
            | total + x > b = (count, total+x) 
            | otherwise = (count+1, total+x)
