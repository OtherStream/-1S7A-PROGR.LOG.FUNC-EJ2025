import System.IO (hFlush, stdout)

-- Lista de números del 0 al 9 en español
unidades :: [String]
unidades = ["Cero", "Uno", "Dos", "Tres", "Cuatro", "Cinco", "Seis", "Siete", "Ocho", "Nueve"]

-- Lista de números del 10 al 19 en español
decenasDiez :: [String]
decenasDiez = ["Diez", "Once", "Doce", "Trece", "Catorce", "Quince",
         "Dieciséis", "Diecisiete", "Dieciocho", "Diecinueve"]

-- Lista de múltiplos de 10 en español
decenas :: [String]
decenas = ["", "", "Veinte", "Treinta", "Cuarenta", "Cincuenta",
        "Sesenta", "Setenta", "Ochenta", "Noventa"]

-- Lista de centenas en español
centenas :: [String]
centenas = ["", "Cien", "Doscientos", "Trescientos", "Cuatrocientos",
            "Quinientos", "Seiscientos", "Setecientos", "Ochocientos", "Novecientos"]

-- Función para verificar si un número es primo
primo :: Int -> Bool
primo n 
    | n < 2     = False
    | otherwise = null [x | x <- [2..floor (sqrt (fromIntegral n))], n `mod` x == 0]

-- Convierte un número en su representación en español con correcciones
numeroEnPalabras :: Int -> String
numeroEnPalabras n
    | n == 1000000 = "Un millón"
    | n < 10       = unidades !! n
    | n < 20       = decenasDiez !! (n - 10)
    | n < 100      =
        let (d, u) = n `divMod` 10
        in if u == 0 then decenas !! d else decenas !! d ++ " y " ++ numeroEnPalabras u
    | n < 1000     =
        let (c, r) = n `divMod` 100
            centena = if c == 1 && r > 0 then "Ciento" else centenas !! c
        in if r == 0 then centena else centena ++ " " ++ numeroEnPalabras r
    | n < 2000     = "Mil" ++ if n `mod` 1000 /= 0 then " " ++ numeroEnPalabras (n `mod` 1000) else ""
    | n < 1000000  =
        let (m, r) = n `divMod` 1000
            miles = if m == 1 then "Mil" else numeroEnPalabras m ++ " mil"
        in if r == 0 then miles else miles ++ " " ++ numeroEnPalabras r
    | otherwise = show n 

-- Ajuste de "uno" a "un" cuando sea necesario
uno :: String -> String
uno frase = unwords (ajustarPalabras (words frase))
  where
    ajustarPalabras [] = []
    ajustarPalabras (x:y:xs)
        | x == "Uno" && (y == "mil" || y == "millón" || y == "millones") = "Un" : ajustarPalabras (y:xs)
        | otherwise = x : ajustarPalabras (y:xs)
    ajustarPalabras [x] = [x]

-- Función principal que decide la salida según si es primo o no
fizzBuzz :: Int -> String
fizzBuzz n 
    | primo n = "FizzBuzz!"
    | otherwise = uno (numeroEnPalabras n)

-- Contenedor principal
main :: IO ()
main = do
    putStr "Ingresa un número: "
    hFlush stdout  
    input <- getLine
    let numero = read input :: Int
    putStrLn $ fizzBuzz numero
