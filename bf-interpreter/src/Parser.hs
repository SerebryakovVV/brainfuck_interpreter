module Parser (parseIt) where

import Tape
import Operator
import Control.Exception (try)
import Data.Char (ord, chr)
import System.IO (hFlush, stdout)


parseIt :: String -> Tape -> IO (Either String (String, Tape))
parseIt [] tp = return (Right ("", tp))
parseIt str@(x:xs) tp@(Tape l c r) = case x of
    '>' -> parseIt xs (moveTapeRight tp)
    '<' -> parseIt xs (moveTapeLeft tp)
    '+' -> parseIt xs (incrementTape tp)
    '-' -> parseIt xs (decrementTape tp)
    '.' -> do
             fromIntegral c 
                |> chr 
                |> putChar
             hFlush stdout
             parseIt xs tp
    ',' -> do
             res <- try (getChar) :: IO (Either IOError Char)
             case res of
                Left err   -> return (Left (show err))
                Right '\n' -> parseIt str tp
                Right '\r' -> parseIt str tp
                Right ch   -> parseIt xs (Tape l (fromIntegral $ ord ch) r)
    '['    | c == 0    -> case skipLoop 1 xs of 
                               Just skipRes -> parseIt skipRes tp
                               Nothing      -> return (Left "Unmatched bracket")
           | otherwise -> parseIt xs tp
    -- ']' -> undefined
    _  -> return (Left "Unknown symbol")


skipLoop :: Int -> String -> Maybe String
skipLoop 1 str = Just str
skipLoop _ [] = Nothing
skipLoop n (x:xs)
    | x == '['  = skipLoop (n+1) xs
    | x == ']'  = skipLoop (n-1) xs
    | otherwise = skipLoop n xs




























-- parseIt :: String -> Tape -> IO (Either String (String, Tape))
-- parseIt [] tp = return (Right ("", tp))
-- parseIt str@(x:xs) tp@(Tape l c r) = case x of
--     '>' -> parseIt xs (moveTapeRight tp)
--     '<' -> parseIt xs (moveTapeLeft tp)
--     '+' -> parseIt xs (incrementTape tp)
--     '-' -> parseIt xs (decrementTape tp)
--     '.' -> do
--              fromIntegral c 
--                 |> chr 
--                 |> putChar
--              hFlush stdout
--              parseIt xs tp
--     ',' -> do
--              res <- try (getChar) :: IO (Either IOError Char)
--              case res of
--                 Left err   -> return (Left (show err))
--                 Right '\n' -> parseIt str tp
--                 Right '\r' -> parseIt str tp
--                 Right ch   -> parseIt xs (Tape l (fromIntegral $ ord ch) r)
--     '['    | c == 0    -> case skipLoop 1 xs of 
--                                Just skipRes -> parseIt skipRes tp
--                                Nothing      -> return (Left "Unmatched bracket")
--            | otherwise -> parseIt xs tp
--     -- ']' -> undefined
--     _  -> return (Left "Unknown symbol")


-- skipLoop :: Int -> String -> Maybe String
-- skipLoop 0 str = Just str
-- skipLoop _ []  = Nothing
-- skipLoop n (x:xs)
--     | x == '['  = skipLoop (n+1) xs
--     | x == ']'  = skipLoop (n-1) xs
--     | otherwise = skipLoop n xs