;2.17
(define (last-pair l)
  (if (null? (cdr l))
    (car l)
    (last-pair (cdr l))))
(last-pair (list 23 72 149 34))
;2.18
(define (reverse l)
  (define (iter forward rev)
    (if (null? forward)
      rev
      (iter (cdr forward) (cons (car forward) rev))))
  (iter l nil))
(define (reverse l)
  (if (null? (cdr l))
    l
    (append (reverse (cdr l)) (list (car l)))))
(reverse (list 1 4 9 16 25))
;2.19
(define (count-change amount)
  (cc amount (list 50 25 10 5 1)))
(define (cc amount coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (null? coins)) 0)
        (else (+ (cc amount
                     (cdr coins))
                 (cc (- amount
                        (first-denomination coins))
                     coins)))))
(define (no-more? coins) (null? coins))
(define (first-denomination kinds-of-coins)
  (car kinds-of-coins))
(cc 100 (list 1 5 10 25 50))

;2.20
(define (same-parity x . more)
  (define (filter f l)
    (cond
      ((null? l) l)
      ((f (car l)) (cons (car l) (filter f (cdr l))))
      (else (filter f (cdr l)))))
  (if (even? x)
    (cons x (filter even? more))
    (cons x (filter odd? more))))
(same-parity 1 2 3 4 5 6)

;2.21
(define (square-list items)
  (if (null? items)
    nil
    (cons (square (car items)) (square-list (cdr items)))))
(define (square-list items)
  (map square items))

;2.23
(define (for-each f l)
  (if (null? l)
    nil
    (f l)
    (for-each f (cdr l))))
(for-each (lambda (x) (newline) (display x))
                    (list 57 321 88))

(define (count-leaves x)
  (cond ((null? x) 0)  
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))
;2.24
(list 1 (list 2 (list 3 4)))
;2.25 
(define input (list 1 3 (list 5 7) 9))
(car (cdr (car (cdr (cdr input)))))
(define input (list (list 7)))
(car (car input))
(define input (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr input))))))))))))
;2.26
(define x (list 1 2 3))
(define y (list 4 5 6))
(append x y)
(cons x y)
(list x y)

;2.27
(define (reverse l)
  (define (iter forward rev)
    (if (null? forward)
      rev
      (iter (cdr forward) (cons (car forward) rev))))
  (iter l nil))
(define (reverse l)
  (if (null? (cdr l))
    l
    (append (reverse (cdr l)) (list (car l)))))
(define (deep-reverse x)
  (cond
    ((not (pair? x)) (list x))
    ((null? (cdr x)) (deep-reverse (car x)))
    ((pair? (car x)) (cons (deep-reverse (cdr x)) (deep-reverse (car x))))
    (else (append (deep-reverse (cdr x)) (list (car x))))))
(define (deep-reverse x)
  (if (pair? x)
    (reverse (map deep-reverse x))
    x))
(define x (list (list 1 2) (list 3 4)))
x
(reverse x)
(deep-reverse x)

;2.28
(define (fringe x)
  (cond
    ((not (pair? x)) (list x))
    ((null? (cdr x)) (fringe (car x)))
    (else (append (fringe (car x)) (fringe (cdr x))))))
(define x (list (list 1 2) (list 3 4)))
(fringe x)
(fringe (list x x))

;2.29
(define (make-mobile left right)
    (cons left right))
(define (make-branch length structure)
    (cons length structure))
(define (len branch)
  (car branch))
(define (str branch)
  (cdr branch))
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cdr mobile))
(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))
(define (branch-weight b)
  (let ((s (str b)))
    (if (number? s)
      s
      (total-weight s))))
(define (balance-weight balanced weight)
  (cons balanced weight))
(define (balance bw)
  (car bw))
(define (weight bw)
  (cdr bw))
(define (balanced? m)
  (if (number? m)
    #t
    (let ((l (left-branch m))
          (r (right-branch m)))
      (let ((ll (len l))
            (ls (str l))
            (rl (len r))
            (rs (str r)))
        (and
          (= 
            (* ll (branch-weight l))
            (* rl (branch-weight r)))
          (balanced? ls)
          (balanced? rs))))))
