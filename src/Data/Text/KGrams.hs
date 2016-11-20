module Data.Text.KGrams where

import qualified Data.Text as T

textRemovePunc :: T.Text -> T.Text
textRemovePunc = T.map (\ch -> if ch `elem` ".?!-;\'\"" then ' ' else ch)

textNormalizedWords :: T.Text -> [T.Text]
textNormalizedWords = filter (not . T.null) . T.words . T.toLower . textRemovePunc

textKGrams :: Int -> T.Text -> [T.Text]
textKGrams size = concatMap (kgrams size) . textNormalizedWords

kgrams :: Int -> T.Text -> [T.Text]
kgrams size inp =
    let loop txt =
            if T.length txt < size
            then []
            else T.take size txt : loop (T.drop 1 txt)
    in loop inp
