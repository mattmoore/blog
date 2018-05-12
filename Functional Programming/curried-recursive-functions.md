# Curried Recursive Functions

One important feature in functional programming is a concept known as currying. It is named after [Haskell Curry](https://en.wikipedia.org/wiki/Haskell_Curry).

Currying describes the conversion of a multi-arity function to a series of single-arity functions. Let's examine a simple function:

```ruby
def f(x, y)
  x + y
end

f(2, 3)

#=> 5
```

Nothing particularly interesting is going on here. We have a simple function that takes two arguments and adds them together. But this function can be curried. Let's see what that would look like:

```ruby
def g(x)
  -> (y) { f(x, y) }
end

g(2).(3)

#=> 5
```

`g` is a function that takes an argument `x`. However, it does not take the `y` argument like the original example. Instead, `g` returns a lambda (an anonymous function). The lambda returned by `g` accepts a parameter `y`. Obviously, the lambda has access to `y` because it is an argument to the lambda. Thanks to closures (inner functions that maintain outer scope), the lambda also has access to `x` passed in via the outer function `g`. What this means, then, is that the lambda can call `f` to perform `x + y`.

This is a simple example of currying. However, what if we decide we want to extend this function definition to allow us to supply three parameters?

```ruby
g(2).(3).(1)
NoMethodError: undefined method 'call' for 5:Integer
from (pry):4:in '__pry__'
```

We get an error! Unfortunately, our curried function only supports two arguments. In order to support a variable number of arguments, we need to slightly adjust our definition. Let's define another function `h`:

```ruby
def h(x)
  -> (y = nil) { y ? h(f(x, y)) : x }
end
```

This new definition returns a lambda that checks to see if the y value has been provided. If it has, the ternary operator recursively calls the `h` function again with `f(x, y)`. Otherwise, it simply returns `x`. Now, we can issue a variable number of single-arity argument calls:

```ruby
h(2).()
#=> 2
h(2).(3).()
#=> 5
h(2).(3).(1).()
#=> 6
h(2).(3).(1).(1).()
#=> 7
```

We can also simplify `h` in Ruby to use pure lambdas without the method notation. Note the addition of `.` via the recursive call to `h.(f(x, y))`:

```ruby
h = -> (x) { -> (y = nil) { y ? h.(f(x, y)) : x } }
```

However, note that this changes the call pattern, requiring that we call `h.(x)` instead of just `h(x)`:

```ruby
h.(2).()
#=> 2
h.(2).(3).()
#=> 5
```

Why is this important? Let's think about the original function `f` that took two parameters and added them together. The problem with that function is that the arguments themselves are directly tied together with the `+` operation. What we're trying to do in the functional world with currying is to cleanly abstract away the notion of operation from the arity of the arguments. If you think of the original function `f` as being "hard-coded" to two arguments, you can conversely think of the function `h` as effectively removing that arity restriction for the `+` operation. This provides some amazing capabilities that I will examine in a future post.
