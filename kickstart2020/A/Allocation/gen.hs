import Data.List
import Data.Int
import System.Random

import qualified Data.Array.Unboxed as A
import Data.Array((!))
import Numeric

fastRead :: String -> Int64
fastRead ('-':s) = case readDec s of [(n, "")] -> -n
fastRead s = case readDec s of [(n, "")] -> n

type Input = (Int, Int, [Int])

main = do
    rgen <- getStdGen
    let inputs = take 100 $ unfoldr unfolder rgen
    putStrLn $ show 100 
    putStrLn . intercalate "\n" $ map showInput inputs
    where
        unfolder :: (StdGen -> Maybe (Input, StdGen))
        unfolder g = Just (genInput g1, g2) 
            where
                (g1, g2) = split g

showInput :: Input -> String
showInput (n, b, xs) = show n ++ " " ++ show b ++ "\n" ++ (intercalate " " $ map show xs)

genInput :: StdGen -> (Int, Int, [Int]) -- n/b/xs
genInput g = (n, b, xs)
    where 
     (n, g1) = randomR (100000 :: Int, 100000)  g
     (b, g2) = randomR (0 :: Int, 1000)  g1
     xs = take n $ intGen g2

intGen :: StdGen -> [Int]
intGen g = n:(intGen ng)
    where (n, ng) = randomR (0 :: Int, 1000)  g
