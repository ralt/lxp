#|
  This file is a part of lxp project.
  Copyright (c) 2015 Florian Margaine (florian@margaine.com)
|#

#|
  lxc projects

  Author: Florian Margaine (florian@margaine.com)
|#

(in-package :cl-user)
(defpackage lxp-asd
  (:use :cl :asdf))
(in-package :lxp-asd)

(defsystem lxp
  :version "0.1"
  :author "Florian Margaine"
  :license "MIT"
  :depends-on (:cl-ppcre)
  :components ((:module "src"
                :components
                ((:file "lxp" :depends-on ("package" "project"))
                 (:file "project" :depends-on ("package" "container"))
                 (:file "run" :depends-on ("package"))
                 (:file "container" :depends-on ("package" "run"))
                 (:file "package"))))
  :description "lxc projects"
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.md"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq))))
