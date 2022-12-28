;; Extra Scheme Questions ;;


; Q5
(define lst
  (cons (cons 1 nil)
        (cons 2
              (cons (cons 3 (cons 4 nil))
                    (cons 5 nil))))
)

; Q6
(define (composed f g)
    (define (helper x) (f (g x)))
    helper
)

; Q7
(define (remove item lst)
  (if (null? lst)
      ()
      (if (= item (car lst))
          (remove item (cdr lst))
          (cons (car lst) (remove item (cdr lst)))
      )
  )
)


;;; Tests
(remove 3 nil)
; expect ()
(remove 3 '(1 3 5))
; expect (1 5)
(remove 5 '(5 3 5 5 1 4 5 4))
; expect (3 1 4 4)

; Q8
(define (no-repeats s)
    (if (null? s)
        ()
        (
         cons (car s) (no-repeats (remove (car s) (cdr s)))
        )
    )
)

; Q9
(define (substitute s old new)
  'YOUR-CODE-HERE
)

; Q10
(define (sub-all s olds news)
  'YOUR-CODE-HERE
)

 ; (cons (cons 1 nil) (cons 2  (cons (cons 3 (cons 4 nil))  (cons 5 nil))))