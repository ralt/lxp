(in-package :lxp)

(defun cat (&rest args)
  (apply #'concatenate 'string args))

(defun run (command)
  (let ((s (make-string-output-stream)))
    (uiop:run-program (cat "sudo " command) :ignore-error-status t :output s)
    (get-output-stream-string s)))
