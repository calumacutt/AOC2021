import Data.List

-- applyCommand :: (Integer, Integer) -> String -> (Integer, Integer)
-- applyCommand (depth, dist) command
--     | "forward " `isPrefixOf` command = applyForward (depth, dist) (stripPrefix "forward " command)
--     | "down " `isPrefixOf` command = applyDown (depth, dist) (stripPrefix "down " command)
--     | "up " `isPrefixOf` command = applyUp (depth, dist) (stripPrefix "up " command)

-- applyForward :: (Integer, Integer) -> Maybe String -> (Integer, Integer)
-- applyForward (depth, dist) (Just value) = (depth, dist + read value)

-- applyDown :: (Integer, Integer) -> Maybe String -> (Integer, Integer)
-- applyDown (depth, dist) (Just value) = (depth + read value, dist)

-- applyUp :: (Integer, Integer) -> Maybe String -> (Integer, Integer)
-- applyUp (depth, dist) (Just value) = (depth - read value, dist)

applyCommand :: (Integer, Integer, Integer) -> String -> (Integer, Integer, Integer)
applyCommand (depth, dist, aim) command
    | "forward " `isPrefixOf` command = applyForward (depth, dist, aim) (stripPrefix "forward " command)
    | "down " `isPrefixOf` command = applyDown (depth, dist, aim) (stripPrefix "down " command)
    | "up " `isPrefixOf` command = applyUp (depth, dist, aim) (stripPrefix "up " command)

applyForward :: (Integer, Integer, Integer) -> Maybe String -> (Integer, Integer, Integer)
applyForward (depth, dist, aim) (Just value) = (depth + aim * read value, dist + read value, aim)

applyDown :: (Integer, Integer, Integer) -> Maybe String -> (Integer, Integer, Integer)
applyDown (depth, dist, aim) (Just value) = (depth, dist, aim + read value)

applyUp :: (Integer, Integer, Integer) -> Maybe String -> (Integer, Integer, Integer)
applyUp (depth, dist, aim) (Just value) = (depth, dist, aim - read value)

main :: IO ()
main = do
    listOfStrs <- lines <$> readFile "input.txt"
    let (depth, dist, aim) = foldl applyCommand (0, 0, 0) listOfStrs
    print (depth * dist)
