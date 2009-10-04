
(define (rgb->pixel-proc (colormap <x-colormap>))
  (let* ((viz (colormap-visual-type colormap))
	 (rpart (mask->field-insert (red-mask viz)))
	 (gpart (mask->field-insert (green-mask viz)))
	 (bpart (mask->field-insert (blue-mask viz))))
    (lambda ((r <fixnum>) (g <fixnum>) (b <fixnum>))
      (fixnum+ (rpart r) (fixnum+ (gpart g) (bpart b))))))

(define (color->pixel-proc (colormap <x-colormap>))
  (let* ((viz (colormap-visual-type colormap))
	 (rpart (mask->field-insert (red-mask viz)))
	 (gpart (mask->field-insert (green-mask viz)))
	 (bpart (mask->field-insert (blue-mask viz))))
    (lambda ((c <color>))
      (fixnum+ (rpart (red-component c))
	       (fixnum+ (gpart (green-component c))
			(bpart (blue-component c)))))))

(define (mask->field-insert (mask <fixnum>))
  (let ((hi (find-high-bit mask)))
    (cond
     ((= hi 15)
      (lambda ((value <fixnum>))
	(bitwise-and value mask)))
     ((< hi 15)
      (let ((shft (- 15 hi)))
	(lambda ((value <fixnum>))
	  (bitwise-and (logical-shift-right value shft) mask))))
     (else
      (let ((shft (- hi 15)))
	(lambda ((value <fixnum>))
	  (bitwise-and (logical-shift-left value shft) mask)))))))

(define (find-high-bit mask)
  (let loop ((m mask)
	     (hi -1))
    (if (eq? m 0)
	hi
	(loop (logical-shift-right m 1) (+ hi 1)))))
