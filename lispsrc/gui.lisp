(ql:quickload :parenscript)

(defpackage playground
  (:use #:ps #:cl))

(in-package "PLAYGROUND")

;;; Prelude

(defpsmacro defsketch (initvar setup &rest draw)
  `(progn
     ,@(loop for pairs in initvar
             collect (if (atom pairs)
                         `(defvar ,pairs)
                         `(defvar ,(car pairs)
                            ,(second pairs))))
     (defun setup ()
       ,@setup
       undefined)
     (defun draw ()
       ,@draw
       undefined)))

(defmacro make-js (path &rest body)
  `(with-open-file (out ,path :direction :output
                              :if-does-not-exist :create
                              :if-exists :supersede)
     (format out "/* Generated from Parenscript. */~%")
     (ps-to-stream out ,@body)))

(defmacro make-sketch (path &rest body)
  `(make-js ,path (defsketch ()
                      ((create-canvas 400 400))
                    ,@body)))

(make-js #P"sketch.js"

         (defvar *char-array* '("A" "B" "C" "D" "E" "F"))
         (defun to-hex (n)
           (if (< n 10)
               (-string n)
               (aref *char-array* (- n 10))))
         (defun make-hex ()
           (+ (to-hex (/ (logand #xf0 hex-disp) 16))
              (to-hex (logand #x0f hex-disp))))

         (defun make-byte ()
           (loop for i from 0 to 7
                 sum (* (expt 2 (- 7 i)) (aref switches i))))

         (defun state ()
           (+ "State: "
              (case *state*
                (0 "rest")
                (1 "load")
                (3 "run")
                (4 " idle"))))
         (defun output (s)
           (setq hex-disp s))

         (defun draw-switch ()
           (loop for i from 0 to 7
                 do (progn
                      (if (= (aref switches i) 1)
                          (fill 100 100 100)
                          (fill 100 100 25))
                      (ellipse (+ 135 (* 30 i)) 140 15 15))))

         (defun key-pressed ()
           (cond
             ((= key-code 73) ;; i
              (when (= *state* 1)
                (n-input (make-byte))
                (output (make-byte))))

             ((and (< key-code 57) (> key-code 48))
              (setf (aref switches (- key-code 49))
                    (if (= 0 (aref switches (- key-code 49)))
                        1
                        0)))
             ((= key-code 76) ;; l
              (setq *p* 0)
              (setq *state* 1))
             ((= key-code 82) ;; r
              (setq *p* 0)
              (setq *state* 3))
             ((= key-code 83) ;; s
              (setq *p* 0)
              (setq *state* 0))
             ((= key-code 67) ;;c
              (clean-mem)
              (setq *data-stack* '()
                    *pointer* 0
                    *p* 0
                    *state* 0
                    *q* 0
                    hex-disp 0))
             )
           undefined)
         (defsketch
             ((hex-disp 0)
              (switches '(0 0 0 0 0 0 0 0)))
             ((create-canvas 400 400)
              (clean-mem))

           (color-mode *hsb* 100)
           (no-stroke)
           (fill 19 34 85)
           (rect 2 2 (- width 4) (- width 4) 20 20 5 5)

           (text-size 32)
           (fill 0)
           (text "Nero's Computer" 20 50)

           (text (make-hex hex-disp) 200 300)
           (text (-String *q*) 200 350)
           (text (state) 200 200)

           (when (= *state* 3)
             (run-next))
           (draw-switch)))

(ccl:quit)
