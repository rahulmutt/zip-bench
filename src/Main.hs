{-# LANGUAGE TupleSections #-}
module Main where

import Path
import Codec.Archive.Zip
import Control.Monad.IO.Class (MonadIO(..))
import Control.Monad.Catch (MonadCatch(..), MonadThrow)
import Data.Map.Lazy (keys)
import System.Directory
import System.Environment
import Control.Monad

makeAbsoluteFilePath :: (MonadIO m, MonadThrow m) => FilePath -> m (Path Abs File)
makeAbsoluteFilePath fp = do
  absPath <- liftIO $ canonicalizePath fp
  parseAbsFile absPath

getEntriesFromJar
  :: (MonadThrow m, MonadCatch m, MonadIO m)
  => FilePath
  -> m [(Path Abs File, EntrySelector)]
getEntriesFromJar jarLocation = do
  p <- makeAbsoluteFilePath jarLocation
  fmap (map (p,)) $ withArchive p $ keys <$> getEntries

main :: IO ()
main = do
  args <- getArgs
  jarSelectors <- fmap concat $ mapM getEntriesFromJar args
  p <- parseRelFile "Bench.jar"
  createArchive p $
    forM_ jarSelectors $ \(absFile, entrySel) ->
      copyEntry absFile entrySel entrySel
