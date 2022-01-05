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

-- Logic

markDrawOnCards :: Int -> [[[Int]]] -> ([[[Int]]], Int)
markDrawOnCards draw cards = foldl groupCardResults ([], 0) (map (markDrawOnCard draw) cards)

groupCardResults :: ([[[Int]]], Int) -> ([[Int]], Int) -> ([[[Int]]], Int) 
groupCardResults ([], _) (a, b) = ([a], b)
groupCardResults (xs, r) (a, b) = (a : xs, r + b)

markDrawOnCard :: Int -> [[Int]] -> ([[Int]], Int)
markDrawOnCard draw precard = let postcard = map (markDrawOnRow draw) precard in
    if checkCardForBingo postcard 
        then (postcard, sumNonNegatives postcard * draw)
        else (postcard, 0)

markDrawOnRow :: Int -> [Int] -> [Int]
markDrawOnRow draw row = [if x == draw then -x else x | x <- row]

checkCardForBingo :: [[Int]] -> Bool
checkCardForBingo card = any (all (<0)) (card ++ transpose card)

sumNonNegatives :: [[Int]] -> Int
sumNonNegatives card = sum (map sumNonNegativesRow card)

sumNonNegativesRow :: [Int] -> Int
sumNonNegativesRow row = sum (filter (>=0) row)

playBingo :: [Int] -> [[[Int]]] -> Int
playBingo (d : ds) precards = let (postcards, result) = markDrawOnCards d precards in
    if result /= 0
        then result
        else playBingo ds postcards

main :: IO ()
main = do
    listOfStrs <- lines <$> readFile "input.txt"
    print (let (draw, cards) = readInput listOfStrs in playBingo draw cards)
