{-# LANGUAGE NoImplicitPrelude #-}

module Data.These(
  These(..)
) where

import Papa

data These a b =
  This a
  | That b
  | Both a b
  deriving (Eq, Ord, Show)
