(defun reverse-and-nest-head (input-list)
    (reverse-and-nest-head-inner (cdr (reverse input-list)) (last input-list))
)

(defun reverse-and-nest-head-inner (input-list-inner output-list-inner)
    (cond
        ((null input-list-inner) output-list-inner)
        (t (reverse-and-nest-head-inner (cdr input-list-inner) (list output-list-inner (first input-list-inner))))
    )
)

(defun repeat-element (elem count)
    (if (<= count 0)
        nil
        (cons elem (repeat-element elem (- count 1)))
    )
)

(defun duplicate-elements (input-list n)
    (cond
        ((or (null input-list) (<= n 0)) nil)
        (t (append (repeat-element (first input-list) n) (duplicate-elements (cdr input-list) n))
        )
    )
)

(defun check-my-reverse-function (name input expected)
(format t "~:[FAILED~;passed~]... ~a~%"
(equal (reverse-and-nest-head input) expected)
name))

(defun check-my-duplicate-function (name input n expected)
(format t "~:[FAILED~;passed~]... ~a~%"
(equal (duplicate-elements input n) expected)
name))

(defun run-reverse-and-nest-head-tests ()
    (check-my-reverse-function "Test 1 reverse and nest head" '(a b c 1 2 3 pi "end") '(((((((("end") PI) 3) 2) 1) C) B) A))
    (check-my-reverse-function "Test 2 reverse and nest head" nil nil)
    (check-my-reverse-function "Test 3 reverse and nest head" '(h) '(h))
)

(defun run-duplicate-elements-tests ()
    (check-my-duplicate-function "Test 1 duplicate elements" '(a b c 1 2 3 pi "end") 3 '(a a a b b b c c c 1 1 1 2 2 2 3 3 3 pi pi pi "end" "end" "end"))
    (check-my-duplicate-function "Test 2 duplicate elements" nil 5 nil)
    (check-my-duplicate-function "Test 3 duplicate elements" '(h) 10 '(h h h h h h h h h h))
)

(defun run-all-tests ()
    (run-reverse-and-nest-head-tests)
    (run-duplicate-elements-tests)

)

(run-all-tests)
