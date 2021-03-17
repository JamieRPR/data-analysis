import Data.Char
import Data.List
import Data.Function
import Control.Applicative

-- Functions from Data.List.Unique that I struggled to import, thus I found the source code and pasted directly
sg :: Ord a => [a] -> [[a]]
sg = group . sort

lh :: [a] -> (a, Int)
lh = liftA2 (,) head length

count :: Ord a => [a] -> [(a, Int)]
count = map lh . sg

count_ :: Ord a => [a] -> [(a, Int)]
count_ = sortBy (compare `on` snd) . count
-- End of Data.List.Unique bodge 

-- Makes a String (an array of Char) lower case
toLowerString :: String -> String
toLowerString str = map toLower str

-- Joins an array of Strings together, separated by spaces
joinWithSpaces :: [String] -> String
joinWithSpaces lst = concat (map (\x -> (x ++ " ")) lst)

-- Splits the input string into separate words, returns array
reverseWords :: String -> String
reverseWords str = joinWithSpaces ( reverse ( words ( toLowerString str ) ) )

-- Converts String to a String List
toWordList :: String -> [String]
toWordList str = words (dropNonLetters (toLowerString str))

dropNonLetters :: String -> String
dropNonLetters str =  filter (\x -> x `elem` (' ':['a' .. 'z'])) str

-- Lists 20 Most Frequency Repeated strings in string array
countCommonWords :: [String] -> Int
countCommonWords x = length (intersect x mostCommonWords)

-- Takes a list of strings and drops any word that is within the top 20 most commonly used in English.
dropCommonWords :: [String] -> [String]
dropCommonWords x = filter (\w -> not (w `elem` mostCommonWords)) x

countWords :: [String] -> [(String, Int)]
countWords x = reverse (count_ x)
  
makeHistogram :: [(String, Int)] -> String
makeHistogram = concatMap makeHistogramRow

makeHistogramRow :: (String, Int) -> String
makeHistogramRow (str, int) = replicate int '*' ++ " -> " ++ str ++ "\n"

text = "It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way--in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.\nThere were a king with a large jaw and a queen with a plain face, on the throne of England; there were a king with a large jaw and a queen with a fair face, on the throne of France. In both countries it was clearer than crystal to the lords of the State preserves of loaves and fishes, that things in general were settled for ever."
mostCommonWords = ["the", "be", "to", "of", "and", "a", "in", "that", "have", "i", "it", "for", "not", "on", "with", "he", "as", "you", "do", "at"]

main = do
    let wordlist = toWordList text
    putStrLn ""
    putStrLn "Report:"
    putStrLn ("\t" ++ (show $ length wordlist) ++ " words")
    putStrLn ("\t" ++ (show $ countCommonWords wordlist) ++ " common words")
    putStrLn "\nHistogram of the most frequent words (excluding common words):\n" 
    putStr $ makeHistogram $ countWords $ dropCommonWords $ wordlist
