module Main where

import Bowling  -- Importamos todo el módulo Bowling

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  let frames = toFrames [3, 6, 7, 2, 10, 4, 5]  -- Lista de tiros
  print frames
