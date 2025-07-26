module Tape 
    ( Tape(..)
    , initTape
    , moveTapeLeft
    , moveTapeRight
    , incrementTape
    , decrementTape
    , printCell
    ) where


import Data.Word (Word8)


data Tape = Tape [Word8] Word8 [Word8]


initTape :: Tape
initTape = Tape (repeat 0) 0 (repeat 0)


moveTapeLeft :: Tape -> Tape
moveTapeLeft (Tape l c (r:rs)) = Tape (c:l) r (rs)
moveTapeLeft _ = undefined


moveTapeRight :: Tape -> Tape
moveTapeRight (Tape (l:ls) c r) = Tape ls l (c:r)
moveTapeRight _ = undefined


incrementTape :: Tape -> Tape
incrementTape (Tape l c r) = Tape l (c+1) r


decrementTape :: Tape -> Tape
decrementTape (Tape l c r) = Tape l (c-1) r


printCell :: Tape -> IO ()
printCell (Tape _ c _) = putStrLn $ show c