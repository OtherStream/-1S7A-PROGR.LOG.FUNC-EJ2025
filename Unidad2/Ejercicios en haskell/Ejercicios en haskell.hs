import Data.List (genericLength)
import Data.Char (toUpper)
import qualified Data.Map as Map

-- 1.- Aplicar descuento e IVA a precios

aplicarDescuento :: Double -> Double -> Double
aplicarDescuento precio porcentaje = precio * (1 - porcentaje / 100)

aplicarIVA :: Double -> Double -> Double
aplicarIVA precio porcentaje = precio * (1 + porcentaje / 100)

aplicarAProductos :: [(String, Double, Double)] -> (Double -> Double -> Double) -> Double
aplicarAProductos productos funcion = sum [funcion precio porcentaje | (_, precio, porcentaje) <- productos]

-- 2.- Aplicar una función a cada elemento de una lista
aplicarFuncionLista :: (a -> b) -> [a] -> [b]
aplicarFuncionLista f lista = map f lista

-- 3.- Diccionario con palabras y sus longitudes
longitudesPalabras :: String -> [(String, Int)]
longitudesPalabras frase = [(palabra, length palabra) | palabra <- words frase]

-- 4.- Convertir notas en calificaciones
calificarNota :: Double -> String
calificarNota nota
  | nota >= 95 = "Excelente"
  | nota >= 85 = "Notable"
  | nota >= 75 = "Bueno"
  | nota >= 70 = "Suficiente"
  | otherwise  = "Desempeño insuficiente"

calificarAsignaturas :: Map.Map String Double -> Map.Map String String
calificarAsignaturas notas = Map.mapKeys (map toUpper) (Map.map calificarNota notas)

-- 5.- Cálculo del módulo de un vector
moduloVector :: [Double] -> Double
moduloVector vector = sqrt $ sum [x^2 | x <- vector]

-- 6.- Detección de valores atípicos
valoresAtipicos :: [Double] -> [Double]
valoresAtipicos xs = [x | x <- xs, abs (zScore x) > 3]
  where
    media = sum xs / genericLength xs
    desviacion = sqrt $ sum [(x - media)^2 | x <- xs] / genericLength xs
    zScore x = (x - media) / desviacion
