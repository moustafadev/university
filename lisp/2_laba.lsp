; Program name: 2_laba.lsp
; Author: macbookair
; Creation date: 10/22/2022
; Description:



(defun UF(n x)(if (plusp n) (* x (UF (- n 1) x))1))




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

