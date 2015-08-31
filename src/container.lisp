(in-package :lxp)

(defun start-container (project name values)
  (run (format nil "lxc-start --name ~A" (container-name project name))))

(defun container-p (project name)
  (if (eq nil
          (member (container-name project name)
                  (cl-ppcre:split #\Newline (run "lxc-ls"))
                  :test #'string=))
      nil
      t))

(defun create-container (project name values)
  (run (format nil
               "lxc-clone --snapshot --backingstore overlayfs --orig ~A --new ~A"
               (getf values :base)
               (container-name project name))))

(defun container-name (project name)
  (format nil "~A_~A" project name))
