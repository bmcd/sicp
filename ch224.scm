; couldn't get it to work well, just doing it blind
(define (up-split painter n)
  (if (= n 0)
    painter
    (let ((smaller (up-split (- n 1))))
      (below painter (beside smaller smaller)))))

(define right-split (split beside below))
(define up-split (split below beside))
(define (split t1 t2)
  (lambda (painter n)
    (if (= n 0)
      painter
      (let ((smaller ((split t1 t2) painter (- n 1))))
            (t1 painter (t2 smaller smaller))))))

