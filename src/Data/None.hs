{-# LANGUAGE NoImplicitPrelude #-}

module Data.None(
  AsNone(..)
) where

import Data.Proxy(Proxy(Proxy))
import Papa

class AsNone f where
  _None ::
    Prism'
      (f a)
      ()

instance AsNone Proxy where
  _None =
    prism'
      (\() -> Proxy)
      (\Proxy -> Just ())

instance AsNone Maybe where
  _None =
    _Nothing
