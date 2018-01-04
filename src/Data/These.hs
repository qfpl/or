{-# LANGUAGE NoImplicitPrelude #-}

module Data.These(
  These(..)
) where

import Data.Both(AsBoth(_Both))
import Data.That(AsThat'(_That'), AllThat(_AllThat))
import Data.This(AsThis'(_This'), AllThis(_AllThis))
import Papa

data These a b =
  This a
  | That b
  | Both a b
  deriving (Eq, Ord, Show)

-- UNABLE: AsThis
instance AsThis' These where
  _This' =
    prism'
      This
      (\x ->  case x of
                This a ->
                  Just a
                That _ ->
                  Nothing
                Both _ _ ->
                  Nothing)

-- UNABLE: AsThat
instance AsThat' These where
  _That' =
    prism'
      That
      (\x ->  case x of
                This _ ->
                  Nothing
                That b ->
                  Just b
                Both _ _ ->
                  Nothing)

instance AsBoth These where
  _Both =
    prism'
      (uncurry Both)
      (\x ->  case x of
                This _ ->
                  Nothing
                That _ ->
                  Nothing
                Both a b ->
                  Just (a, b))

instance AllThis These where
  _AllThis f (This a) =
    This <$> f a
  _AllThis _ (That b) =
    pure (That b)
  _AllThis f (Both a b) =
    (\a' -> Both a' b) <$> f a

instance AllThat These where
  _AllThat _ (This a) =
    pure (This a)
  _AllThat f (That b) =
    That <$> f b         
  _AllThat f (Both a b) =
    (\b' -> Both a b') <$> f b
