-- |
-- Module      : Matriz_Toeplitz
-- Description : Determinación de matrices de Toepliz
-- Copyright   : Exercitium (01-07-14)
-- License     : GPL-3
-- Maintainer  : JoseA.Alonso@gmail.com
-- 
-- Una matriz de Toeplitz es una matriz cuadrada que es constante a lo
-- largo de las diagonales paralelas a la diagonal principal. Por
-- ejemplo,
--
-- >    |2 5 1 6|       |2 5 1 6|          
-- >    |4 2 5 1|       |4 2 6 1|
-- >    |7 4 2 5|       |7 4 2 5|
-- >    |9 7 4 2|       |9 7 4 2|
--
-- la primera es una matriz de Toeplitz y la segunda no lo es. 
-- 
-- Las anteriores matrices se pueden definir por
--
-- >    ej1, ej2 :: Array (Int,Int) Int
-- >    ej1 = listArray ((1,1),(4,4)) [2,5,1,6,4,2,5,1,7,4,2,5,9,7,4,2]
-- >    ej2 = listArray ((1,1),(4,4)) [2,5,1,6,4,2,6,1,7,4,2,5,9,7,4,2]
-- 
-- Definir la función
--
-- >   esToeplitz :: Eq a => Array (Int,Int) a -> Bool
--
-- tal que __(esToeplitz p)__ se verifica si la matriz p es de Toeplitz. Por
-- ejemplo,
--
-- >>> esToeplitz ej1
-- True
-- >>> esToeplitz ej2
-- False

module Matriz_Toeplitz where

import Data.Array

-- | Ejemplos de matrices
ej1, ej2 :: Array (Int,Int) Int
ej1 = listArray ((1,1),(4,4)) [2,5,1,6,4,2,5,1,7,4,2,5,9,7,4,2]
ej2 = listArray ((1,1),(4,4)) [2,5,1,6,4,2,6,1,7,4,2,5,9,7,4,2]

-- | Definición
esToeplitz :: Eq a => Array (Int,Int) a -> Bool
esToeplitz p = m == n && 
               and [p!(i,j) == p!(i+1,j+1) | 
                    i <- [1..n-1], j <- [1..n-1]]
    where (_,(m,n)) = bounds p
