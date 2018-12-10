(ql:quickload :parenscript)
(defpackage ps-compiler
  (:use :cl :ps))

(in-package :ps-compiler)

(defun comp-file ()
    (with-open-file (out "arch-n.js" :direction :output
                                     :if-does-not-exist :create
                                     :if-exists :supersede)
      (format out "/* Generated from Parenscript. */~%")
      (format out (ps-compile-file "arch-n.lisp"))))

(comp-file)
(ccl:quit)
