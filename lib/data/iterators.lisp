(defgeneric next (iterator)
  "Advance the ITERATOR, returning either the next value produced and
   the updated iterator state, or `nil` twice if no more values can be
   produced.")

;;; Anamorphisms (unfolds) {{{

;; NOTE: The implementation of iterators for lists and strings alike is
;; *fake*. Instead of returning the updated list, for performance
;; reasons, we only return a "view".
;;
;; These views are not to be manipulated by user code, and should only
;; occur during iteration. Because of this, they do not have a `:n` such
;; as `list` does.

(defmethod (next list) (x) ; {{{
  (if (empty? x)
    nil
    (values-list (car x)
                 { :tag "view"
                   :kth nth
                   :backing x
                   :current 2
                   :limit (n x) }))) ; }}}

(defmethod (next string) (x) ; {{{
  (if (empty? x)
    nil
    (values-list (string/char-at x 1)
                 { :tag "view"
                   :kth string/char-at
                   :backing x
                   :current 2
                   :limit (n x) }))) ; }}}

(defmethod (next view) (x) ; {{{
  (destructuring-bind [{ :backing ?backing
                         :current ?current
                         :kth ?kth
                         :limit ?lim } x]
    (if (> current lim)
      nil ; we've exhausted the list
      (values-list (kth backing current)
                   { :tag "view"
                     :kth kth
                     :backing backing
                     :current (+ 1 current)
                     :limit lim })))) ; }}}

(defun range (&args) ; {{{
  "Build an inclusive range, starting at :START and ending at :END, optionally
   passing by the value :BY."
  (let* [(ags (apply fast-struct args))
         (st (or (.> ags :from) 1))
         (ed (or (.> ags :to) math/huge))
         (inc (- (or (.> ags :by) (+ 1 st)) st))]
    { :tag "inclusive-range" :cursor st :end ed :inc inc :tst (if (>= st ed) >= <=) })) ; }}}

(defmethod (next inclusive-range) (range) ; {{{
  (destructuring-bind [{ :cursor ?c
                         :end ?e
                         :inc ?i
                         :tst ?t}
                       range]
    (if (t c e)
      (values-list c { :tag "inclusive-range" :cursor (+ c i) :end e :inc i :tst t })
      nil))) ; }}}

(defmethod (pretty inclusive-range) (range) ; {{{
  (format nil "(range :from {} :to {}{})"
          (.> range :cursor)
          (- (.> range :end) 1)
          (if (/= (.> range :inc) 1)
            (.. " :by " (+ (.> range :cursor) (.> range :inc)))
            ""))) ; }}}

;;; }}}

;;; Transformations {{{

(defun map (fun iter) ; {{{
  "Return an iterator that applies FUN to every non-nil value produced
   by ITER."
  { :tag "iterator.map" :fun fun :backing iter }) ; }}}

(defmethod (next iterator.map) (x) ; {{{
  (destructuring-bind [{ :fun ?fun
                         :backing ?iter }
                       x]
    (let* [((val iter) (next iter))]
      (if (not iter)
        nil
        (values-list (fun val) { :tag "iterator.map" :fun fun :backing iter })))))

(defmethod (pretty iterator.map) (x) "«map iterator»") ; }}}

(defmacro do* (vars &body) ; {{{
  "Run BODY through all elements produced by the iterators in VARS. Note
   that this acts like the cross product instead of a zip."
  (if (empty? vars)
    `(progn ,@body)
    (let* [(val (gensym))
           (marker (gensym))
           (iter (gensym))]
      `(let* [(,marker (gensym))]
         (loop [(,val ,marker)
                (,iter ,(cadar vars))]
           [(= ,iter nil) nil]
           (when (and ,val (/= ,val ,marker))
             (let* [(,(caar vars) ,val)]
               (do* ,(cdr vars) ,@body)))
           (,'recur (next ,iter))))))) ; }}}

;;; }}}

;;; Catamorphisms (folds) {{{

(defun to-list (iter) ; {{{
  "Collect all non-nil values produced by ITER into a list."
  (let* [(out '())]
    (do* [(v iter)]
      (push-cdr! out v))
    out))

(defun collapse (iter)
  "Collapse is an alias for [[to-list]]."
  (to-list iter)) ; }}}

(defun fold (f z iter) ; {{{
  "Accumulate all values produced by ITER using the function F, starting
   from the value Z.

   ```cl
   > (fold + 0 (range :from 1 :to 10))
   out = 55
   ```"
  ; Copy the iterator into the correct place when Z is not given
  (loop [(val z)
         (iter iter)]
    [(= iter nil) val]
    (let* [((newv newi)
            (next iter))]
      (recur (if newv
               (f val newv)
               val)
             newi)))) ; }}}

;;; }}}

; vim: fdm=marker
