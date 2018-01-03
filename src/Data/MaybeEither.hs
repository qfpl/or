{-# LANGUAGE NoImplicitPrelude #-}

module Data.MaybeEither(
  MaybeEither(..)
) where

import Papa

newtype MaybeEither a b =
  MaybeEither
    (Maybe (Either a b))
  deriving (Eq, Ord, Show)
