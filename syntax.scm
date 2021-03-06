(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))
(define (variable? exp)
  (if (symbol? exp) true false))
(define (quote? exp)
  (tagged-of-list? exp 'quote))
(define (tagged-of-list? exp tag)
  (eq? (car exp) tag))
(define (lambda? exp)
  (tagged-of-list? exp 'lambda))
(define (define? exp)
  (tagged-of-list? exp 'define))
(define (assignment? exp)
  (tagged-of-list? exp 'set!))
(define (if? exp)
  (tagged-of-list? exp 'if))
(define (cond? exp)
  (tagged-of-list? exp 'cond))


(define (text-of-quote exp)
  (cdr exp))
(define (make-procedure exp)
  (cons 'compound
        (lambda-body exp)
        (lambda-parameters exp)))
(define (eval-definition exp env)
  (bind-var-to-env (definition-variable exp)
                   (definition-value exp env) env))
(define (eval-assignment exp env)
  (set-var-in-env (assignment-variable exp)
                  (assignment-value exp) env))

(define (eval-if exp env)
  (if (eval (if-predicate exp) env)
    (eval (if-consequent))
    (eval (if-alternative))))


(define (if-predicate exp)
  (cadr exp))
(define (if-consequent exp)
  (caddr exp))
(define (if-alternative exp)
  (cadddr expp))
(define (lambda-parameters exp)
  (cadr exp))
(define (lambda-body exp)
  (caddr exp))
(define (definition-variable exp)
  (cadr exp))
(define (definition-value exp env)
  (eval (caddr exp) env))
(define (assignment-variable exp)
  (cadr exp))
(define (assignment-value exp env)
  (eval (caddr exp) env))
(define (operator exp)
  (car exp))
(define (operands exp)
  (cdr exp))
(define (eval-sequence exps env)
  (map (lambda (exp) (eval exp env)) exps))
(define (primitive-procedure? exp)
  (tagged-of-list? exp 'primitive))
(define (compound-procedure? exp)
  (tagged-of-list? exp 'compound))
(define (procedure-body proc)
 (cadr proc))
(define (procedure-parameters proc)
 (caddr proc))
