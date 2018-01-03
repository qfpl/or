# or

Three data types:

1. `λa b → Maybe (Either a b)`
2. `λa b → Either (Either a b) ((,) a b)` *aka `These`*
3. `λa b → Maybe (Either (Either a b) ((,) a b))`

![Data61](http://i.imgur.com/uZnp9ke.png)
