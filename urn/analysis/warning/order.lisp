(import urn/analysis/nodes (builtin? builtin))
(import urn/analysis/pass ())
(import urn/logger logger)
(import urn/range range)
(import urn/resolve/scope scope)

(defun visit-quote (defined logger node level)
  :hidden
  (cond
    ;; Visit the node as normal
    [(= level 0) (visit-node defined logger node)]
    ;; Recurse into the node
    [(list? node)
     (with (first (nth node 1))
       (if (symbol? first)
         (cond
           [(or (= (.> first :contents) "unquote") (= (.> first :contents) "unquote-splice"))
            (visit-quote defined logger (nth node 2) (pred level))]
           [(= (.> first :contents) "syntax-quote")
            (visit-quote defined logger (nth node 2) (succ level))]
           [else (for-each sub node (visit-quote defined logger sub level))])
         (for-each sub node (visit-quote defined logger sub level))))]
    [else]))

(defun visit-node (defined logger node last)
  :hidden
  (case (type node)
    ["string"]
    ["number"]
    ["key"]

    ["symbol"
     ;; TODO: Check this is defined
     (when (and (scope/scope-top-level? (scope/var-scope (.> node :var))) (not (.> defined (.> node :var))))
       (logger/put-node-warning! logger
         (.. (.> node :contents) " has not been defined yet") (range/get-top-source node)
         "This symbol is not defined until later in the program, but is accessed here.
          Consequently, it's value may be undefined when executing the program."
         (range/get-source node) ""))]

    ["list"
     (let* [(first (nth node 1))
            (first-ty (type first))]
       (cond
         [(= first-ty "symbol")
          (let* [(func (.> first :var))
                 (func-ty (scope/var-kind func))]
            (cond
              ;; Just a basic function call :)
              [(or (= func-ty "defined") (= func-ty "arg") (= func-ty "native") (= func-ty "macro"))
               (visit-list defined logger node 1)]

              ;; _Technically_ lambdas are lazy, but for now let's be eagar with
              ;; our warnings.
              [(= func (builtin :lambda))
               (unless last (visit-block defined logger node 3))]
               ;; Each branch is a block
              [(= func (builtin :cond))
               (for i 2 (n node) 1
                 (with (case (nth node i))
                   (visit-node defined logger (nth case 1))
                   (visit-block defined logger case 2 last)))]

              [(= func (builtin :set!)) (visit-node defined logger (nth node 3))]
              [(= func (builtin :struct-literal)) (visit-list defined logger node 2)]
              [(= func (builtin :syntax-quote))
               (visit-quote defined logger (nth node 2) 1)]

              [(or (= func (builtin :define)) (= func (builtin :define-macro)))
               (visit-node defined logger (nth node (n node)) true)
               (.<! defined (.> node :def-var) true)]

              [(= func (builtin :define-native))
               (.<! defined (.> node :def-var) true)]

              ;; Basic nodes which don't need any special handling
              [(= func (builtin :quote))]
              [(= func (builtin :import))]
              ;; Nodes which shouldn't appear anywhere.
              [(or (= func (builtin :unquote)) (= func (builtin :unquote-splice)))
               (fail! "unquote/unquote-splice should never appear here")]

              [else (fail! (.. "Unknown kind " func-ty " for variable " (.> func :name)))]))]

           ;; We're a directly called lambda, so propagate control flow through it.
         [(and (= first-ty "list") (builtin? (car first) :lambda))
          (visit-list defined logger node 2)
          (visit-block defined logger first 3 last)]

         ;; We're just a normal function call, so check all symbols.
         [else (visit-list defined logger node 1)]))]))

(defun visit-block (defined logger node start last)
  "Visit a block of nodes, starting from START."
  :hidden
  ;; Visit all the normal nodes
  (for i start (pred (n node)) 1
    (visit-node defined logger (nth node i)))
  ;; Visit the last node if required
  (when (>= (n node) start)
    (visit-node defined logger (nth node (n node)) last)))

(defun visit-list (defined logger node start)
  "Visit a list of nodes, starting from START."
  :hidden
  ;; Visit all the normal nodes
  (for i start (n node) 1
    (visit-node defined logger (nth node i))))

(defpass check-order (state nodes)
  "Check each node only eagerly accesses nodes defined after it."
  :cat '("warn")
  (visit-list {} (.> state :logger) nodes 1))
