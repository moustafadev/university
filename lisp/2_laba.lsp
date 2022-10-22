; Program name: 2_laba.lsp
; Author: macbookair
; Creation date: 10/22/2022
; Description:



(defun UF(n x)(if (plusp n) (* x (UF (- n 1) x))1))

(setq my_file (open "//Mac/Home/Desktop/university/lisp/outdata.txt"
  :direction :output))
(setq s (UF 4 2))
(princ s my_file)
(terpri my_file)
(close my_file) 

