# Declarative Thinking with The Three Functional Musketeers: Map, Filter, Reduce

In my previous article, What is Functional Programming? I gave a definition of functional programming. That was a very abstract definition, and probably few outside of the FP community would understand that. That's OK. When we're new to things it often helps to see examples of the abstract concepts.

I'm going to start in this article with a very simple example of applying category theory to everyday programming needs. Rather than using a functional language, I will adapt these concepts using Ruby and Golang, two languages I have to interact with frequently.

## Map

So Rubyists will likely recognize this one. Ruby does indeed borrow a lot of concepts from the functional world. Map is a very important one. Related to map is another function, each. We'll come back to that one in a bit. Let's start by examining what problem map is attempting to solve.

A common task in programming is to have to repeat certain actions. For this reason, in the imperative world the loop construct was created. You've seen this one a lot before:

```ruby
# imperative.rb
xs = ["bob", "joe", "john", "sara"]
ys = []

for i in xs do
  ys << i.capitalize
end

puts xs.inspect, ys.inspect

# Result
["Bob", "Joe", "John", "Sara"]
```

In Golang:

```go
// imperative.go
package main

import (
  "fmt"
  "strings"
)

func main() {
  xs := []string{"bob", "joe", "john", "sara"}
  ys := make([]string, 4)

  for i, x := range xs {
    ys[i] = strings.Title(x)
  }

  fmt.Println(ys)
}
```

So, this is obviously a standard loop that is capitalizing the first letter of each name. It works. If we define "correct" as that which fulfills the goal, then what works is correct. If the requirement is to capitalize each letter of each name, then the above solutions do that. However, there are more elegant solutions to the above that are far better, for reasons we'll soon get into. First, let's take a look at another way to do this in Ruby with the map function:

```ruby
# functional.rb
xs = ["bob", "joe", "john", "sara"]
ys = xs.map { |x| x.capitalize }

puts ys.inspect
#=> ["Bob", "Joe", "John", "Sara"]
```

As you can see, we've accomplished the same thing, but in a far smaller amount of code, and far more directly and concisely. By using map, we are focused less on the *Turing mechanics* of the computer, and more on the *goal* of the code. What is the point of the code? It is to capitalize a list of names. In this example, I am still assigning variables, to provide context from the original imperative style. However, these assignments are not actually necessary to concisely describe the functional domain of the code. Let's shorten this even further:

```ruby
puts ["bob", "joe", "john", "sara"].map { |name| name.capitalize }
#=> ["Bob", "Joe", "John", "Sara"]
```

A single line of code! We've taken the array, and directly made another array that contains the capitalized equivalent. We've done it in a single line of code, and the intent of the code is extremely clear.

I want to draw your attention to what is going on here with the map function. We are taking a set of objects, the names, and we are applying a transformation on those objects. This is straight out of category and set theory. What we're doing is describing two sets:

```
    xs              ys

| "bob"  |  ->  | "Bob"  |
| "joe"  |  ->  | "Joe"  |
| "john" |  ->  | "John" |
| "sara" |  ->  | "Sara" |
```

The function `map { |name| name.capitalize }` describes the relationship between the sets `xs` and `ys`. Right now, this function is injective. This means that it only describes how to get from an item in set `xs` to an item in set `ys`, not the other way around. We could describe the function that returns from `ys` to `xs`. It would look like this: `map { |name| name.downcase }`. This is called the inverse function.

Why is this interesting? Sure, it allows us to capitalize names in a single line of code, but more importantly it enables us to think in terms of categories and sets. This is powerful, as we will see later on, as it enables us to create functions with the following properties:

1. Deterministic: Because no state is being mutated in the code, and no side effects are occurring, we are able to guarantee that a given input to the function will always result in the expected output. This is what I meant in my previous article when I said that `f(x) -> y` (x implies y). There is no way to force that function to give an unexpected result. I cannot stress enough the importance of this property.
2. Replayable: Determinism guarantees replayability. If we know the initial conditions, and the definition of a deterministic function, we can make predictions about the outcome of that function. This may sound similar to what I said about determinism in (1) but the key point I'm making here is that if we have deterministic and stateless functions we can make guarantees about replayability, which allows us to do some amazing things.
3. Easier reversibility: While not all deterministic functions are reversible, determinism makes it much easier to reason about replayability. We simply define the inverse function to create what is called a *bijective* mapping: One that can go forward and backward. Or, in other words, one that can do `f(x) = y` as well as `f(y) = x`.

