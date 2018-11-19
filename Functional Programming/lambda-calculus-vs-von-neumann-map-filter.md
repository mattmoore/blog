# Map & Filter: Lambda Calculus & Category Theory vs Von Neumann

## Topics

- [Abstract](#abstract)
- [Two Different Computational Models: Von Neumann Architecture vs Lambda Calculus](#two-different-computational-models)
- [Imperative Implementations of Map and Filter](#imperative-implementations)
- [Functional Implementations of Map and Filter](#functional-implementations)
- [Category Theory: Relationships and Functors](#category-theory-relationships-functors)
- [Fold vs Reduce](#fold-vs-reduce)

<a name="abstract"></a>

## Abstract

I have an interest in applying functional concepts from lambda calculus and category theory to programming. I was particularly excited with the possibilities of folding functions when I first discovered them. As I continue on my journey into discovering the worlds of lambda calculus and category theory, I noticed that when people talk about map and filter, they often give the implementations using an imperative approach. I wanted to share how this can be done in a purely functional manner, applying lambda calculus and category theory to their definitions.

<a name="two-different-computational-models"></a>

## Two Different Computational Models

### Von Neumann Architecture: The Digital Realization of The Turing Machine

This is the computational model that today's computers implement. They're the digital realization of the Turing Machine. They have memory and processors, and they do operations in time-dependent and implicit steps (aka imperative programming) to achieve the final result.

### Lambda Calculus

This is a computational model that "pure" functional languages attempt to emulate. In an ideal world, this model does away with the machines of the Von Neumann sort, and rather than representing computation as a series of steps, computation is modeled as a tree of expressions. Now, I said "in an ideal world" this is the case, because we don't actually have "real" physical lambda calculus machines. The computational devices of today are Von Neumann machines. Because of this, functional languages are written in the fashion of lambda calculus, but their compilers have to translate that to Von Neumann architecture so our functional programs can run on Von Neumann hardware.

<a name="imperative-implementations"></a>

### Imperative Implementations of Map and Filter

Most of the implementations that I have seen for map and filter are done using the imperative (Von Neumann) style. For example, if you were to ask how to implement map, you might get this implementation:

```ruby
class Array
  def my_map(&f)
    xs = []
    each do |x|
      xs << f.(x)
    end
    xs
  end
end
```

And you'd probably see a similar implementation of the filter function:

```ruby
class Array
  def my_filter(&f)
    xs = []
    each do |x|
      xs << x if f.(x)
    end
    xs
  end
end

[1, 2, 3, 4].my_filter { |x| x % 2 == 0 }
```

Now, there's nothing strictly wrong with this. My motto is, when you're trying to understand a principle, or build something that works up front, Do what works. Worry about details later. Often those details become unrelated tangents and before you know it you've wasted a lot of time on things that detract from your original learning goal. But the goal here is to show that these "functional functions" can be written functionally instead of using the imperative version.

<a name="functional-implementations"></a>

### Functional Implementations of Map and Filter

It is possible to implement map and filter in functional terms of a folding expression&mdash;rather than the imperative Von Neumann approach. Let's visit that for folks who don't know what it is. I'll go with an almost trivial, but pedagogical example.

Let's say I have a list of integers 1 through 10 and I want to get the sum. I could write this imperative version:

```ruby
list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
sum = 0
for x in list do
  sum += x
end

sum
# Output: 55
```

Now, before Rubyists tell me that this isn't how you would do a sum in Ruby. You'd just do `list.sum`. However, the goal here is to demonstrate the difference between the imperative and functional implementations of `map` and `filter`.

Functional programming is all about abstractions. We can abstract this further. Let's take this for loop and move it into a function we'll call `my_reduce`:

```ruby
class Array
  def my_reduce(accumulator, &f)
    each do |x|
      accumulator = f.(accumulator, x)
    end
    accumulator
  end
end

list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

list.my_reduce(0) { |sum, num| sum += num }
# Output: 55
```

In this case, `my_reduce` takes a list of integers and adds them together to get the final sum.

I have referred to this function as "reduce". This function gets called all kinds of different things depending on the context and the programming language. There are actually multiple variations of reduce, but I will avoid those for now. I will, however, stop using the word "reduce" and instead use the word "fold". This is because the concept that we're discussing with reduce is actually referred to by mathematicians originally as "fold". Just remember, "reduce" and "fold" are somewhat synonymous. There are slight differences between reduce and fold, but they're irrelevant for now so we'll discuss that at the end.

	Fold is a function that applies an operation over a recursive data structure.

Now we're going to move to implementing map. However, we're not going to implement it in terms of the looping I did earlier. And we're not going to just use Ruby's map method. Instead, we want to create our own to better understand the principles of how these things work.

To implement our own map function using only Ruby's reduce function, we can write the following `my_map` function:

```ruby
class Array
  def my_map(&f)
    self.reduce([]) { |xs, x| xs << f.(x) }
  end
end

(1..10).to_a.my_map { |x| x * 2 }
# Output: [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
```

We can write a similar definition for filter:

```ruby
class Array
  def my_filter(&f)
    self.reduce([]) { |xs, x| (xs << x) if f.(x); xs }
  end
end

(1..10).to_a.my_filter { |x| x > 4 }
# Output: [5, 6, 7, 8, 9, 10]
```

There's a bit to unpack there, so let's go through it step by step:

1. We are opening the Array class in Ruby to add a method to it. This is so we can call that method on arrays: `list.my_filter...`.
1. `my_map` and `my_filter` take blocks. That's what the ampersand in front of the `f` signifies.
1. These functions call reduce. Notice the empty array `[]` passed into reduce. That is the type initializer for reduce. What that means is rather than starting out with integer (number 0) and adding to that number via the addition rule, we're going to instead create a new array and combine the elements of the original array into that new array.
1. We only add an element `x` to the new list (represented as `xs`) that we initialized reduce with if the predicate function&mdash;`f.(x)`&mdash;we're supplying returns true for that element. What's a predicate function? One that returns true or false for a given condition.
1. Finally, we're returning the incrementally updated new list at the end of the reduce.
1. The only difference between these two functions is that `my_map` calls `f.(x)` on each element, storing the result in the new list&mdash;it's a one to one transformation; `my_filter` calls a predicate on each item, only storing it in the new list if it matches. As you can see running the example code, we successfully filter only values greater than 4.

We can do the same thing in Haskell:

```haskell
myFilter :: Foldable t => (a -> Bool) -> t a -> [a]
myFilter f = foldr (\x xs -> if f x then x:xs else xs) []
myFilter (\x -> x > 4) [1..10]
-- Output: [5,6,7,8,9,10]
```

This is also possible in Kotlin:

```kotlin
inline fun <T> Iterable<T>.myMap(transform: (T) -> T): List<T> {
    return this.fold(mutableListOf()) { ys: MutableList<T>, x: T ->
        ys.add(transform(x))
        ys
    }
}

val list = (1..10).toList()
list.myMap { it * 2 }

// Output: [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
```

And for filter:

```kotlin
fun <T> Iterable<T>.myFilter(predicate: (T) -> Boolean): Iterable<T> {
    return this.filter { predicate(it) }
}

val list = (1..10).toList()
list.myMap { it * 2 }

// Output: [5, 6, 7, 8, 9, 10]
```

Just as with Ruby, we're defining new functions `myMap` and `myFilter` on the `Iterable` type, which includes arrays and lists, allowing us to call `list.myMap` and `list.myFilter`.

<a name="category-theory-relationships-functors"></a>

## Category Theory: Relationships & Functors

Both the imperative and functional implementations work. However, when we start moving away from the imperative approach and toward the functional paradigm, we get better composability and we start to see abstraction patterns that help us reason about things in a formal and declarative way. If we were to define the imperative version of map, we would have to write a definition like this:

    Takes an original collection, and creates a new collection.

    Iterates over the original collection, applying a function to each item,
    then storing the result in the corresponding position in the new collection.

    Returns the new collection.

With the functional implementation, we can define map thusly:

    Transforms a collection of type A to a collection of type B.

Another way to phrase this using category theory:

    Defines a relationship (arrow) between Functor[A] and Functor[B].

Imperative implementations require step-by-step instructions whereas functional approaches allow us to express the same concepts but using a more declarative approach where we don't have to worry about *how* the iterative steps occur, but rather *what* occurs.

## Functors

So you may have seen my sly little inclusion of the word "functor" in that category theory definition. What's a functor? Good question. The mathematicians might not like my description here, but a functor is basically something which is "mappable". It is something that fits in a "container" that can be transformed. In the examples provided here, a list is a functor. It's a container that contains multiple values which can be mapped over. But a functor doesn't have to be a list. There are other things that are functors as well. I'll save functors for a future post, but for now you can think of a list as a functor.

<a name="fold-vs-reduce"></a>

## Fold vs Reduce

I mentioned earlier that fold and reduce are nearly synonymous yet different. They both operate over a recursive data structure (lists for example). However fold accepts an initial data type while reduce does not. For example, using reduce in Ruby we get this:

```ruby
[1, 2, 3].reduce { |xs, x| xs + x }
#=> 6
```

Ruby does not have a function named `fold`, however it does the same thing by passing a parameter into `reduce`:

```ruby
[1, 2, 3].reduce(0) { |xs, x| xs + x }
#=> 6
```

This gives us the same result as before, since we're passing 0 to the reduce. Let's pass 1 to it instead:

```ruby
[1, 2, 3].reduce(1) { |xs, x| xs + x }
#=> 7
```

Before reduce begins to iterate through the list, it begins by setting `xs` to 1, then proceeds to iterate. There's something more interesting we've done with this though:

```ruby
[1, 2, 3].reduce([]) { |xs, x| xs << x }
#=> [1, 2, 3]
```

Now, instead of aggregating the list into a sum, we're starting with an empty array `[]` and adding the values to that array. We end up with another array that has identical content. Instead of an empty array, we can also start with an array containing content:

```ruby
[1, 2, 3].reduce([4]) { |xs, x| xs << x }
#=> [4, 1, 2, 3]
```

We can use other data types as well:

```ruby
numbers_words = { 1 => "one", 2 => "two", 3 => "three" }
[1, 2, 3].reduce({}) { |xs, x| xs[x] = numbers_words[x]; xs }
#=> {1=>"one", 2=>"two", 3=>"three"}
```

We start with a hash mapping the numbers 1, 2 and 3 to their corresponding words. Why not just use the numbers_words though, instead of contriving this reduce function here? You could, but then you wouldn't be able to do this: Given an english sentence, translate any words that we have the translations for. Leave words we have no translation for in english. Here we go:

```ruby
english_spanish_dictionary = { 'one': 'uno', 'two': 'duo', 'three': 'tres', 'watches': 'relojes' }
sentence = "I have one iPhone but two Apple watches"
# Apply the translation
sentence.split(' ').reduce([]) { |translation, word|
  translation << (english_spanish_dictionary[word.to_sym] || word); translation
}.join(' ')
#=> "I have uno iPhone but duo Apple relojes"
```

Here's what's going on:

1. We define an english to spanish dictionary with a few words translated.
1. We define an english sentence.
1. In the third line of our code containing the reduce, we first split the sentence into an array of words.
1. Then we reduce or fold the array of words into another list (since we're passing in `[]`).
1. When doing the fold (called reduce in Ruby), we do a lookup from the `english_spanish_dictionary`. If no translation is found, the dictionary will return `nil`. This allows us to use the logical or operator `||` to then use the `x` value, which represents the english word for that round of iteration.
1. Finally, we join the array of words together into a string, separated by spaces.

The beautiful thing about this logic is that it is abstracted enough that all we have to do is keep our dictionary updated, without the need to modify the logic later. Any time we add a new translation to our `english_spanish_dictionary`, our translation logic will remain intact.

If I did this imperatively, I would need to change this:

```ruby
sentence.split(' ').reduce([]) { |translation, word|
  translation << (english_spanish_dictionary[word.to_sym] || word); translation
}.join(' ')
```

to this:

```ruby
words = sentence.split(' ')
translation = []
for word in words
  translation << (english_spanish_dictionary[word.to_sym] || word)
end
translated_sentence = translation.join(' ')
```

This works, but it requires a for loop and the creation of new variables within the same scope as each other, all of which can be unsafely mutated. It also requires more lines of code. In any case, using the functional implementation safeguards against unintended changes as it prevents creating mutable data structures outside of each function in the function pipeline (`split`, `reduce`, `join`). It is also composable.
