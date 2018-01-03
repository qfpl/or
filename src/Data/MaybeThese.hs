{-# LANGUAGE NoImplicitPrelude #-}

module Data.MaybeThese(
  MaybeThese(..)
) where
  
import Data.These
import Papa

newtype MaybeThese a b =
  MaybeThese
    (Maybe (These a b))
  deriving (Eq, Ord, Show)
