(import functools [reduce])
(import operator [add])
(import re)

(defn normalize-kwarg [kwarg]
  (setv key (get kwarg 0))
  (setv value (get kwarg 1))
  (return #(key (reduce add (map str.capitalize (re.findall "[A-Za-z0-9]+" value))))))