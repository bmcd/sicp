(define (f1-11 n)
  (if (< n 3)
    n
    (+
      (f1-11 (- n 1))
      (* 2 (f1-11 (- n 2)))
      (* 3 (f1-11 (- n 3)))
      )
    )
  )
(define (f1-11 n)
  (define (iter a b c count)
    (if (= count 0)
      c
      (iter
	(+ a (* 2 b) (* 3 c))
	a
	b
	(- count 1))))
  (iter 2 1 0 n)
  )
(f1-11 2)
(f1-11 3)
(f1-11 4)
(f1-11 5)
(f1-11 6)
(f1-11 7)

1
11
121
1331
14641
(define (pascal row column)
  (cond
    ((or (> column row) (< column 0)) 0)
    ((or (= row column) (= column 0)) 1)
    (else (+
	    (pascal (- row 1) (- column 1))
	    (pascal (- row 1) column)
	    )
	  )
    )
  )
(pascal 0 0)
(pascal 0 1)
(pascal 3 3)
(pascal 3 2)
(pascal 4 2)

(define (expt-old b n)
    (if (= n 0) 1 (* b (expt b (- n 1)))))
(define (expt b n)
  (expt-iter b n 1))
(define (expt-iter b counter product)
  (if (= counter 0)
    product
    (expt-iter b (- counter 1) (* b product))))
(define (even? n)
  (= (remainder n 2) 0))
(define (fast-expt b n)
  (cond
    ((= n 0) 1)
    ((even? n) (square (fast-expt b (/ n 2))))
    (else (* b (fast-expt b (- n 1))))))
(fast-expt 2 16)

(define (fast-expt-iter b n)
  (define (iter b n a)
    (if (= n 0)
      a
      (if (even? n)
	(iter (square b) (/ n 2) a)
	(iter b (- n 1) (* a b))
	)
      )
    )
  (iter b n 1)
  )
(fast-expt-iter 2 16)

(define (double x) (+ x x))
(define (halve x) (/ x 2))
(define (mult-rec a b)
  (cond
    ((= b 0) 0)
    ((even? b) (double (mult-rec a (halve b))))
    (else (+ a (mult-rec a (- b 1)))))
  )
(mult-rec 10 10)
(mult-rec 9 11)
	       
(define (fast-mult a b)
  (define (iter a b current)
    (if (= b 0)
      current
      (if (even? b)
	(iter (double a) (halve b) current)
	(iter a (- b 1) (+ a current))
	)
      )
    )
  (iter a b 0)
  )
(fast-mult 8 9)

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test)
  (cond
    ((> (square test) n) n)
    ((divides? n test) test)
    (else (find-divisor n (+ test 1)))))
(define (divides? n test)
  (= (remainder n test) 0))
(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)

