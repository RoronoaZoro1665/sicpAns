; painters
; a. the outline
(define (painter-outline frame)
  (let ((segment-list (list (make-segment 0 0 0 1) (make-segment 0 0 1 0) (make-segment 0 1 1 1) (make-segment 1 0 1 1))))
    ((segments->painter segment-list) frame)))
; b. the x
(define (painter-x frame)
  (let ((segment-list (list (make-segment 0 0 1 1) (make-segment 0 1 1 0))))
    ((segments->painter segment-list) frame)))
; c. the diamond
(define (painter-diamond frame)
  (let ((segment-list (list (make-segment 0 0.5 0.5 0) (make-segment 0 0.5 0.5 1) (make-segment 0.5 0 1 0.5) (make-segment 1 0.5 0.5 1))))
    ((segments->painter segment-list) frame)))
; d. the wave
(define (painter-wave frame)
  (let ((segment-list (list (make-segment 0 0.75 1 0.5) (make-segment 0.5 0.5 0.5 1) (make-segment 0.5 0.5 0.25 0) (make-segment 0.5 0.5 0.75 0))))
    ((segments->painter segment-list) frame)))

; painter maker
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
      (lambda (segment)
        (draw-line ((frame-coord-map frame) (start-segment segment)) 
                   ((frame-coord-map frame) (end-segment segment))))
      segment-list)))

; draw-line
(define device (make-graphics-device (car (enumerate-graphics-types))))
(define (draw-line v1 v2)
        (graphics-draw-line device (xcor-vect v1) (xcor-vect v2) (ycor-vect v1) (ycor-vect v2))
        ; (graphics-close device)
        )

; 将在frame中坐标map到标准的直角坐标系中
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
      (origin-frame frame)
      (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
                (scale-vect (ycor-vect v) (edge2-frame frame))))))

; frame
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define (origin-frame f)
  (car f))
(define (edge1-frame f)
  (car (cdr f)))
(define (edge2-frame f)
  (cdr (cdr f)))
(define f0 (make-frame (cons 0.0 0.0) (cons 1.0 0.0) (cons 0.0 1.0)))

; segment
(define (make-segment x1 y1 x2 y2)
  (cons (make-vect x1 y1) (make-vect x2 y2)))
(define (start-segment s)
  (car s))
(define (end-segment s)
  (cdr s))

; vector
(define (make-vect x y)
  (cons x y))
(define (xcor-vect v)
  (car v))
(define (ycor-vect v)
  (cdr v))
(define (add-vect v1 v2)
  (cons (+ (car v1) (car v2))
        (+ (cdr v1) (cdr v2))))
(define (sub-vect v1 v2)
  (cons (- (car v1) (car v2))
        (- (cdr v1) (cdr v2))))
(define (scale-vect s v)
  (cons (* s (car v)) (* s (cdr v))))
