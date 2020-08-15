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
solve input = intercalate "\n" answers
    where
        t:rest = map fastRead $ words input
        t :: Int64
        problems = inputreader rest
        answers = map (answerformat . innersolve) problems

answerformat :: Maybe (Int64,Int64,Int64) -> String
answerformat Nothing = "-1"
answerformat (Just (a, b, c)) = (show a) ++ " " ++ (show b) ++ " " ++ (show c)

inputreader :: [Int64] -> [(Int64, [Int64])]
inputreader [] = []
inputreader (x:xs) = ((x,cur)):(inputreader after)
    where
        (cur,after) = splitAt (fromIntegral x) xs

innersolve :: (Int64,[Int64]) -> Maybe (Int64,Int64,Int64)
innersolve (_,xs) 
    | a+b <= c = Just (1,2,fromIntegral $ length xs)
    | otherwise = Nothing
    where
        a:b:_ = xs
        c = last xs
