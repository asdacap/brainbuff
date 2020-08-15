import Data.List
import Data.Int
import qualified Data.Array as A
import Data.Array((!))
import Numeric

fastRead :: String -> Int64
fastRead ('-':s) = case readDec s of [(n, "")] -> -n
fastRead s = case readDec s of [(n, "")] -> n

main = interact solve

solve input = intercalate "\n" anserts
  where
    asnumbers = map fastRead $ words input
    _:rest = asnumbers

    parsedInput :: [(Int64, [(Int64, Int64)])]
    parsedInput = unfoldr parsenum' rest

    anserts :: [String]
    anserts = map solvetest parsedInput

parsenum' :: [Int64] -> Maybe ((Int64, [(Int64, Int64)]), [Int64])
parsenum' [] = Nothing
parsenum' (n:xs) = Just ((n, bytwo), nextxs)
  where
    (ours, nextxs) = genericSplitAt (n) xs
    bytwo = unfoldr bytwounfolder ours

    bytwounfolder [] = Nothing
    bytwounfolder (a:b:xs') = Just ((a, b), xs')

solvetest :: (Int64, [(Int64, Int64)]) -> String
solvetest (n, rest) = show n
