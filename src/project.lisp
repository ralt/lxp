(in-package :lxp)

(defmacro define-project (name &body forms)
  `(let* ((project ,(string-downcase (symbol-name name)))
          (containers ',forms))
     (loop
        for (name values) on containers by #'cddr
        do (setf name (string-downcase name))
        do (if (container-p project name)
               (start-container project name values)
               (progn
                 (create-container project name values)
                 (start-container project name values))))))