;2.29 without the extra calculations
(define (get-bw m)
  (if (number? m)
    (balance-weight #t m)
    (let ((l (left-branch m))
          (r (right-branch m)))
      (let ((lbw (get-bw (str l)))
            (ll (len r))
            (rbw (get-bw (str r)))
            (rl (len r)))
        (balance-weight
          (and
            (balance lbw)
            (balance rbw)
            (=
              (* ll (weight lbw))
              (* rl (weight rbw))))
          (+ (weight lbw) (weight rbw)))))))
(define (balanced? m)
  (balance (get-bw m)))
(define (total-weight m)
  (weight (get-bw m)))
(define a (make-mobile (make-branch 2 3) (make-branch 2 3)))
a
(define b (make-mobile (make-branch 2 3) (make-branch 4 5)))
b
(total-weight a)
(total-weight b)
(balanced? a)
(balanced? b)
(define c (make-mobile (make-branch 5 a) (make-branch 3 b)))
c
(total-weight c)
(balanced? c)

;2.30
(define (square x) (* x x))
(define (square-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))
(define (square-tree tree)
  (map
    (lambda (subtree)
      (if (pair? subtree)
        (square-tree subtree)
        (square subtree)))
    tree))
;2.31
(define (tree-map f tree)
  (map
    (lambda (subtree)
      (if (pair? subtree)
        (tree-map f subtree)
        (f subtree)))
    tree))
(define (square-tree tree) (tree-map square tree))
(square-tree
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))

;2.32
(define (subsets s)
  (if (null? s)
    (list nil)
    (let ((rest (subsets (cdr s))))
      (append rest (map
                     (lambda (r) (append (list (car s)) r))
                     rest)))))
(subsets (list 1 2 3))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))
(define (enumerate-interval low high)
  (if (> low high)
    nil
    (cons low (enumerate-interval (+ low 1) high))))
(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))
;2.33
(define (map p sequence)
    (accumulate
      (lambda (x y) (cons (p x) y))
      nil
      sequence))
(map even? (list 1 2 3 4))
(define (append seq1 seq2)
    (accumulate cons seq2 seq1))
(append (list 1 2 3 4) (list 5 6 7 8))
(define (length sequence)
    (accumulate (lambda (x y) (+ 1 y)) 0 sequence))
(length (list 1 2 3))

;2.34
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))
(horner-eval 2 (list 1 3 0 5 0 1))

;2.35
(define (count-leaves t)
  (accumulate
    +
    0
    (map
      (lambda (subtree) (if (pair? subtree) (count-leaves subtree) 1))
      t)))
(count-leaves (list 5 (list 4 5) (list 1 (list 1))))

;2.36
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    nil
    (cons (accumulate op init (map car seqs))
          (accumulate-n op init (map cdr seqs)))))
(accumulate-n + 0 (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))

;2.37
(define (dot-product v w)
  (accumulate + 0 (map * v w)))
(define (matrix-*-vector m v)
  (map (lambda (r) (dot-product r v)) m))
(define (transpose mat)
  (accumulate-n cons nil mat))
; didn't get this one on my own
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (v) (matrix-*-vector cols v)) m)))

;2.38
(define (fold-right op initial sequence)
  (accumulate op initial sequence))
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter initial sequence))
(fold-right / 1 (list 1 2 3))
(fold-left / 1 (list 1 2 3))
(fold-right list nil (list 1 2 3))
(fold-left list nil (list 1 2 3))
; (= (op a b) (op b a))
;2.39
(define (reverse sequence)
  (fold-right (lambda (x y) (append y (list x))) nil sequence))
(reverse (list 1 2 3 4))
(define (reverse sequence)
  (fold-left (lambda (x y) (append (list y) x)) nil sequence))
(reverse (list 1 2 3 4))

;2.40
(define (flatmap proc seq)
    (accumulate append nil (map proc seq)))
(define (unique-pairs n)
  (flatmap
    (lambda (i)
      (map (lambda (j) (list i j))
           (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs n))))

;2.41
(define (ordered-triples n)
  (flatmap
    (lambda (i)
      (flatmap
        (lambda (j)
          (map
            (lambda (k) (list i j k))
            (enumerate-interval 1 (- j 1))))
        (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))
(define (triple-sum n s)
  (filter
    (lambda (t)
      (= s (fold-right + 0 t)))
    (ordered-triples n)))
(triple-sum 10 8)

;2.42
(define (queens board-size)
  (define (make-position row col) (cons row col))
  (define (row pos) (car pos))
  (define (col pos) (cdr pos))
  (define (in-line? p1 p2)
    (let ((r1 (row p1))
          (r2 (row p2))
          (c1 (col p1))
          (c2 (col p2)))
      (or
        (= r1 r2)
        (=
          (- c1 c2)
          (abs (- r1 r2))))))
  (define (safe? k positions)
    (let ((new (car positions)))
      (fold-left
        (lambda (a b) (and a b))
        #t 
        (map
          (lambda (position)
            (if (null? position)
              #t
              (not
                (in-line? new position))))
          (cdr positions)))))
  (define (adjoin-position new-row k rest-of-queens)
    (cons (make-position new-row k) rest-of-queens))
  (define (empty-board) (list nil))
  (define (queen-cols k)  
    (if (= k 0)
      (list nil)
      (filter
        (lambda (positions) (safe? k positions))
        (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))
(length (queens 8))


