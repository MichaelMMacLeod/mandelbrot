#lang racket

(require racket/gui racket/flonum racket/performance-hint)

(define-inline (mandelbrot c-re c-im max-iterations)
  (define (rec z-re z-im c-re c-im iterations max-iterations)
    (if (or (fl>= (sqrt (fl+ (fl* z-re z-re) (fl* z-im z-im))) 2.0)
            (>= iterations max-iterations))
        iterations
        (rec (fl+ (fl- (fl* z-re z-re) (fl* z-im z-im)) c-re)
          (fl+ (fl* 2.0 (fl* z-re z-im)) c-im)
          c-re
          c-im
          (add1 iterations)
          max-iterations)))
  (rec 0.0 0.0 c-re c-im 0 max-iterations))

(struct argb-color (a r g b))

(define color-table
  (let ([names (send the-color-database get-names)])
    (for/vector ([name (in-list names)])
      (let ([color (make-object color% name)])
        (argb-color (fl->exact-integer (* 255 (send color alpha)))
                    (send color red)
                    (send color green)
                    (send color blue))))))

(define-inline (get-color n)
  (vector-ref color-table (remainder n (vector-length color-table))))

(define-inline (mandelbrot-color c-re c-im max-iterations)
  (get-color (mandelbrot c-re c-im max-iterations)))

(define (colorize width height c-re c-im zoom max-iter)
  (let ([pixels (make-bytes (* 4 width height))])
    (for ([index (in-range (* width height))])
      (let* ([x (remainder index width)]
             [y (quotient index width)]
             [color (mandelbrot-color
                     (fl+ c-re (fl* zoom (fl- (->fl x) (fl/ (->fl width) 2.0))))
                     (fl+ c-im (fl* zoom (fl- (->fl y) (fl/ (->fl height) 2.0))))
                     max-iter)]
             [place (* index 4)])
        (bytes-set! pixels place (argb-color-a color))
        (bytes-set! pixels (+ place 1) (argb-color-r color))
        (bytes-set! pixels (+ place 2) (argb-color-g color))
        (bytes-set! pixels (+ place 3) (argb-color-b color))))
    pixels))

(define mandelbrot-canvas%
  (class canvas%
    (super-new)

    (define c-re 0.0)
    (define c-im 0.0)
    (define zoom 0.0025)
    (define max-iter 50)

    (define (set-focus canvas-x canvas-y width height)
      (set! c-re (fl+ c-re
                      (fl* zoom
                           (fl- (->fl canvas-x)
                                (fl/ (->fl width)
                                     2.0)))))
      (set! c-im (fl+ c-im
                      (fl* zoom
                           (fl- (->fl canvas-y)
                                (fl/ (->fl height)
                                     2.0)))))
      (set! zoom (* zoom 0.5)))

    (define/override (on-event e)
      (if (send e button-down? 'left)
          (begin
            (set-focus (send e get-x)
                       (send e get-y)
                       (send this get-width)
                       (send this get-height))
            (send this refresh))
          (void)))

    (define/override (on-paint)
      (let* ([width (send this get-width)]
             [height (send this get-height)]
             [dc (send this get-dc)]
             [bitmap (make-object bitmap% width height #f #t)]
             [pixels (colorize width height c-re c-im zoom max-iter)])
        (send bitmap set-argb-pixels 0 0 width height pixels)
        (send dc draw-bitmap bitmap 0 0)))))

(define frame (new frame% [label "Mandelbrot set viewer"]
                   [width 500]
                   [height 500]))

(define mandelbrot-canvas
  (new mandelbrot-canvas% [parent frame]))

(send frame fullscreen #f)
(send frame show #t)
