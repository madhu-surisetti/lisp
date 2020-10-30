;; my very own lisp utilities

(in-package :utils)

(defconstant +up+ #\LATIN_SMALL_LETTER_A_WITH_BREVE)
(defconstant +down+ #\LATIN_CAPITAL_LETTER_A_WITH_BREVE)
(defconstant +left+ #\LATIN_CAPITAL_LETTER_A_WITH_OGONEK)
(defconstant +right+ #\LATIN_SMALL_LETTER_A_WITH_MACRON)
(defconstant +ctrl-a+ #\Soh)
(defconstant +ctrl-b+ #\Stx)
(defconstant +ctrl-c+ #\Etx)
(defconstant +ctrl-d+ #\Eot)
(defconstant +ctrl-e+ #\Enq)
(defconstant +ctrl-f+ #\Ack)
(defconstant +ctrl-g+ #\Bel)
(defconstant +ctrl-h+ #\LATIN_SMALL_LETTER_C_WITH_ACUTE)
(defconstant +ctrl-i+ #\Tab)
(defconstant +ctrl-j+ #\Newline)
(defconstant +ctrl-k+ #\Vt)
(defconstant +ctrl-l+ #\Page)
(defconstant +ctrl-m+ #\Newline)
(defconstant +ctrl-n+ #\So)
(defconstant +ctrl-o+ #\Si)
(defconstant +ctrl-p+ #\Dle)
(defconstant +ctrl-q+ #\Dc1)
(defconstant +ctrl-r+ #\Dc2)
(defconstant +ctrl-s+ #\Dc3)
(defconstant +ctrl-t+ #\Dc4)
(defconstant +ctrl-u+ #\Nak)
(defconstant +ctrl-v+ #\Syn)
(defconstant +ctrl-w+ #\Etb)
(defconstant +ctrl-x+ #\Can)
(defconstant +ctrl-y+ #\Em)
(defconstant +ctrl-z+ #\Sub)






(defmacro aif (test-form then-form &optional else-form)
  `(let ((it ,test-form))
     (if it ,then-form ,else-form)))

(defmacro awhen (test-form &body body)
  `(aif ,test-form
        (progn ,@body)))

(defmacro while (condition &body body)
  `(loop while ,condition do (progn ,@body)))

(defmacro awhile (expr &body body)
  `(do ((it ,expr ,expr))
       ((not it))
     ,@body))

(defmacro until (condition &body body)
  `(loop until ,condition do (progn ,@body)))

(defmacro auntil (expr &body body)
  `(do ((it ,expr ,expr))
       (it)
     ,@body))

(defun self (x) x)

(defun betweenp (n left right)
  "tell if left < n < right"
  (if (< left n right) t))

(defun digitcharp (c)
  "tell if a character is a digit"
  (if (numberp (parse-integer (string c) :end 1 :junk-allowed t))
      t nil))


(defun alphabetp (c)
  "tell if a character is an alphabet"
  (if (and (alphanumericp c)
           (not (digitcharp c)))
      t nil))


(defmacro mem (s i)
  "elt with out-of-bounds check"
  `(if (> ,i (1- len))
       'end-of-sequence
       (elt ,s ,i)))


(defun is/in (item ref)
  "item is/in ref"
  (member
   item
   (if (listp ref)
       ref
       (list ref))))

(defun lines (file)
  "split the file into lines"
  (uiop:read-file-lines file))



(defmacro map9 (fn seq)
  "a general mapping utility with interesting features"
  `(let ((len (length ,seq))
         (box nil)
         (needle 0)
         (e (elt ,seq 0)))
     ;; the features
     (labels
         ((cur () (mem seq needle))
          (update () (incf needle)
            (setf e (mem ,seq needle)))
          (peek (&optional (offset 1))
            (let ((index (+ needle offset)))
              (if (> index (1- len))
                  'end-of-input
                  (mem ,seq index))))
          (matchp (expected-vals &key (offset 1)
                                   (key #'self)
                                   (func #'move))
            (if (is/in
                 (funcall key (peek offset))
                 expected-vals)
                (progn (funcall func) t)
                nil))
          (move (&optional (step 1))
            (setf needle (+ needle step)))
          (skip-to (func &key (key #'self) (offset 0))
            (let ((p (position-if func ,seq :key key :start (1+ needle))))
              (if p (setf needle (+ p offset)) 'not-found))))
       ;; the loop
       (do* () ((> needle (1- len)) (reverse box))
         (push ,fn box)
         (update)))))                           ; make sure fn is a single form!
