; Program name: 3_1_laba.lsp
; Author: macbookair
; Creation date: 10/24/2022
; Description:



(defun UF(n x)
(defvar res 1)
(loop
    (setq res (* res x))
    (setq n (- n 1))
    (when (> 0 n) (return res))
))


(defun wr ()
(setq my_file (open "//Mac/Home/Desktop/university/lisp/outdata.txt"
  :direction :output))
(princ "Enter N : ")
(setq n (read))
(princ "Enter X : ")
(setq x (read))
(setq s (UF n x))
(princ s my_file)
(terpri my_file)
(close my_file)
)




