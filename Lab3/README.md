<p align=center><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПСПМ СПіСКС</b></p>
<p align=center><b>Звіт з лабораторної роботи 2</b><br/>
"Рекурсія"<br/>
дисципліни "Вступ до функціонального програмування"</p>
 
<p align=right><b>Студент</b>: Ткаченко Володимир КВ-33</p>
<p align=right><b>Рік</b>: 2026</p>

## Загальне завдання
Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і
імперативно.
1. Функціональний варіант реалізації має базуватись на використанні рекурсії і
конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного
списку. Не допускається використання: псевдо-функцій, деструктивних операцій,
циклів . Також реалізована функція не має бути функціоналом (тобто приймати на
вхід функції в якості аргументів).
2. Імперативний варіант реалізації має базуватись на використанні циклів і
деструктивних функцій (псевдофункцій). Не допускається використання функцій
вищого порядку або функцій для роботи зі списками/послідовностями, що
використовуються як функції вищого порядку. Тим не менш, оригінальний список
цей варіант реалізації також не має змінювати, тому перед виконанням
деструктивних змін варто застосувати функцію copy-list (в разі необхідності).
Також реалізована функція не має бути функціоналом (тобто приймати на вхід
функції в якості аргументів).
## Варіант 16 (1)
Алгоритм сортування вибором за незменшенням.
## Лістинг функції з використанням конструктивного підходу
``` lisp
(defun find-next-le (lst min)
    (cond
        ((null lst) min)
        ((< (first lst) min) (find-next-le (cdr lst) (first lst)))
        (t (find-next-le (cdr lst) min))
    )
)

(defun remove-first-occurrence (item lst)
  (cond
    ((null lst) nil)
    ((equal item (first lst)) (cdr lst)) 
    (t (cons (first lst) (remove-first-occurrence item (cdr lst))))
    )
) 

(defun selection-sort-functional-inner (input-list output-list)
      (cond
        ((null input-list) output-list)
        (t 
            (let ((x (find-next-le (cdr input-list) (first input-list))))
                (selection-sort-functional-inner (remove-first-occurrence x input-list) 
                (append output-list (list x)))
            )        
        )
    )
)

(defun selection-sort-functional (lst)
    (selection-sort-functional-inner lst nil)
)
```
## Лістинг функції з використанням деструктивного підходу
``` lisp
(defun selection-sort-imperative (lst)
    (cond
        ((null lst) nil)
        ((= (length lst) 1) lst)
        (t
            (let ((arr (copy-list lst)) (lst-length (length lst)) (min-position 0) (min (first lst))) 
                (dotimes (i lst-length)
                    (setq min (nth i arr))
                    (setq min-position i)
                    (loop for j from i below lst-length do
                        (when (< (nth j arr) min)
                            (setq min (nth j arr))
                            (setq min-position j)
                        )
                    )
                    (if (/= i min-position)
                        (rotatef (nth i arr) (nth min-position arr))
                    )
                )
                arr
            )   
        )
    )

)
```
## Тестові набори та утиліти
``` lisp
(defun check-my-function (name func input expected)
(format t "~:[FAILED~;passed~]... ~a~%"
(equal (funcall func input) expected) name))

(defun run-tests()
    (check-my-function "Test 1 Functional Selection Sort" #'selection-sort-functional nil nil)
    (check-my-function "Test 2 Functional Selection Sort" #'selection-sort-functional '(1) '(1))
    (check-my-function "Test 3 Functional Selection Sort" #'selection-sort-functional '(3 2 5 5 1 1) '(1 1 2 3 5 5))
    (check-my-function "Test 4 Functional Selection Sort" #'selection-sort-functional '(6 6 6 6 6) '(6 6 6 6 6))
    (format t "~%")
    (check-my-function "Test 1 Imperative Selection Sort" #'selection-sort-imperative nil nil)
    (check-my-function "Test 2 Imperative Selection Sort" #'selection-sort-imperative '(1) '(1))
    (check-my-function "Test 3 Imperative Selection Sort" #'selection-sort-imperative '(3 2 5 5 1 1) '(1 1 2 3 5 5))
    (check-my-function "Test 4 Imperative Selection Sort" #'selection-sort-imperative '(6 6 6 6 6) '(6 6 6 6 6))
)
```
## Тестування 
``` lisp
(run-tests)
```

#### Вивід термінала
``` 
passed... Test 1 Functional Selection Sort
passed... Test 2 Functional Selection Sort
passed... Test 3 Functional Selection Sort
passed... Test 4 Functional Selection Sort

passed... Test 1 Imperative Selection Sort
passed... Test 2 Imperative Selection Sort
passed... Test 3 Imperative Selection Sort
passed... Test 4 Imperative Selection Sort
```

