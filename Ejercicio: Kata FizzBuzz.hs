module FizzBuzz where

ifThenElse :: Bool -> a -> a -> a
ifThenElse cond thenVal elseVal =
    case cond of
        True -> thenVal
        False -> elseVal    

-- Función para la lógica de FizzBuzz
fizzbuzz :: Int -> String
fizzbuzz n
    | n `mod` 15 == 0 = "FizzBuzz!"
    | n `mod` 3 == 0  = "Fizz!"
    | n `mod` 5 == 0  = "Buzz!"
    | otherwise       = number n

-- Números menores a 20 en palabras
lessThan20 :: Int -> String           
lessThan20 n
    | n > 0 && n < 20 = 
        let answers = words ("one two three four five six seven eight nine ten " ++
                             "eleven twelve thirteen fourteen fifteen sixteen " ++
                             "seventeen eighteen nineteen")
        in answers !! (n - 1) 
    | otherwise = ""

-- Decenas en palabras
tens :: Int -> String
tens n 
    | n >= 2 && n <= 9 =
        let answers = words "twenty thirty forty fifty sixty seventy eighty ninety"
        in answers !! (n - 2)
    | otherwise = ""

-- Convertir número a palabras
number :: Int -> String
number n 
    | n > 0 && n < 20 = lessThan20 n
    | n `mod` 10 == 0 && n < 100  = tens (n `div` 10)
    | n < 100 = tens (n `div` 10) ++ "-" ++ lessThan20 (n `mod` 10)
    | n == 100 = "one hundred"
    | otherwise = show n

-- Función principal para ejecutar el programa
main :: IO ()
main = do
    putStrLn "Ingrese un número límite:"
    input <- getLine
    let num = read input :: Int
    mapM_ (putStrLn . fizzbuzz) [1..num]
