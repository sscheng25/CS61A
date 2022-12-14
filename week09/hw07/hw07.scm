(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cdr (cdr s)))
)

(define (sign x)
  (cond
      ((< x 0) -1)
      ((= x 0) 0)
      ((> x 0) 1))
)

(define (square x) (* x x))

(define (pow b n)
  (cond
      ((= n 1) b)
      ((= n 2) (square b))
      (else
          (if (even? n) 
              (square (pow b (quotient n 2)))
              (* b (* (pow b (quotient (- n 1) 2)) (pow b (quotient (- n 1) 2))))
          )
      ) 
  )
)

(define (ordered? s)
  (if (or (null? (cdr s)) (null? s))
      true
      (if (> (car s) (car (cdr s)))
          false
          (ordered? (cdr s)))
      
  )
)

(define (empty? s) (null? s))

(define (add s v)
    (if (empty? s)
        (list v)
        (if (= (car s) v)
            s
            (if (> (car s) v)
                (cons v s)
                (cons (car s) (add (cdr s) v))
            )
        )
    )
)

; Sets as sorted lists
(define (contains? s v)
    (if (empty? s)
        false
        (if (> (car s) v)
            false
            (if (= (car s) v)
                true
                (contains? (cdr s) v)
            )     
        )
    )
)

; Equivalent Python code, for your reference:
;
; def empty(s):
;     return s is Link.empty
;
; def contains(s, v):
;     if empty(s):
;         return False
;     elif s.first > v:
;         return False
;     elif s.first == v:
;         return True
;     else:
;         return contains(s.rest, v)

(define (intersect s t)
    (if (or (empty? s) (empty? t))
        (list)
        (cond
            ((= (car s) (car t)) (cons (car s) (intersect (cdr s) (cdr t))))
            ((< (car s) (car t)) (intersect (cdr s) t))
            (else (intersect s (cdr t)))
        )
    )
  )

; Equivalent Python code, for your reference:
;
; def intersect(set1, set2):
;     if empty(set1) or empty(set2):
;         return Link.empty
;     else:
;         e1, e2 = set1.first, set2.first
;         if e1 == e2:
;             return Link(e1, intersect(set1.rest, set2.rest))
;         elif e1 < e2:
;             return intersect(set1.rest, set2)
;         elif e2 < e1:
;             return intersect(set1, set2.rest)

(define (union s t)
    (cond
      ((empty? s) t)
      ((empty? t) s)
      (else
          (cond
              ((= (car s) (car t)) (cons (car s) (union (cdr s) (cdr t))))
              ((< (car s) (car t)) (cons (car s) (union (cdr s) t)))
              (else (cons (car t) (union s (cdr t))))
          )
      )
    )
)

; def union(s1, s2):
;     if(empty(s1)):
;         return s2
;     elif(empty(s2)):
;         return s1
;     else:
;         e1, e2 = set1.first, set2.first
;         if e1 == e2:
;             return Link(e1, union(set1.rest, set2.rest))
;         elif e1 < e2:
;             return Link(e1, union(set1.rest, set2))
;         elif e2 < e1:
;             return Link(e2, union(set1, set2.rest))
