module Lib
    ( Day (..)
    , DaySpec
    , PartSpec
    , DayPartSpec (..)
    , Part
    , getPartFromPartSpec
    , getLatestPartSpec
    , getPartSpecByNum
    ) where

type DaySpec = Int
data PartSpec = Part1 | Part2
data DayPartSpec = DayPartSpec { daySpec  :: DaySpec
                               , partSpec :: PartSpec
                               }

type Part = String -> String

data Day = Day { part1 :: Part
               , part2 :: Maybe (Part)
               }

getPartFromPartSpec :: PartSpec -> Day -> Maybe Part
getPartFromPartSpec Part1 = Just . part1
getPartFromPartSpec Part2 = part2

getLatestPartSpec :: Day -> PartSpec
getLatestPartSpec day =
    case part2 day of
        (Just _) -> Part2
        Nothing  -> Part1

getPartSpecByNum :: Int -> Maybe PartSpec
getPartSpecByNum 1 = Just Part1
getPartSpecByNum 2 = Just Part2
getPartSpecByNum _ = Nothing
