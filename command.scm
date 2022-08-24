(define-library (cmd command)
  (import (otus lisp))

  (export 
   make-cmd
   make-curl-cmd)

  (begin
    ; Add: make-http-req rest-type body headers
    ; dir - show files


    (define (make-cmd path command parser)
      (define In (syscall 22))
      (define Out (syscall 22))

      (define (Pid command in out)
        (syscall 59 (c-string path)
                  (map c-string command)
                  (list (car in) (cdr out))))
      (Pid command In Out)
     ; CLOSING PORTS
     (for-each close-port (list (car In) (cdr Out)))
    (let ((response (try-parse parser (port-bytestream (car Out)) #false)))
      (close-port (car Out))
      result))
    
    (define (make-curl-cmd command parser)
      (make-cmd "usr/bin/curl" command parser))
    ))
