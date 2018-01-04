{-# LANGUAGE NoImplicitPrelude #-}

module Data.This(
  AsThis(..)
, AsThis'(..)
, AllThis(..)
) where

import Papa

class AsThis f where
  _This ::
    Prism
      (f a b)
      (f x b)
      a
      x

instance AsThis Either where
  _This =
    _Left

class AsThis' f where
  _This' ::
    Prism'
      (f a b)
      a

instance AsThis' Either where
  _This' =
    _Left

class AllThis f where
  _AllThis ::
    Traversal
      (f a b)
      (f x b)
      a
      x

instance AllThis Either where
  _AllThis =
    _Left

instance AllThis (,) where
  _AllThis =
    _1
