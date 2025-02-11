ifEntoncesSiNo :: Bool -> a -> a -> a
ifEntoncesSiNo condicion valorSi valorNo =
    case condicion of
        True -> valorSi
        False -> valorNo    

fizzbuzz :: Int -> String
fizzbuzz n
    | n `mod` 15 == 0 = "FizzBuzz!"
    | n `mod` 3 == 0  = "Fizz!"
    | n `mod` 5 == 0  = "Buzz!"
    | otherwise       = numeroEnPalabras n

menorQue20 :: Int -> String           
menorQue20 n
    | n > 0 && n < 20 = 
        let respuestas = words ("one two three four five six seven eight nine ten " ++
                                "eleven twelve thirteen fourteen fifteen sixteen " ++
                                "seventeen eighteen nineteen")
        in respuestas !! (n - 1) 
    | otherwise = ""

decenas :: Int -> String
decenas n 
    | n >= 2 && n <= 9 =
        let respuestas = words "twenty thirty forty fifty sixty seventy eighty ninety"
        in respuestas !! (n - 2)
    | otherwise = ""

numeroEnPalabras :: Int -> String
numeroEnPalabras n 
    | n > 0 && n < 20 = menorQue20 n
    | n `mod` 10 == 0 && n < 100  = decenas (n `div` 10)
    | n < 100 = decenas (n `div` 10) ++ "-" ++ menorQue20 (n `mod` 10)
    | n == 100 = "one hundred"
    | otherwise = show n

main :: IO ()
main = do
    putStrLn "Ingrese un número límite:"
    entrada <- getLine
    let numero = read entrada :: Int
    mapM_ (putStrLn . fizzbuzz) [1..numero]
