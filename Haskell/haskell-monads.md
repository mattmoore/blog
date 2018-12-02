# The Monad

## Topics

- [Introduction](#introduction)
- [Haskell's Philosophy](#philosophy)
  - [Determinism](#determinism)

<a name="introduction"></a>

## Introduction

"A monad is just a monoid in the category of endofunctors, what's the problem?"

A shortened, humorous version was given by James Iry, from his highly entertaining *Brief, Incomplete and Mostly Wrong History of Programming Languages*, in which he fictionally attributes it to Philip Wadler:

"All told, a monad in X is just a monoid in the category of endofunctors of X, with product × replaced by composition of endofunctors and unit set by the identity endofunctor." - Saunders Mac Lane in *Categories for the Working Mathematician*

Oh, that's all! So...what's a monad?

Far too many times I've seen explanations given in mathematical terms, as it relates to category theory. I've been guilty of this myself when trying to explain them. But here's the thing: You don't need to know any maths to use monads! This bears repeating: Monads in programming rely on no prior knowledge of category theory!

The reality is that the use of monads in programming were *inspired* by mathematics, but you don't need to study mathematics in order to use them in Haskell. Instead of focusing on the mathematics here, let's just focus on the programming reasons behind *why* you need monads in Haskell and *what* problem they solve.

<a name="philosophy"></a>

## Haskell's Philosophy

Haskell is a "pure" functional language. While some languages like Ruby, Kotlin or Scala support some functional paradigms, they are not pure functional languages. You can still do imperative and object-oriented programming in those languages. They were designed to support features from multiple worlds. However, Haskell does not support non-functional paradigms. It was designed strictly around the functional world, and it tries to avoid imperative coding styles at all costs.

In most popular programming languages you can do almost anything you want. If I want a function that reads a file and then does something to the contents of the file, I can do that all in the same function or method. If I want to mix and match different kinds of logic together, I can do that as well. Most common programming languages in use today simply leave it up to the programmer to figure out how to structure their code. This might sound like a good idea, but it requires a certain discipline that tends to come with experience. Haskell is very opinionated. It's designers were largely mathematicians. Mathematics is all about defining things with precision and developing useful abstractions from those definitions. Consequently, Haskell does not allow you to do anything you want, wherever you want. It allows you to do what you want as long as you follow certain rules. These rules have been thought over a very long time, outside of the constraints of every day changing business needs that most companies encounter. These rules are present to ensure better software quality. I think the best indicator that the concepts in Haskell are useful and better than the alternatives is the fact that many of the other popular languages are adopting Haskell concepts, leading to better language features that these other lanuage communities are slowly coming to realize.

<a name="determinism"></a>

### Determinism

One thing that Haskell's creators feel strongly about is determinism. This is the concept that logic in code should always do the same thing consistently. It's behavior should be locked down to its precise definition. A function should be consistent and reliable. It should do one thing and do it well. Determinism leads to two outcomes: Easier reasoning about what a piece of code is doing, and better testability. If a function is reliable, consistent and precise, it is easier to write automated tests for.

But there's a problem with combining determinism with programming. There are programming tasks we do every day that require breaking determinism. Reading files, connecting to a database&mdash;the nature of these things is change. A database is constantly being modified. API calls can potentially behave differently. Files can have anything in them.

Haskell's designers built functions in such a way that we cannot do any IO inside them. If I write a Haskell function, I have no way to read a file or connect to the database. This is simply not allowed, because Haskell's designers wanted all functions to be deterministic, and that requires removing the ability to do things that are non-deterministic. However, they also realized that without providing *some* way to do these non-deterministic things, Haskell would be a rather useless language. The world our programs interact with require non-deterministic modeling. Technically, our world is deterministic, but due to our inability to track every single thing going on in it, we have to model our interactions with it non-deterministically.

Modeling the non-deterministic interactions between our program's logic and the real world is precisely what the monad was built for. The monad is all about Schrödinger's cat. It is the response to the question "If I don't know what the state of the world is at any point in time, how do I connect that uncertainty with a program that assumes certainty?"

Haskell draws boundaries between the idea of logic (functions) and side effects with the world (monads). Decisions are pure expressions that define logic. Side effects are state changes involving real world actions. Another way to think of side effects via monads is to imagine them as "commands" to interact with the real world. For example, let's say I have the following function:

```haskell
add :: Int -> Int -> Int
add x y = x + y

add 1 2

-- Yields 3
```

This function is a "pure" function. Another way to put it is that it's an "expression". In the world of pure functional programming, it doesn't "do" anything, it simply "defines" or "expresses" something. Here, the `add` function expresses what addition is. It doesn't do anything to the real world. It doesn't change any files, or read from a database, or rely on any external input or output. It simply defines addition.

But what if I need to add two numbers that are coming from the outside world? I would need to use a monad. There are lots of different kinds of monads, but the one we'd want to use is the IO monad. Here's how that would look:

```haskell
main :: IO ()
main = do
  x <- getLine
  y <- getLine
  result = add x y
  putStrLn result
```


Talks:

Functional Programming
Haskell
Monads
Clojure
REPL-driven development
