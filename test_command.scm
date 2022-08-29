(define *path* (cons "../"  *path*))

(import (owl parse))
(import (cmd command))

(define get-string
  (let-parse* ((bytes (greedy+ byte)))
              (bytes->string bytes)))

(define test-make-cmd-ls
  (display "Testing CMD LS...")
  (let* ((response (make-cmd "/bin/ls" (list "ls" "./") get-string)))
    (assert (size (car response)) ===> 47))
    (display "ok \n"))

(define tests 
 (list 
  test-make-cmd-ls))

(map (lambda (test) test) tests)
