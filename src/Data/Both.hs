{-# LANGUAGE NoImplicitPrelude #-}

module Data.Both(
  AsBoth(..)
) where

import Papa

class AsBoth f where
  _Both ::
    Prism'
      (f a b)
      (a, b)

instance AsBoth (,) where
  _Both =
    id
