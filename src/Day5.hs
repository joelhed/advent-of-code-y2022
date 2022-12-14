module Day5 (day5) where

import Data.List (transpose, sortOn, intercalate)
import Data.Maybe (fromJust)
import Lib
import Utils (splitOn, assocUpdate)

type Box = Char
type Stacks = [(Int, [Box])]
data Instruction = Instruction {n :: Int, from :: Int, to :: Int} deriving (Show)

parseBox :: String -> Box
parseBox = (!! 1)

parseStacks :: [String] -> Stacks
parseStacks = zip [1..]
            . map (init . dropWhile (== ' '))
            . transpose
            . map (map parseBox . iterBoxes)
    where iterBoxes [] = []
          iterBoxes s  = let (group, rest') = splitAt 4 s
                         in group:iterBoxes rest'

_prettyStacks :: Stacks -> String
_prettyStacks = intercalate "\n"
             . map (\(n', s) -> (show n') ++ ": " ++ (reverse s))
             . sortOn fst

parseInstruction :: String -> Instruction
parseInstruction input =
    case map (read . snd)
       $ filter ((\x -> (x `mod` (2 :: Int)) == (1 :: Int)) . fst)
       $ zip [0..]
       $ words input
    of (n':from':to':_) -> Instruction n' from' to'
       _                -> error "could not parse instruction"

parseInput :: String -> (Stacks, [Instruction])
parseInput input =
    case splitOn "" $ lines $ input of
        (stacksLines:instructionLines:_) -> ( parseStacks stacksLines
                                            , map parseInstruction instructionLines
                                            )
        _                                -> error "could not parse input"

performInstruction :: ([Box] -> [Box]) -> Stacks -> Instruction -> Stacks
performInstruction boxOrdering stacks instruction
    = assocUpdate from' (drop n')
    $ assocUpdate to' (\existing -> boxesToMove ++ existing)
    $ stacks
    where (Instruction n' from' to') = instruction
          boxesToMove = boxOrdering $ take n' $ fromJust $ lookup from' stacks

simulate :: ([Box] -> [Box]) -> (Stacks, [Instruction]) -> Stacks
simulate boxOrdering (stacks, instructions) = foldl (performInstruction boxOrdering) stacks instructions

getTopBoxes :: Stacks -> [Box]
getTopBoxes = map (head . spaceIfEmpty . snd) . sortOn fst
              where spaceIfEmpty [] = " "
                    spaceIfEmpty x = x

-- Part 2

day5 :: Day
day5 = Day { part1 = solution reverse
           , part2 = Just $ solution id
           }
       where solution f = getTopBoxes . simulate f . parseInput
