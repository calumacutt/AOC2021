import Data.List
import Data.Char (digitToInt)

-- length' :: [a] -> Integer
-- length' = foldl (\n _ -> n + 1) 0 

-- getMostCommon :: [Int] -> Int
-- getMostCommon xs = if sum xs * 2 > length xs
--     then 1
--     else 0

getMostCommon :: [Int] -> Int
getMostCommon xs = if sum xs * 2 >= length xs
    then 1
    else 0

getLeastCommon :: [Int] -> Int
getLeastCommon xs = if getMostCommon xs == 0
    then 1
    else 0

binToDec :: Int -> [Int] -> Int
binToDec n [] = 0
binToDec n xs = last xs * n + binToDec (n * 2) (init xs)

makeComplement :: [Int] -> [Int]
makeComplement [] = [] 
makeComplement (0 : xs) = 1 : makeComplement xs
makeComplement (1 : xs) = 0 : makeComplement xs

multiplyComplements :: [Int] -> Int
multiplyComplements xs = binToDec 1 xs * binToDec 1 (makeComplement xs)

matchesAtIndex :: Int -> Int -> [Int] -> Bool
matchesAtIndex index match xs = xs !! index == match

sliceColumn :: Int -> [[Int]] -> [Int]
sliceColumn n xss = transpose xss !! n

filterForMostCommon :: Int -> [[Int]] -> [[Int]]
filterForMostCommon n xss = filter ((matchesAtIndex n . getMostCommon . sliceColumn n) xss) xss

filterForLeastCommon :: Int -> [[Int]] -> [[Int]]
filterForLeastCommon n xss = filter ((matchesAtIndex n . getLeastCommon . sliceColumn n) xss) xss

repeatFilterMost :: Int -> [[Int]] -> [[Int]]
repeatFilterMost n xss 
    | length xss == 1 = xss
    | otherwise = repeatFilterMost (n + 1) (filterForMostCommon n xss)

repeatFilterLeast :: Int -> [[Int]] -> [[Int]]
repeatFilterLeast n xss 
    | length xss == 1 = xss
    | otherwise = repeatFilterLeast (n + 1) (filterForLeastCommon n xss)

main :: IO ()
main = do
    listOfStrs <- lines <$> readFile "input.txt"
    -- (print . multiplyComplements . map (getMostCommon . map digitToInt)) (transpose listOfStrs)
    let listOfInts = (map . map) digitToInt listOfStrs
    print (binToDec 1 (head (repeatFilterLeast 0 listOfInts)))
    -- print (binToDec 1 (head (repeatFilterMost 0 listOfInts)))
