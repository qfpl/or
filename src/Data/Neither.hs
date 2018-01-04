{-# LANGUAGE NoImplicitPrelude #-}

module Data.Neither(
  AsNeither(..)
) where

import Papa

class AsNeither f where
  _Neither ::
    Prism'
      (f a b)
      ()
