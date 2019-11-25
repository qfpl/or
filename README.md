# or

Three data types:

1. `λa b → Maybe (Either a b)`
2. `λa b → Either (Either a b) ((,) a b)` *aka `These`*
3. `λa b → Maybe (Either (Either a b) ((,) a b))`

![CSIRO's Data61 Logo](https://raw.githubusercontent.com/qfpl/assets/master/data61-transparent-bg.png)
