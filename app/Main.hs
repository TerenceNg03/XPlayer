module Main (main) where

import Lib

import Foreign.C.Types
foreign import ccall "runGUI" runGUI :: CInt -> IO ()

main :: IO ()
main = runGUI 100
