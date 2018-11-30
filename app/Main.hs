{-# LANGUAGE OverloadedStrings #-}

import           Data.Aeson
import qualified Data.Text.IO as TIO
import           HAR
import           HAR.Entry
import           HAR.Log
import           HAR.Request
import           HAR.Response
import           System.Environment

main :: IO ()
main = do
  mharf <- decodeOpts <$> getArgs
  case mharf of
    Just harf -> do
      har <- decodeFileStrict harf :: IO (Maybe HAR)
      case har of
        Just l -> do
          print $ HAR.Log.creator $ HAR.log l
          mapM_ (\e -> do
                    putStrLn "===="
                    TIO.putStrLn $ "URL: " <> HAR.Request.url (HAR.Entry.request e)
                    putStrLn $ "time: " <> show (HAR.Entry.time e)
                    putStrLn $ "Status: " <> show (HAR.Response.status $ HAR.Entry.response e)
                    putStrLn $ "BodySize: " <> show (HAR.Response.bodySize $ HAR.Entry.response e)
                    putStrLn $ "HeaderSize: " <> show (HAR.Response.headersSize $ HAR.Entry.response e)
                    putStrLn "====\n"
                ) (HAR.Log.entries $ HAR.log l)
        Nothing -> usage
    Nothing -> usage
  where
    decodeOpts [harf] = Just harf
    decodeOpts _ = Nothing
    usage = putStrLn "harv /path/file.har"
