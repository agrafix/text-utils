{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
module Data.Text.ToFromText where

import Control.Applicative
import qualified Data.Text as T

class ToFromText a where
    toText :: a -> T.Text
    fromText :: Alternative m => T.Text -> m a

    default fromText :: (Enum a, Bounded a, Alternative m) => T.Text -> m a
    fromText = fromTextHelper toText

instance ToFromText T.Text where
    toText = id
    fromText = pure

instance ToFromText String where
    toText = T.pack
    fromText = pure . T.unpack

fromTextHelper :: (Enum a, Bounded a, Alternative m) => (a -> T.Text) -> T.Text -> m a
fromTextHelper mkT q =
    loop [minBound .. maxBound]
    where
      loop [] = empty
      loop (x : xs) =
          if mkT x == q then pure x else loop xs
