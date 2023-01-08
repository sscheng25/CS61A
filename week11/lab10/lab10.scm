;; Scheme ;;

(define (repeatedly-cube n x)
    (if (zero? n)
        x
        (let
            ((y (repeatedly-cube (- n 1) x)))
            (* y y y))))

; (1 2 3)
; (1 (2 (3)))
; (1 (2 3))
; (1 (2 . 3))
; (1 2 3)
; ((1) 2 3 4)