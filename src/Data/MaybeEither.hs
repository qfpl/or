{-# LANGUAGE NoImplicitPrelude #-}

module Data.MaybeEither(
  MaybeEither(..)
) where

import Data.Neither(AsNeither(_Neither))
import Data.That(AsThat(_That), AsThat'(_That'), AllThat(_AllThat))
import Data.This(AsThis(_This), AsThis'(_This'), AllThis(_AllThis))
import Papa

newtype MaybeEither a b =
  MaybeEither
    (Maybe (Either a b))
  deriving (Eq, Ord, Show)

instance AsNeither MaybeEither where
  _Neither =
    prism'
      (\() -> MaybeEither Nothing)
      (\(MaybeEither x) -> case x of
                            Nothing ->
                              Just ()
                            Just _ ->
                              Nothing)

instance AsThis MaybeEither where
  _This =
    prism
      (MaybeEither . Just . Left)
      (\(MaybeEither x) ->  case x of
                              Nothing ->
                                Left (MaybeEither Nothing)
                              Just (Left a) ->
                                Right a
                              Just (Right b) ->
                                Left (MaybeEither (Just (Right b))))

instance AsThis' MaybeEither where
  _This' =
    _This

instance AsThat MaybeEither where
  _That =
    prism
      (MaybeEither . Just . Right)
      (\(MaybeEither x) ->  case x of
                              Nothing ->
                                Left (MaybeEither Nothing)
                              Just (Left a) ->
                                Left (MaybeEither (Just (Left a)))
                              Just (Right b) ->
                                Right b)

instance AsThat' MaybeEither where
  _That' =
    _That

instance AllThis MaybeEither where
  _AllThis _ (MaybeEither Nothing) =
    pure (MaybeEither Nothing)
  _AllThis f (MaybeEither (Just (Left a))) =
    MaybeEither . Just . Left <$> f a
  _AllThis _ (MaybeEither (Just (Right b))) =
    pure (MaybeEither (Just (Right b)))

instance AllThat MaybeEither where
  _AllThat _ (MaybeEither Nothing) =
    pure (MaybeEither Nothing)
  _AllThat _ (MaybeEither (Just (Left a))) =
    pure (MaybeEither (Just (Left a)))    
  _AllThat f (MaybeEither (Just (Right b))) =
    MaybeEither . Just . Right <$> f b
