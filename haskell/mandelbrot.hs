import Data.Complex
import Data.List

main = putStrLn $ intercalate "\n" grid

mandelbrot z m n c 
    | magnitude z >= 2 || n == m = n
    | otherwise = mandelbrot (z * z + c) m (n + 1) c

grid = [[toChar $ escapeTime (a :+ 2 * bi) | a <- bounds_a] | bi <- bounds_bi]
    where
        escapeTime = mandelbrot 0 1000 0
        toChar c   = "$@B%8&WM#*|1?-_+~i!I:,'. " !! (mod c 25)
        bounds_a   = [-2,-1.95..2]
        bounds_bi  = [-2,-1.95..2]
