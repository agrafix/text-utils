{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
module Data.Text.ToFromText where

import qualified Data.Text as T

class ToFromText a where
    toText :: a -> T.Text
    fromText :: Monad m => T.Text -> m a

    default fromText :: (Enum a, Bounded a, Monad m) => T.Text -> m a
    fromText = fromTextHelper toText

instance ToFromText T.Text where
    toText = id
    fromText = pure

instance ToFromText String where
    toText = T.pack
    fromText = pure . T.unpack

fromTextHelper :: (Enum a, Bounded a, Monad m) => (a -> T.Text) -> T.Text -> m a
fromTextHelper mkT q =
    loop [minBound .. maxBound]
    where
      loop [] = fail ("Could not read " ++ show q)
      loop (x : xs) =
          if mkT x == q then pure x else loop xs
