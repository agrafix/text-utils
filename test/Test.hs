{-# OPTIONS_GHC -F -pgmF htfpp #-}
module Main where

import Test.Framework
import {-@ HTF_TESTS @-} Data.Text.KGramsTest
import {-@ HTF_TESTS @-} Data.Text.ToFromTextTest

main :: IO ()
main =
    htfMain htf_importedTests
