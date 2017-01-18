{-# LANGUAGE OverloadedStrings #-}
module Main where

import Path
import Codec.Archive.Zip
import Control.Monad.IO.Class (MonadIO(..))
import Control.Monad.Catch (MonadCatch(..), MonadThrow)
import Data.Map.Lazy (keys)
import System.Directory
import System.Environment
import Control.Monad

main :: IO ()
main = do
  p <- parseRelFile "Test.jar"
  s <- parseRelFile "hello-world.txt" >>= mkEntrySelector
  createArchive p $ addEntry Store "Hello, World!" s
  entries <- withArchive p $ keys <$> getEntries
  mapM_ print entries
