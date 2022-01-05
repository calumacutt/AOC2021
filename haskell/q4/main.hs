import Data.List.Split (splitOn, chunksOf)
import Data.List


-- Reading Input

readInput :: [String] -> ([Int], [[[Int]]]) 
readInput (draw : cards) = (readDraw draw, readCards cards)

readDraw :: String -> [Int]
readDraw draw = map (read::String->Int) (splitOn "," draw)

readCards :: [String] -> [[[Int]]]
readCards cards = map (readCardRows . tail) (chunksOf 6 cards)

readCardRows :: [String] -> [[Int]]
readCardRows = map readCardRow

readCardRow :: String -> [Int]
readCardRow row = map read (filter (/= "") (splitOn " " row))

-- 

markNumberOnCards :: Int -> [[[Int]]] -> [[[Int]]]
markNumberOnCards draw = (map . map) (markNumberOnRow draw)

-- markNumberOnCard :: Int -> [[Int]] -> [[Int]]
-- markNumberOnCard draw = map (markNumberOnRow draw)

markNumberOnRow :: Int -> [Int] -> [Int]
markNumberOnRow draw row = [if x == draw then -x else x | x <- row]

--

checkCardForBingo :: [[Int]] -> Bool
checkCardForBingo card = any (all (<0)) (card ++ transpose card)

sumNonNegatives :: [[Int]] -> Int
sumNonNegatives card = sum (map sumNonNegativesRow card)

sumNonNegativesRow :: [Int] -> Int
sumNonNegativesRow row = sum (filter (>=0) row)

--

main :: IO ()
main = do
    listOfStrs <- lines <$> readFile "input-small.txt"
    -- print (let (draw, cards) = readInput listOfStrs in markNumberOnCards 12 cards)
    print $ sumNonNegatives [[1,1,1],[1,-1,1],[1,1,1]]
