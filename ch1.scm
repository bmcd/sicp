(/
  (+
    5
    4
    (-
      2
      (-
        3
        (+
      	  6
    	  (/ 4 5.0)
    	  )
        )
      )
    )
  (*
    3
    (- 6 2)
    (- 2 7)
    )
  )

(define (square x) (* x x))
(define (sum-of-squares x y) (+ (square x) (square y)))
(define (min x y) (if (< x y) x y))
(define (min-three x y z) (min x (min y z)))
(define (f-one-three x y z)
  (define min-val (min-three x y z))
  (cond
    ((= min-val x) (sum-of-squares y z))
    ((= min-val y) (sum-of-squares x z))
    ((= min-val z) (sum-of-squares x y))
    )
  )
(f-one-three 1 2 3)
(f-one-three 0 0 3)
(f-one-three 1 1 1)

(define (average x y) (/ (+ x y) 2))
(define (improve guess x)
  (average guess (/ x guess))
  )
(define (old-good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
(define (good-enough? guess improved-guess)
  (< (abs (- guess improved-guess)) (* guess 0.001)))
(define (rt-iter guess x improve-function)
  (define improved-guess (improve-function guess x))
  (if (good-enough? guess improved-guess)
    guess
    (rt-iter
      improved-guess
      x
      improve-function)
    )
  )
(square (rt-iter 1.0 0.0000683 improve))
(square (rt-iter 1.0 1200000000000 improve))
(define (improve-cube guess x)
  (/
    (+
      (/ x (square guess))
      (* 2 guess)
      )
    3
    )
  )
(define (cube x) (* x x x))
(cube (rt-iter 1.0 27 improve-cube))
(cube (rt-iter 1.0 8 improve-cube))
