-- MaximosLocales.hs
-- Máximos locales.
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 29 de Abril de 2014
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Un máximo local de una lista es un elemento de la lista que es mayor
-- que su predecesor y que su sucesor en la lista. Por ejemplo, 5 es un
-- máximo local de [3,2,5,3,7,7,1,6,2] ya que es mayor que 2 (su
-- predecesor) y que 3 (su sucesor).
-- 
-- Definir la función
--    maximosLocales :: Ord a => [a] -> [a]
-- tal que (maximosLocales xs) es la lista de los máximos locales de la
-- lista xs. Por ejemplo,
--    maximosLocales [3,2,5,3,7,7,1,6,2]  ==  [5,6]
--    maximosLocales [1..100]             ==  []
--    maximosLocales "adbpmqexyz"         ==  "dpq"
-- ---------------------------------------------------------------------

import Test.HUnit                     -- Para la verificación

-- 1ª definición (por recursión):
maximosLocales1 :: Ord a => [a] -> [a]
maximosLocales1 (x:y:z:xs) | y > x && y > z = y : maximosLocales1 (z:xs)
                           | otherwise      = maximosLocales1 (y:z:xs)
maximosLocales1 _                           = []

-- 2ª definición (por comprensión):
maximosLocales2 :: Ord a => [a] -> [a]
maximosLocales2 xs = 
    [y | (x,y,z) <- zip3 xs (tail xs) (drop 2 xs), y > x, y > z]

-- ---------------------------------------------------------------------
-- § Soluciones de los alumnos                                        --
-- ---------------------------------------------------------------------

-- Luis Fernando
maximosLocalesA1 :: Ord a => [a] -> [a]
maximosLocalesA1 xs = 
    [y | ((x,y),z) <- zip (zip xs (tail xs)) (drop 2 xs), y > x, y > z]

-- Laura Prieto
maximosLocalesA2 :: Ord a => [a] -> [a]
maximosLocalesA2 xs = [b | [a,b,c] <- ternas xs, a < b, b > c]
    where ternas xs = [take 3 (drop n xs) | n <- [0..length xs -3]]

-- David Argulló
maximosLocalesA3 :: Ord a => [a] -> [a]
maximosLocalesA3 [] = []
maximosLocalesA3 [x]= []
maximosLocalesA3 [x,y]=[]
maximosLocalesA3 (x:y:z:xs) | x<y && z<y = y:maximosLocalesA3 (z:xs)
                            | otherwise  = maximosLocalesA3 (y:z:xs)

-- ---------------------------------------------------------------------
-- § Verificación                                                     --
-- ---------------------------------------------------------------------

maximosLocales :: Ord a => [a] -> [a]
maximosLocales = maximosLocalesA3

ejemplos :: Test
ejemplos =
    test ["1" ~: "maximosLocales [3,2,5,3,7,7,1,6,2]" ~: 
          maximosLocales [3,2,5,3,7,7,1,6,2]  ~?=  [5,6],
          "3" ~: "maximosLocales [1..100]" ~: 
          maximosLocales [1..100]             ~?=  [],
          "3" ~: "maximosLocales \"adbpmqexyz\"" ~: 
          maximosLocales "adbpmqexyz"         ~?=  "dpq"]

verifica = runTestTT ejemplos

-- Verificación:
--    ghci> verifica 
--    Cases: 2  Tried: 2  Errors: 0  Failures: 0
--    Counts {cases = 2, tried = 2, errors = 0, failures = 0}
