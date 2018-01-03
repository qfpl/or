{-# LANGUAGE NoImplicitPrelude #-}

module Data.That(
  AsThat(..)
) where

import Papa

class AsThat f where
  _That ::
    Prism
      (f a b)
      (f x b)
      a
      x

instance AsThat Either where
  _That =
    _Left
