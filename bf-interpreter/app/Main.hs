module Main (main) where

import Lib
import Tape
import Parser
import Control.Exception (try)
import GHC.IO.Exception (IOException(IOError))
import Data.Word (Word8)
import System.IO (stdin, hSetBuffering, BufferMode (NoBuffering))







main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    result <- try (readFile "programs\\test_one.bf") :: IO (Either IOError String)
    case result of
        Left err -> putStrLn $ "Error: " ++ show err
        Right str -> do
            res <- parseIt str initTape
            case res of
                Left err -> putStrLn $ "Error: " ++ show err
                Right _  -> return ()
            



    

