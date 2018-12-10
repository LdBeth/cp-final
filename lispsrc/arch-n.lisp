;; Arch NT -- Nero's Toy Computer

;; This is a kind of hybrid of Forth, COSMAC 1082, and abstract machine.
;; Like forth, there's a data stack.
(defvar *data-stack* '())
;; With a liner memory for store program and data.
(defvar *main-memery*     (make-array 510))
(defvar *dma*        (make-array 510)) ;; 30 x 15 display
(defvar *interp* false)

(defvar *p* 0) ;; Program counter
(defvar *pointer* 0) ;; ram pointer #x00 -> #xff
(defvar *offset* 0) ;; 0 <> 1
(defvar *q* 0)
;;(defvar *snd*  false)
;;(defvar *freq* 0)


(defvar *state* 0) ;; 0 -> rest; 1 -> load; 3 -> run; 4 -> idle

(defun run ()
  (setq *state* 3))

(defun run-next ()
  (when (= *state* 3)
    (execute (aref *memery* *p*))
    (incf *p*)))

(defun spop ()
  (funcall (@ *data-stack* shift)))

(defun dist ()
  (+ (* *pointer* 2) *offset*))

(define-symbol-macro *head*
  (aref *data-stack* 0))

(define-symbol-macro *memery*
    (if *interp*
        *dma*
        *main-memery*))

(defun execute (code)
  (case code
    (#x0 (idle))
    (#x1 (load))
    (#x2 (save))
    (#x3 (setp))
    (#x4 (goto))
    (#x5 (show))
    (#x6 (brch))
    (#x7 (offt))
    (#x8 (offn))
    (#x9 (dupl))
    (#xa (adds))
    (#xb (nega))
    (#xc (mult))
    (#xd (dvid))
    (#xe (dmat)))
  undefined)

(defun idle ()
  (setq *state* 4))

(defun load ()
  ((@ *data-stack* unshift)
     (+ (* 256 (aref *memery* (* 2 *pointer*)))
        (aref *memery* (1+ (* 2 *pointer*))))))

(defun save ()
  (let ((n (mod (spop) #xffff)))
    (setf (aref *memery* (* 2 *pointer*)) (logand #xff00 n))
    (setf (aref *memery* (1+ (* 2 *pointer*))) (logand #xff n))))

(defun setp ()
  (incf *p*)
  (setq *pointer* (aref *memery* *p*)))

(defun goto ()
  (setq *p* (dist)))

(defun show ()
  (setq *q* (spop)))

(defun brch ()
  (when (= 0 *head*)
      (goto)))

(defun offt ()
  (setq *offset* 1))

(defun offn ()
  (setq *offset* 0))

(defun dupl ()
  ((@ *data-stack* unshift) *head*))

(defun adds ()
  (setf *head* (+ (spop) *head*)))

(defun nega ()
  (setf *head* (- (spop) *head*)))

(defun mult ()
  (setf *head* (* (spop) *head*)))

(defun divd ()
  (setf *head* (floor (spop) *head*)))

(defun dmat ()
  (if *interp*
      (setq *interp* false)
      (setq *interp* true)))
