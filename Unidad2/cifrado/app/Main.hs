{-# LANGUAGE OverloadedStrings #-}

module Main where

import Crypto.Cipher.AES (AES128)
import Crypto.Cipher.Types (BlockCipher(..), Cipher(..), IV, makeIV, cipherInit, ctrCombine)
import Crypto.Error (CryptoFailable(..))
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as C
import Data.ByteArray (convert)

-- INICIALIZA EL CIFRADO 
initAES :: B.ByteString -> AES128
initAES key = case cipherInit key of
    CryptoFailed err -> error (show err)
    CryptoPassed aes -> aes

-- CIFRADO
encryptAES :: AES128 -> B.ByteString -> B.ByteString
encryptAES aes plaintext =
    let Just iv = makeIV (B.replicate 16 0) in ctrCombine aes iv plaintext

-- DECIFRADO
decryptAES :: AES128 -> B.ByteString -> B.ByteString
decryptAES = encryptAES  

main :: IO ()
main = do
    putStrLn "Ingrese el texto a cifrar:"
    entrada <- getLine 
    let key = C.pack "1234567890123456" 
        plaintext = C.pack entrada
        aes = initAES key
        ciphertext = encryptAES aes plaintext
        decryptedText = decryptAES aes ciphertext

    putStrLn $ "Texto original: " ++ C.unpack plaintext
    putStrLn $ "Texto cifrado: " ++ show ciphertext
    putStrLn $ "Texto descifrado: " ++ C.unpack decryptedText
