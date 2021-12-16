mapStrsToInts :: [String] -> [Integer]
mapStrsToInts = map read

zipToWindowTriplets :: [Integer] -> [(Integer, Integer, Integer)]
zipToWindowTriplets listOfInts = zip3 ((init . init) listOfInts) ((init . tail) listOfInts) ((tail . tail) listOfInts)

zipToWindowPairs :: [Integer] -> [(Integer, Integer)]
zipToWindowPairs listOfInts = zip (init listOfInts) (tail listOfInts)

sumTriplet :: (Integer, Integer, Integer) -> Integer
sumTriplet (a, b, c) = a + b + c

checkAscending :: (Integer, Integer) -> Integer
checkAscending (a, b)
    | a < b = 1
    | otherwise = 0

main :: IO ()
main = do
    listOfStrs <- lines <$> readFile "input.txt"
    -- (print . sum . (map checkAscending) . zipToWindowPairs . mapStrsToInts) listOfStrs
    (print . sum . (map checkAscending) . zipToWindowPairs . (map sumTriplet) . zipToWindowTriplets . mapStrsToInts) listOfStrs
