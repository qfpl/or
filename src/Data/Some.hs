{-# LANGUAGE NoImplicitPrelude #-}

module Data.Some(
  AsSome(..)
) where

import Papa

class AsSome f where
  _Some ::
    Prism
      (f a)
      (f b)
      a
      b

instance AsSome Identity where
  _Some =
    _Wrapped

instance AsSome Maybe where
  _Some =
    _Just
