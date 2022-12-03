import System.IO  
import Control.Monad
import Data.List (intersect)
import Data.Char (ord)
import Data.Text as Tx(Text, drop, take, pack, unpack)

main = do  
        contents <- readFile "data.txt"
        let result = part1 (lines contents)
        print result
        let result2 = part2 (lines contents)
        print result2

-- used in both
getCharValue :: Char -> Int
getCharValue c = 
    if ord c < 96
        then ord c - 38
    else ord c - 96

-- part 1 functions
part1 :: [String] -> Int
part1 l = sum (map getCharValue (map getDup l))

sumCharVals :: [Char] -> Int
sumCharVals l = sum (map getCharValue l)

getDup :: String -> Char
getDup x = intersectPair (map unpack (halfStr x))

halfLen :: String -> Int
halfLen s = div (length s) 2

halfStr :: String -> [Tx.Text]
halfStr s = [Tx.take (halfLen s) (pack s), Tx.drop (halfLen s) (pack s)]

intersectPair :: [[Char]] -> Char
intersectPair l = intersectElem (l !! 0) (l !! 1)

intersectElem :: [Char] -> [Char] -> Char
intersectElem a b  = (intersect a b) !! 0

-- part2
part2 :: [String] -> Int 
part2 l = sum (map getCharValue (map intersectElem3 (split3 l)))

split3 :: [a] -> [[a]]
split3 [] = []
split3 l = (Prelude.take 3 l) : (split3 (Prelude.drop 3 l))

-- Yes, I should've done this properly for any list length but I forgot how to do it...
intersectElem3 :: [[Char]] -> Char
intersectElem3 l  = (intersect (intersect (l !! 0) (l !! 1)) (l !! 2)) !! 0
