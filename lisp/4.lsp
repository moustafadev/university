; Program name: 4.lsp
; Author: nazar
; Creation date: 19.11.2021
; Description:

(defun UFunc (subtree)
    (let (new_subtree)
        (setq new_subtree
            (list
                (cond
                    ((or (first subtree)) (* (first subtree) 2))
                    (T Nil)
                )
            )
        )
        (cond
            ((or (second subtree))
                (cond
                    ((atom (second subtree))
                        (setq new_subtree (append new_subtree (list (* (second subtree) 2))))
                        (cond
                            ((or (third subtree)) (setq new_subtree (append new_subtree (list (UFunc (third subtree))))))
                        )
                    )
                    (T
                        (setq new_subtree (append new_subtree (list (UFunc (second subtree)))))
                        (cond
                            ((or (third subtree))
                                (setq new_subtree (append new_subtree (list (* (third subtree) 2))))
                                (cond
                                    ((or (fourth subtree))  (setq new_subtree (append new_subtree (list (UFunc (fourth subtree))))))
                                )
                            )
                        )
                    )
                )
            )
        )
        new_subtree
    )
)

(defun get_tree ()
    (setq gtinput_stream (open "inputdata.txt" :direction :input))
    (setq tree (read gtinput_stream))
    (close gtinput_stream)
    tree
)

(setq UTree (get_tree))

(defun push_tree ()
    (setq ufunc_result (open "outdata.txt" :direction :output))
    (print (UFunc UTree) ufunc_result)
    (close ufunc_result)
)
