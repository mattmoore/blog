# What's a Monad?

"All told, a monad in X is just a monoid in the category of endofunctors of X, with product × replaced by composition of endofunctors and unit set by the identity endofunctor." - Saunders Mac Lane in Categories for the *Working Mathematician*

Oh, that's all! So...what's a monad?

That quote is a formalized definition of monads from Saunders Mac Lane. A shortened, humerous version was given by James Iry, from his highly entertaining *Brief, Incomplete and Mostly Wrong History of Programming Languages*, in which he fictionally attributes it to Philip Wadler:

"A monad is just a monoid in the category of endofunctors, what's the problem?"

But really, what is a monad? Far too many times I've seen explanations given in mathematical terms, as it relates to category theory. Oh no, maths! But here's the thing: You don't need to know any maths to use monads! This bears repeating: Monads in programming rely on no prior knowledge of lambda calculus!

The reality is that monads in programming were *inspired* by mathematics, but you don't need to study mathematics in order to use them in Haskell. Monads in Haskell are just about how to deal with function input and output types that don't match up. This is necessary because Haskell, unlike Ruby, doesn't employ duck typing.

## Decisions vs Side Effects

Haskell draws boundaries between decisions and side effects. Decisions are pure expressions that define logic. Side effects are state changes involving real world actions. Think of side effects as "commands".

For example, let's say I have the following function:

```haskell

```
