# Mutable vs Immutable Data: Variables vs Values

Coming up with a clear definition for functional programming is difficult. However, there seems to be agreement that functional programming at least contains these three ingredients:

1. Immutable data (variables vs values)
1. Higher order functions without side effects
1. Metaprogramming

Let's talk about the first pillar, immutable data. What does this mean? Let's first look at mutable data:

```kotlin
var x = 5
--x
```

We've declared a variable x, and assigned it the number 5. On the next line we decrement it (decrease it by 1). At this point the variable x contains 4. Mutable means the variable x can be changed. Simple enough, right?

Now let's look at immutable data:

```kotlin
val x = 5
--x
```

The compiler will throw an error:

```kotlin
error: val cannot be reassigned
--x
  ^
```

When using the `var` keyword, we are creating a variable. By using the `val` keyword we instead create a value. This tells the compiler that we cannot change the value anymore. Mutable means that when we create x, we cannot change it. Doesn't that sound bad? Why would we want to do this?

Functional programming has its roots in mathematics. There is a law in mathematics called the law of identity. The law of identity states that a thing is whatever it is identified as and cannot be something else. This is an important law that we can apply in functional programming with Kotlin.

When programs become large (and useful programs tend to become quite large) it becomes more difficult to reason about what the program is doing when we're trying to read it, perhaps when trying to debug it or understand it so we can make a change to it. One of the goals of functional programming is to reduce the complexity of our code so it becomes easier to reason about. The first way to do this is by making use of the law of identity. If we make x mutable (changeable), we have to keep track of every change to x in our program. There are an unlimited number of possible changes x can go through.

If we make x a value, and therefore immutable, we no longer have to keep track of what changes are made to x. This means that when we're looking at what the value x is thousands of lines of code into a program, we can rest assured that x is, and can only be, what it was originally defined as.

But if we have no way to change the value x, isn't our program useless? The simple answer is yes. Without the ability to change x, we can't do anything particularly useful or valuable. However, if we introduce higher order functions&mdash;the second pillar to functional programming, we can get around this limitation while still making code that is easy to think about.

So we've learned that Kotlin allows us to make variables, which can be changed anywhere later in our program. We've also learned that makes our programs difficult to reason about because we then have to think about all those changes. Finally, we learned that by making our variables into values, they cannot be changed anymore and we can then rest assured knowing that our value isn't being changed in any unexpected ways. In the next episode I'll cover higher-order functions and, in particular, we'll begin to investigate a special class of functions called folding functions.
