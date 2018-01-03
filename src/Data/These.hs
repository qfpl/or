{-# LANGUAGE NoImplicitPrelude #-}

module Data.These(
  These(..)
) where

data These a b =
  This a
  | That b
  | Both a b
