import Data.List.Split (splitOn, chunksOf)

-- Reading Input

readInput :: [String] -> ([Int], [[[Int]]]) 
readInput (draw : gap : cards) = (readDraw draw, readCards cards)

readDraw :: String -> [Int]
readDraw draw = map (read::String->Int) (splitOn "," draw)

readCards :: [String] -> [[[Int]]]
readCards cards = map (readCardRows . init) (chunksOf 6 cards)

readCardRows :: [String] -> [[Int]]
readCardRows = map readCardRow

readCardRow :: String -> [Int]
readCardRow row = map read (filter (/= "") (splitOn " " row))



main :: IO ()
main = do
    listOfStrs <- lines <$> readFile "input-small.txt"
    print (let (draw, cards) = readInput listOfStrs in cards)
