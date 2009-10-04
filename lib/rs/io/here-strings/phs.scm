(define (bad-here port ln message . args)
  (apply error 
	 (string-append "scan-token:~d: in HERE string, " message)
	 (or ln (input-port-line-number port))
	 args))

(define (scan-start-word port)
  (let ((delim (list->string (collect port valid-id-continued?))))
    (let loop ()
      (let ((ch (read-char port)))
	(cond
	 ((eof-object? ch)
	  (bad-here port #f "eof in START-WORD"))
	 ((eq? ch #\newline)
	  delim)
	 ((char-whitespace? ch)
	  (loop))
	 (else
	  (bad-here port #f "non-whitespace after START-WORD")))))))

(define (scan-here-string port ch)
  (let ((ln (input-port-line-number port)))
    ;; collect the delimiter ("EOS" marker)
    (let ((delim (string-append "#\"" (scan-start-word port)))
	  (buf (open-output-string)))
      (letrec ((getch (lambda ()
			(let ((ch (read-char port)))
			  (if (eof-object? ch)
			      (bad-here port ln "eof")
			      ch))))
	       (bol (lambda ()
		      (let prefix-loop ((i 0))
			(let ((ch (getch)))
			  (if (char=? (string-ref delim i) ch)
			      (if (< (+ i 1) (string-length delim))
				  (prefix-loop (+ i 1))
				  (done))
			      (begin
				(write-string buf (substring delim 0 i))
				(inl ch)))))))
	       (inl (lambda (ch)
		      (write-char ch buf)
		      (if (eq? ch #\newline)
			  (bol)
			  (inl (getch)))))
	       (done (lambda ()
		       (make-token '<literal>
				   (close-output-port buf)
				   ln))))
	(bol)))))
  
(add-sharp-scanner! #\" scan-here-string)
