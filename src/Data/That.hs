{-# LANGUAGE NoImplicitPrelude #-}

module Data.That(
  AsThat(..)
, AsThat'(..)
, AllThat(..)
) where

import Papa

class AsThat f where
  _That ::
    Prism
      (f a b)
      (f a x)
      b
      x

instance AsThat Either where
  _That =
    _Right

class AsThat' f where
  _That' ::
    Prism'
      (f a b)
      b

instance AsThat' Either where
  _That' =
    _Right

class AllThat f where
  _AllThat ::
    Traversal
      (f a b)
      (f a x)
      b
      x

instance AllThat Either where
  _AllThat =
    _Right

instance AllThat (,) where
  _AllThat =
    _2
