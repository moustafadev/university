; Program name: 4Lab.lsp
; Author: macbookair
; Creation date: 11/21/2022
; Description:
(defun lcounter (tree)
  (cond ((null tree) 0)
        (t (+ (lcounter (cadr tree)) (lcounter (cdddr tree))))))

(trace lcounter)

 (defun re ()
 (setq ins (open "//Mac/Home/Desktop/XLisp/inpdata.txt"
    :direction :input))
    (print (setq x (read ins)))
    (lcounter x)
    (close ins)
    )
