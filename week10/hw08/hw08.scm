; Q1: Reverse

(define (reverse lst)
    (if (null? lst)
        ()
        (if (null? (cdr lst))
            ;(cons (car (cdr lst)) (car lst))
            lst
            (append (reverse (cdr lst)) (list (car lst)))
        )
    )
)

; Q2: Longest increasing subsequence

(define (longest-increasing-subsequence lst)
    (define (helper ls prev)
        (cond
            ((null? ls) nil)
            ((<= (car ls) prev) (helper (cdr ls) prev))
            (else
              
                (define first (append (list (car ls)) (helper (cdr ls) (car ls)) ))
                (define no-first (helper (cdr ls) prev) )
                (
                  if (> (length first) (length no-first))
                     first
                     no-first
                )

              
              
            )

        )
    )

    (helper lst 0)
)


; a wrong version, didn't find the bug, full of headache
(define (longest-increasing-subsequence lst)
    (define f-lst (filter (lambda (x) (> x (car lst))) lst) )
    (if (null? lst)
        ()
        (if (null? (cdr lst))
            lst
            (
             (if (= (length f-lst) 0)
                (list (car lst))
                (if (= (length f-lst) 1)
                    (append (list (car lst)) f-lst)
                    (append (list (car lst)) (longest-increasing-subsequence f-lst) )

                )
             
             )
            )
        )
    )
)


(define (cadr s) (car (cdr s)))
(define (caddr s) (cadr (cdr s)))


; derive returns the derivative of EXPR with respect to VAR
(define (derive expr var)
  (cond ((number? expr) 0)
        ((variable? expr) (if (same-variable? expr var) 1 0))     ; 'li is a symbol/variable
        ((sum? expr) (derive-sum expr var))                       ; (list '+ 1 3 3) is true for sum?
        ((product? expr) (derive-product expr var))
        ((exp? expr) (derive-exp expr var))
        (else 'Error)))

; Variables are represented as symbols
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

; Numbers are compared with =
(define (=number? expr num)
  (and (number? expr) (= expr num)))

; Sums are represented as lists that start with +.
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))
(define (sum? x)
  (and (list? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s) (caddr s))

; Products are represented as lists that start with *.
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))
(define (product? x)
  (and (list? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))

(define (derive-sum expr var)
    (make-sum 
        (derive (addend expr) var)
        (derive (augend expr) var)
    )
)

(define (derive-product expr var)
    (make-sum
        (make-product (derive (multiplier expr) var) (multiplicand expr))
        (make-product (derive (multiplicand expr) var) (multiplier expr))
    )
)

; Exponentiations are represented as lists that start with ^.
(define (make-exp base exponent)
    (cond
        ((= exponent 0) 1)
        ((= exponent 1) base)
        ((number? base) (* base (make-exp base (- exponent 1))))
        (else (list '^ base exponent))
    )
)

(define (base exp)
   (cadr exp)
)

(define (exponent exp)
   (caddr exp)
)

(define (exp? exp)
    (and (list? exp) (eq? (car exp) '^))
    ; (and (number? (exponent exp))(> (exponent exp) 0))
   
)

(define x^2 (make-exp 'x 2))
(define x^3 (make-exp 'x 3))

(define (derive-exp exp var)
    (make-product
        (exponent exp)
        (make-exp (base exp) (- (exponent exp) 1))
    )
)