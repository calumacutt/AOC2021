import Data.List
import Data.Char (digitToInt)

-- length' :: [a] -> Integer
-- length' = foldl (\n _ -> n + 1) 0 

getMostCommon :: [Int] -> Int
getMostCommon xs = if sum xs * 2 > length xs
    then 1
    else 0

main :: IO ()
main = do
    listOfStrs <- lines <$> readFile "input.txt"
    -- (print . (map getMostCommon) . (map . map . read) . transpose) listOfStrs
    (print . map (getMostCommon . map digitToInt)) (transpose listOfStrs)
