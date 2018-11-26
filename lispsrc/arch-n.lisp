;; Arch NT -- Nero's Toy Computer

;; This is a kind of hybrid of Forth, COSMAC 1082, and abstract machine.
;; Like forth, there's a data stack.
(defvar *data-stack* '())
;; With a liner memory for store program and data.
(defvar *memery*     (make-array 500))
(defvar *dma*        (make-array 500)) ;; 30 x 15 display

(defvar *p* 0) ;; Program counter

(defvar *snd*  false)
(defvar *freq* 0)

(defvar *disp* false)

(defvar *state* 0) ;; 0 -> idle; 1 -> load; 3 -> run

(defun run-nt ()
  )
