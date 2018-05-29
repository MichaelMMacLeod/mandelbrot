(defun mandelbrot (z m n c)
  (if (or (>= (abs z) 2) (= n m))
    n
    (mandelbrot (+ (* z z) c) m (1+ n) c)))

(defun escapeTime (c)
  (mandelbrot 0 1000 0 c))

(defun toChar (n)
  (elt "$@B%8&WM#*|1?-+~i!I:,'. " (mod n 24)))

(loop for bi from -2 to 2 by 0.05
      do (loop for a from -2 to 2 by 0.05
               do (princ (toChar (escapeTime (complex a bi)))))
      do (terpri))