All this allows us to use functions as small but powerful building blocks to the programs we write. Again, I will show some more complex examples later in this article once I cover the next two functional building blocks: filter and reduce.

## Filter

Filter is very similar to map, except that instead of defining a mapping between sets `xs` and `ys`, it defines a subset of `xs`; `ys` becomes a subset of `xs`. In other words, the output of a filter function is, as it's name suggests, "filtering out" elements from `xs` we don't care about, returning the elements we do care about.

Ruby has a few different ways to apply a filter. `select` allows for keeping items in a set whereas `reject` allows us to create a new set containing items that do not match the criteria. Let's look at an example:

```ruby
# This gives us the names that do not begin with the letter 'j'.
["bob", "joe", "john", "sara"].reject { |x| x =~ /^j/ }
#=> ["bob", "sara"]
```


```ruby
# This gives us the names that begin with the letter 's'.
["bob", "joe", "john", "sara"].select { |x| x =~ /^s/ }
#=> ["sara"]
```

You may notice that, while we're able to select subsets with filter, we are not capitalizing things. Functional programming allows us to do proper *composition* of our functions. Ruby allows for this kind of operation using what it calls *chaining*:

```ruby
# Get names that do not start with the letter 'j' and capitalize them.
["bob", "joe", "john", "sara"].reject { |x| x =~ /^j/ }.map { |x| x.capitalize }
#=> ["Bob", "Sara"]
```

We can also wrap chaining methods for nicer readability:

```ruby
# Get names that do not start with the letter 'j' and capitalize them.
["bob", "joe", "john", "sara"].reject { |x| x =~ /^j/ }
                              .map { |x| x.capitalize }
#=> ["Bob", "Sara"]
```

Now we're talking! We're filtering out 'j's and capitalizing the rest. All in a single logical definition of what we want the data to look like.

## Reduce

I've already written an article about reduce, so I won't bother repeating myself on that one. You can read it here.

## Putting it all together

Now comes an example that's a bit more real-world than just handling a bunch of names. Let's say we are given the following requirement:

*Given a list of books, return a list of the first 15 unique authors by last name. Sort them by last name, then by first name. Print them as "Last, First". If the first name is not present, do not print the comma after the last name.*

First off, we'll need a file parser to load a text file containing books and authors. You can download the parser and the data file:

- [book_parser.rb](/static/files/book_parser.rb)
- [books.dat](/static/files/books.dat)

Now that we have a basic parser, let's experiment with taking the list of books in memory and trying to solve for the requirements we've been given. Here's a more imperative style, coded in Ruby:

```ruby
```

Again, there's a lot of looping. You have a lot more code to keep track of if you need to re-arrange some of the requirements. However, let's try a more functional style. We can use the same file parser we had earlier.

```ruby
require_relative 'book_parser'
include BookParser

books = BookParser.parse_books(File.readlines('books.dat'))

def optional(value)
  return nil unless value && value.is_a?(String)
  value.strip.size > 0 ? value : nil
end

def format_author(author)
  [author.last_name, optional(author.first_name)]
    .compact.join(', ')
end

# Top 15 distinct authors by name
puts books.map(&:author)
          .uniq(&:last_name)
          .sort_by(&:first_name)
          .sort_by(&:last_name)
          .take(15)
          .map { |author| format_author(author) }
          .join("\n")
```

Running this in bash, and timing it yields the following:

```shell
$ time ruby functional.rb
Abbott, Edwin A.
Achebe, Chinua
Adams, Douglas
Adiga, Aravind
Aeschylus
Albom, Mitch
Alcott, Louisa May
Alexie, Sherman
Alighieri, Dante
Allen, David
Allende, Isabel
Allsburg, Chris Van
Anderson, Laurie Halse
Angelou, Maya
Aristotle
ruby functional.rb  0.06s user 0.01s system 93% cpu 0.083 total
```

There are a couple of important differences between the imperative and functional styles of note here. The first, perhaps obvious, thing to note is that there are far fewer lines of code for the functional style. The second is that we have easier readability and can more discretely reason about the operations we're doing as though each operation takes us from one set to another. In some cases, we're mapping to a subset&mdash;the first operation is getting the author of each book&mdash;in other cases we're mapping to a transform of a set: sorting by name, taking fifteen, and mapping from a collection of author objects to a collection of string-formatted, output-ready authors.
