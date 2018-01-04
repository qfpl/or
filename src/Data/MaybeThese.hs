{-# LANGUAGE NoImplicitPrelude #-}

module Data.MaybeThese(
  MaybeThese(..)
) where
  
import Papa
import Data.Both(AsBoth(_Both))
import Data.Neither(AsNeither(_Neither))
import Data.That(AsThat'(_That'), AllThat(_AllThat))
import Data.These(These(This, That, Both))
import Data.This(AsThis'(_This'), AllThis(_AllThis))

newtype MaybeThese a b =
  MaybeThese
    (Maybe (These a b))
  deriving (Eq, Ord, Show)

instance AsNeither MaybeThese where
  _Neither =
    prism'
      (\() -> MaybeThese Nothing)
      (\(MaybeThese x) ->
          case x of
            Nothing ->
              Just ()
            Just _ ->
              Nothing)

-- UNABLE: AsThis
instance AsThis' MaybeThese where
  _This' =
    prism
      (MaybeThese . Just . This)
      (\(MaybeThese x) ->
          case x of
            Nothing ->
              Left (MaybeThese Nothing)
            Just (This a) ->
              Right a
            Just (That b) ->
              Left (MaybeThese (Just (That b)))
            Just (Both a b) ->
              Left (MaybeThese (Just (Both a b))))

-- UNABLE: AsThat
instance AsThat' MaybeThese where
  _That' =
    prism
      (MaybeThese . Just . That)
      (\(MaybeThese x) ->
          case x of
            Nothing ->
              Left (MaybeThese Nothing)
            Just (This a) ->
              Left (MaybeThese (Just (This a)))
            Just (That b) ->
              Right b
            Just (Both a b) ->
              Left (MaybeThese (Just (Both a b))))

instance AsBoth MaybeThese where
  _Both =
    prism'
      (\(c, d) -> MaybeThese (Just (Both c d)))
      (\(MaybeThese x) ->
          case x of
            Nothing ->
              Nothing
            Just (This _) ->
              Nothing
            Just (That _) ->
              Nothing
            Just (Both a b) ->
              Just (a, b))

instance AllThis MaybeThese where
  _AllThis _ (MaybeThese Nothing) =
    pure (MaybeThese Nothing)
  _AllThis f (MaybeThese (Just (This a))) =
    MaybeThese . Just . This <$> f a
  _AllThis _ (MaybeThese (Just (That b))) =
    pure (MaybeThese (Just (That b)))
  _AllThis f (MaybeThese (Just (Both a b))) =
    (\a' -> MaybeThese (Just (Both a' b))) <$> f a

instance AllThat MaybeThese where
  _AllThat _ (MaybeThese Nothing) =
    pure (MaybeThese Nothing)
  _AllThat _ (MaybeThese (Just (This a))) =
    pure (MaybeThese (Just (This a)))
  _AllThat f (MaybeThese (Just (That b))) =
    MaybeThese . Just . That <$> f b
  _AllThat f (MaybeThese (Just (Both a b))) =
    MaybeThese . Just . Both a <$> f b
