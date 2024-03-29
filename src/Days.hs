module Days ( days
            , getDayFromDaySpec
            , getPartFromDayPartSpec
            ) where

import Control.Monad (join)

import Lib
import Utils (maybeAt)

import Day1
import Day2
import Day3
import Day4
import Day5
import Day6
import Day7
import Day8
import Day9 (day9)
import Day10
import Day11
import Day12

days :: [Day]
days = [ day1
       , day2
       , day3
       , day4
       , day5
       , day6
       , day7
       , day8
       , day9
       , day10
       , day11
       , day12
       ]

getDayFromDaySpec :: DaySpec -> Maybe Day
getDayFromDaySpec = (flip maybeAt) days . subtract 1

getPartFromDayPartSpec :: DayPartSpec -> Maybe Part
getPartFromDayPartSpec (DayPartSpec daySpec' partSpec') =
    join $ getPartFromPartSpec partSpec' <$> getDayFromDaySpec daySpec'

