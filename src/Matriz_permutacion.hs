-- Matriz_permutacion.hs
-- Matriz permutación.
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 12 de Julio de 2014
-- ---------------------------------------------------------------------

-- Una [matriz permutación](http://bit.ly/TZy6F9) es una matriz cuadrada
-- con todos sus elementos iguales a 0, excepto uno cualquiera por cada
-- fila y columna, el cual debe ser igual a 1. 

-- --------------------------------------------------------------------- 
-- En este ejercicio se usará el tipo de las matrices definido por
--    type Matriz a = Array (Int,Int) a
-- y los siguientes ejemplos de matrices
--    q1, q2, q3,q4 :: Matriz Int
--    q1 = array ((1,1),(2,2)) [((1,1),1),((1,2),0),((2,1),0),((2,2),1)]
--    q2 = array ((1,1),(2,2)) [((1,1),0),((1,2),1),((2,1),0),((2,2),1)]
--    q3 = array ((1,1),(2,2)) [((1,1),3),((1,2),0),((2,1),0),((2,2),1)]
--    q4 = array ((1,1),(2,2)) [((1,1),1),((1,2),3),((2,1),0),((2,2),1)]
--
-- Definir la función
--    esMatrizPermutacion :: Num a => Matriz a -> Bool
-- tal que (esMatrizPermutacion p) se verifica si p es una matriz
-- permutación. Por ejemplo.
--    esMatrizPermutacion q1  ==  True
--    esMatrizPermutacion q2  ==  False
--    esMatrizPermutacion q3  ==  False
-- ---------------------------------------------------------------------

import Data.Array

type Matriz a = Array (Int,Int) a

q1, q2, q3, q4 :: Matriz Int
q1 = array ((1,1),(2,2)) [((1,1),1),((1,2),0),((2,1),0),((2,2),1)]
q2 = array ((1,1),(2,2)) [((1,1),0),((1,2),1),((2,1),0),((2,2),1)]
q3 = array ((1,1),(2,2)) [((1,1),3),((1,2),0),((2,1),0),((2,2),1)]
q4 = array ((1,1),(2,2)) [((1,1),1),((1,2),3),((2,1),0),((2,2),1)]

esMatrizPermutacion :: (Num a, Eq a) => Matriz a -> Bool
esMatrizPermutacion p = 
    and [esListaUnitaria [p!(i,j) | i <- [1..n]] | j <- [1..n]] &&
    and [esListaUnitaria [p!(i,j) | j <- [1..n]] | i <- [1..n]] 
    where (_,(n,_)) = bounds p

-- (esListaUnitaria xs) se verifica si xs tiene un 1 y los restantes
-- elementos son 0. Por ejemplo,
--    esListaUnitaria [0,1,0,0]  ==  True
--    esListaUnitaria [0,1,0,1]  ==  False
--    esListaUnitaria [0,2,0,0]  ==  False
esListaUnitaria :: (Num a, Eq a) => [a] -> Bool
esListaUnitaria xs = [x | x <- xs, x /= 0] == [1]

-- ---------------------------------------------------------------------
-- § Soluciones de los alumnos                                        --
-- ---------------------------------------------------------------------

-- Eduardo (incorresta)
-- ====================

esMatrizPermutacionA1 p = 
    and [columna b p | b <- [1..numColumnas p]] && 
    and [fila a p | a<- [1..numFilas p]] 

columna b p = length [c | ((a,j),c) <- assocs p, b == j , c == 1] == 1

fila a p = length [c | ((i,b),c) <- assocs p, i == a, c == 1] == 1

numFilas p = fst (snd (bounds p))

numColumnas p = snd (snd (bounds p))

-- Eduardo
-- =======

esMatrizPermutacionA2 p = 
    and [columna1 b p | b <- [1..numColumnasA2 p]] && 
    and [fila1 a p | a <- [1..numFilasA2 p]] 

columna1 b p = 
    length [c | ((a,j),c) <- assocs p, b == j, c /=0 ] == 1 && 
    all (==1) [c | ((a,j),c) <- assocs p, b == j, c /= 0]

fila1 a p = 
    length [c | ((i,b),c) <- assocs p, i == a, c /= 0]== 1 && 
    all (==1) [c | ((i,b),c) <- assocs p, i == a, c /= 0]

numFilasA2 p = fst (snd (bounds p))

numColumnasA2 p = snd (snd (bounds p))

-- ---------------------------------------------------------------------
-- § Verificación                                                     --
-- ---------------------------------------------------------------------

verifica f =
    esMatrizPermutacion q1  ==  True  &&
    esMatrizPermutacion q2  ==  False &&
    esMatrizPermutacion q3  ==  False
    where esMatrizPermutacion = f
