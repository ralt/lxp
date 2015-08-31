(in-package :lxp)

(defun main (&rest args)
  (declare (ignore args))
  (in-package :lxp)
  (handler-case
      (let* ((out (make-string-output-stream))
             (*standard-output* out)
             (*error-output* out))
        (load "lxpfile" :verbose nil :print nil)
        ;; successful exit
        (uiop:quit))
    (file-error () (format t "fatal: couldn't load lxpfile~%"))
    (error () (format t "fatal: unknown error~%")))
  ;; an error occured, exit in failure
  (uiop:quit -1))
