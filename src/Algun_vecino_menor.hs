import Data.Array

-- ---------------------------------------------------------------------
-- Ejercicio 4. Las matrices puede representarse mediante tablas cuyos
-- índices son pares de números naturales:    
--    type Matriz = Array (Int,Int) Int
-- Definir la función 
--    algunMenor :: Matriz -> [Int]
-- tal que (algunMenor p) es la lista de los elementos de p que tienen
-- algún vecino menor que él. Por ejemplo,  
--    algunMenor (listArray ((1,1),(3,4)) [9,4,6,5,8,1,7,3,4,2,5,4])
--    [9,4,6,5,8,7,4,2,5,4]          
-- pues sólo el 1 y el 3 no tienen ningún vecino menor en la matriz
--    |9 4 6 5|
--    |8 1 7 3|
--    |4 2 5 4|
-- ---------------------------------------------------------------------        

type Matriz = Array (Int,Int) Int

algunMenor :: Matriz -> [Int]
algunMenor p = 
    [p!(i,j) | (i,j) <- indices p,
               or [p!(a,b) < p!(i,j) | (a,b) <- vecinos (i,j)]] 
    where (_,(m,n)) = bounds p
          vecinos (i,j) = [(a,b) | a <- [max 1 (i-1)..min m (i+1)],
                                   b <- [max 1 (j-1)..min n (j+1)],
                                   (a,b) /= (i,j)]
