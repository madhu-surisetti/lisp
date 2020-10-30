;;;; package.lisp

(in-package :cl)

(defpackage :utils
  (:use :cl)
  (:export
   ;; characters
   :+up+
   :+down+
   :+left+
   :+right+
   :+ctrl-a+
   :+ctrl-b+
   :+ctrl-c+
   :+ctrl-d+
   :+ctrl-e+
   :+ctrl-f+
   :+ctrl-g+
   :+ctrl-h+
   :+ctrl-i+
   :+ctrl-j+
   :+ctrl-k+
   :+ctrl-l+
   :+ctrl-m+
   :+ctrl-n+
   :+ctrl-o+
   :+ctrl-p+
   :+ctrl-q+
   :+ctrl-r+
   :+ctrl-s+
   :+ctrl-t+
   :+ctrl-u+
   :+ctrl-v+
   :+ctrl-w+
   :+ctrl-x+
   :+ctrl-y+
   :+ctrl-z+
   ;; functions & macros
   :aif
   :awhen
   :while
   :awhile
   :until
   :auntil
   :self
   :betweenp
   :digitcharp
   :alphabetp
   :mem
   :is/in
   :lines
   :map9))
