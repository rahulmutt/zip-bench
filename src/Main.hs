{-# LANGUAGE OverloadedStrings #-}
module Main where

import Path
import Codec.Archive.Zip
import Control.Monad.IO.Class (MonadIO(..))
import Control.Monad.Catch (MonadCatch(..), MonadThrow)
import Data.Map.Lazy (keys)
import qualified Data.ByteString as BS
import System.Directory
import System.Environment
import Control.Monad

createLargeZip :: String -> Int -> IO ()
createLargeZip name size = do
  p <- parseRelFile name
  ps <- mapM (parseRelFile . ('a':) . show) range
  createArchive p $
    forM_ ps $ \p -> do
      es <- mkEntrySelector p
      addEntry Deflate (BS.pack [1]) es
  where range = [1..size]

main :: IO ()
main = do
  createLargeZip "Before.jar" 65534
  createLargeZip "After.jar" 65535
