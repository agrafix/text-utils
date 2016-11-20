{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -F -pgmF htfpp #-}
module Data.Text.KGramsTest where

import Data.Text.KGrams

import Test.Framework

test_removePunc :: IO ()
test_removePunc =
    do assertEqual "hallo" (textRemovePunc "hallo")
       assertEqual "hallo welt" (textRemovePunc "hallo-welt")
       assertEqual "hallo welt " (textRemovePunc "hallo.welt!")

test_normalizedWords :: IO ()
test_normalizedWords =
    do assertEqual ["hallo"] (textNormalizedWords "hallo")
       assertEqual ["hallo", "welt"] (textNormalizedWords "!hallo WeLt  ")
       assertEqual ["foo", "bar"] (textNormalizedWords "foo-bar")
       assertEqual ["foo", "bar"] (textNormalizedWords "Foo- bar")
       assertEqual ["foo", "bar"] (textNormalizedWords "Foo.- bar")

test_kgrams :: IO ()
test_kgrams =
    do assertEqual ["foo"] (kgrams 3 "foo")
       assertEqual ["fo", "oo"] (kgrams 2 "foo")
       assertEqual ["f", "o", "o"] (kgrams 1 "foo")
       assertEqual [] (kgrams 3 "fo")

test_textKGrams :: IO ()
test_textKGrams =
    do assertEqual ["foo"] (textKGrams 3 "foo")
       assertEqual ["hal", "all", "llo", "wel", "elt"] (textKGrams 3 "Hallo-Welt")
       assertEqual ["thi", "hie", "iem", "ema", "man", "ann"] (textKGrams 3 "Thiemann")
