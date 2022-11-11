#lang racket

; Question 1

(define P '((5 0)(2 2)(-3 7)(7 9)))
(define P1 '((15 0)(4 2)(3 4)(4 8)))


; Question 2

(define degreMonome
  (lambda(M)
    (car(cdr M))))

;(degreMonome '(5 4))


; Question 3
(define coefficientMonome
  (lambda(M)
    (car M)))

;(coefficientMonome '(5 0))


; Question 4
(define degrePolynome
  (lambda(P)
    (degrePolynome2 P 0)))

(define degrePolynome2
  (lambda(P D)
    (if(null? P)
       D
       (if(> (degreMonome (car P)) D)
          (degrePolynome2 (cdr P) (degreMonome (car P)))
          (degrePolynome2 (cdr P) D)))))

;(degrePolynome P)


; Question 5
(define valeurMonome
  (lambda(M X)
    (* (expt X (degreMonome M)) (coefficientMonome M))))

;(valeurMonome '(5 4) 2)


; Question 6
(define valeurPolynome
  (lambda(P X)
    (valeurPolynome2 P X 0)))

(define valeurPolynome2
  (lambda(P X R) 
    (if(null? P)
       R
       (+ (valeurMonome (car P) X) (valeurPolynome2 (cdr P) X R)))))

;(valeurPolynome P 2)


; Question 7
(define sommeFormelle
  (lambda(P1 P2)
    (if(null? P1)
       P2
    (sommeFormelle2 P1 P2 '())
    )
  )
  )

(define sommeFormelle2
  (lambda(P1 P2 Ps)
    (if(> (degrePolynome P1) (degrePolynome P2))
       (sommeFormelle3 P1 P2 0 (degrePolynome P2) '() )
       (sommeFormelle3 P1 P2 0 (degrePolynome P2) '() )
       )
 
  )
)

(define sommeFormelle3
  (lambda(P1 P2 i nbMax PS)
    (if(= i (+ nbMax 1))
       PS
       (if(= 0 (coefficientMonome (sommeMonome(iemeMonome P1 i)(iemeMonome P2 i)) ))
       (sommeFormelle3 P1 P2 (+ i 1) nbMax PS)
       (sommeFormelle3 P1 P2 (+ i 1) nbMax (append PS (list(sommeMonome(iemeMonome P1 i)(iemeMonome P2 i)))))
                      
       )
    )
  )
  )

(define sommeMonome
  (lambda(M1 M2)
    (list (+ (car M1) (car M2)) (cadr M1))
    )
  )

(define iemeMonome
  (lambda( P1 i)
    ( if(null? P1)
        (list 0 i)
        (if(= (degreMonome (car P1)) i)
           (car P1)
           (iemeMonome (cdr P1) i)
           )
        )
    )
  )

(sommeFormelle P P1)

;Question 8

(define derive
  (lambda (P)
    (deriveFormelle P '())))

(define deriveFormelle
  (lambda(P1 P2)
    (if(null? P1)
       P2
       (if(> (degreMonome (car P1)) 1)
          (deriveFormelle (cdr P1) (append P2 (list(list (* (degreMonome (car P1)) (coefficientMonome (car P1))   ) (- (degreMonome (car P1)) 1) ) )))

          (deriveFormelle (cdr P1)  P2)
          )
       )
    )
  )

;(derive P)


;Question 9

(define primitive
  (lambda (P)
    (primitiveFormelle P '())))

(define primitiveFormelle
  (lambda(P1 P2)
    (if(null? P1)
       P2
        (primitiveFormelle (cdr P1) (append P2 (list(list (/ (coefficientMonome (car P1)) (+ 1 (degreMonome (car P1)))) (+ (degreMonome (car P1)) 1) ))))
       )
    )
  )

;(primitive P)

;Question 10

(define multiplication
  (lambda (P1 P2)
    (multiplicationFormelle P1 P2 '())))


(define multiplicationFormelle
  (lambda(P1 P2 Ps)
    (if(null? P1)
       Ps
       (multiplicationFormelle (cdr P1) P2 (sommeFormelle Ps (multMoParPo (car P1) P2 '())))
       )
    )
  )

(define multMoParPo
  (lambda(Mo P1 P2)
    (if(null? P1)
       P2
       (multMoParPo Mo (cdr P1) (append P2 (list (list(* (coefficientMonome Mo) (coefficientMonome (car P1))   ) (+ (degreMonome (car P1)) (degreMonome Mo)) ) )))
       )
    )
  )

(multiplication P P1)