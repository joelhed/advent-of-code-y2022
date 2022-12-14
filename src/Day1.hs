module Day1 (day1) where

import Lib
import Data.List (sort, insert)
import Utils (splitOn)

getElfInventories :: String -> [[Int]]
getElfInventories = map (map read) . splitOn "" . lines

thisPart1 :: String -> String
thisPart1 = show . maximum . map sum . getElfInventories

-- This is a simple solution, but could be inefficient due to sorting being O(n*log n).
_threeLargestWithSort :: [Int] -> [Int]
_threeLargestWithSort = take 3 . reverse . sort

-- We should only really need to pass through the list once.
-- I'll try to implement this functionally.
-- This could be done by using a recursive pattern where we pass along the current
-- highest as a parameter to a hidden recursive function.
_threeLargestWithRec :: [Int] -> [Int]
_threeLargestWithRec input =
    let
        threeLargestRec :: [Int] -> [Int] -> [Int]
        threeLargestRec currentMax [] = currentMax
        threeLargestRec currentMax (x:xs) =
            threeLargestRec newMax xs
            where newMax = tail $ insert x currentMax
        (firstThree, rest) = splitAt 3 input
    in
        threeLargestRec firstThree rest

threeLargest :: [Int] -> [Int]
threeLargest = _threeLargestWithRec

-- Turns out, both solutions take approximately 0,26 seconds to complete on my machine.
-- I.e. no practical difference.

thisPart2 :: String -> String
thisPart2 = show . sum . threeLargest . map sum . getElfInventories

day1 :: Day
day1 = Day { part1 = thisPart1
           , part2 = (Just thisPart2)
           }
