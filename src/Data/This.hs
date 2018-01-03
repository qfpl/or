{-# LANGUAGE NoImplicitPrelude #-}

module Data.This(
  AsThis(..)
) where

import Papa

class AsThis f where
  _This ::
    Prism
      (f a b)
      (f a x)
      b
      x

instance AsThis Either where
  _This =
    _Right
