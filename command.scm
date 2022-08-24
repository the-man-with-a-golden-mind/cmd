(define-library (cmd command)
  (import (otus lisp))

  (export 
   make-cmd
   make-curl-cmd)

  (begin
    ; Add: make-http-req rest-type body headers
    ; dir - show files


    (define (make-cmd path command)
      (define In (syscall 22))
      (define Out (syscall 22))

      (define (Pid command in out)
        (syscall 59 (c-string path)
                  (map c-string command)
                  (list (car in) (cdr out))))
      (Pid command In Out)
     ; CLOSING PORTS
     (for-each close-port (list (car In) (cdr Out)))
     (if (> (size Out) 0)
      (car Out)
      Out))
    
    (define (make-curl-cmd command)
      (make-cmd "usr/bin/curl" command))
    ))
