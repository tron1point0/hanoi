#!/usr/bin/env clisp

(defun solve (n a b c)
  (if (> n 0)
    (append (solve (- n 1) a c b) `((,a ,c)) (solve (- n 1) b a c))
    `()))

(defun move (m)
  (format t "~S -> ~S~%" (first m) (second m)))

(defun solution (n)
  (mapcar 'move (solve n 'A 'B 'C)))

(let ((n (parse-integer (first (append *args* `("7"))))))
  (format t "~D~%" n)
  (solution (parse-integer (first (append *args* `("7"))))))
