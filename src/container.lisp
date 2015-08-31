(in-package :lxp)

(defun start-container (project name values))

(defun container-p (project name)
  (if (eq nil
          (member (container-name project name)
                  (cl-ppcre:split #\Newline (run "lxc-ls"))
                  :test #'string=))
      nil
      t))

(defun create-container (project name values))

(defun container-name (project name)
  (format nil "~A_~A" project name))
