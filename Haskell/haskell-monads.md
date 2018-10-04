# What's a Monad?

"A monad is just a monoid in the category of endofunctors, what's the problem?"

A shortened, humorous version was given by James Iry, from his highly entertaining *Brief, Incomplete and Mostly Wrong History of Programming Languages*, in which he fictionally attributes it to Philip Wadler:

"All told, a monad in X is just a monoid in the category of endofunctors of X, with product × replaced by composition of endofunctors and unit set by the identity endofunctor." - Saunders Mac Lane in Categories for the *Working Mathematician*

That quote is a formalized definition of monads from Saunders Mac Lane.

Oh, that's all! So...what's a monad?

But really, what is a monad? Far too many times I've seen explanations given in mathematical terms, as it relates to category theory. Oh no, maths! But here's the thing: You don't need to know any maths to use monads! This bears repeating: Monads in programming rely on no prior knowledge of category theory!

The reality is that the use of monads in programming were *inspired* by mathematics, but you don't need to study mathematics in order to use them in Haskell. Monads in Haskell are just about how to deal with function input and output types that don't match up. This is necessary because Haskell, unlike Ruby, doesn't employ duck typing.

## Decisions vs Side Effects

Haskell draws boundaries between decisions and side effects. Decisions are pure expressions that define logic. Side effects are state changes involving real world actions. Think of side effects as "commands".

For example, let's say I have the following function:

```haskell
add x y = x + y
```

This function is a "pure" function. Another way to put it is that it's an "expression". In the world of pure functional programming, it doesn't "do" anything, it simply "expresses" something. In Haskell, a pure function is an "expression" of something. Here, the `add` function expresses what addition is. It doesn't do anything to the real world.


Talks:

Functional Programming
Haskell
Monads
Clojure
REPL-driven development
