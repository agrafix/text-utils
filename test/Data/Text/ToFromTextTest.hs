{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -F -pgmF htfpp #-}
module Data.Text.ToFromTextTest where

import Data.Text.ToFromText

import Test.Framework

data SomeEnum
    = SomeEnumA
    | SomeEnumB
    | SomeEnumC
    deriving (Show, Eq, Enum, Bounded)

instance ToFromText SomeEnum where
    toText e =
        case e of
          SomeEnumA -> "A"
          SomeEnumB -> "B"
          SomeEnumC -> "C"

test_autoFromText :: IO ()
test_autoFromText =
    do assertEqual (Just SomeEnumA) (fromText "A")
       assertEqual (Just SomeEnumB) (fromText "B")
       assertEqual (Just SomeEnumC) (fromText "C")
       assertEqual (Nothing :: Maybe SomeEnum) (fromText "asdasdasd")
