(import java.lang.Math)

(defn get-divisors [n] 
    (def rootN (Math/sqrt n))
    (range 2 (inc (Math/round rootN)))
)

(defn divides? [x n]
    (zero? (mod x n))
)

(defn no-divisors? [n] 
    (= (count (filter (partial divides? n) (get-divisors n))) 0)
)

(defn is-prime? [n]
    (and (> n 1) (not-any? (partial divides? n) (range 2 n)))
)

(defn prime-seq [from to]
    (filter is-prime? (range from to))
)

(defn print-top-primes [from to]
    (doseq [i (reverse (prime-seq from to))]
        (println i))
    (printf "Total = %d\n" (reduce + (prime-seq from to)))
)

; (println (get-divisors 4))
; (println (get-divisors 101))
; (println (get-divisors 7))
; (println (get-divisors 9))=
; (println (divides? 10 2))
; (println (divides? 10 4))
; (no-divisors 9)
; (println (no-divisors? 9))
; (println (no-divisors? 7))

; (println (is-prime? 9))
; (println (prime-seq 50 100))
(println (print-top-primes 50 100))
