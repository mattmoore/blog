# Getting Started with Clojure

## Object-Oriented Programming Sucks!

Throughout my career I've gradually come to dislike the way that "traditional" "get things done" languages like C++, Java and even Ruby have done things. Don't get me wrong, I like a great number of things about Ruby. But as time goes on, the programming languages I've been working with have begun to feel increasingly dreadful.

I've come to better realize over time that the problem is with OOP (object oriented programming). To be more precise, the problem is with state. In all the existing systems I've worked, it seems that state keeps rearing its ugly head. The other problem is with data structures. Frankly, I hate most data structures in most languages. They seem to be disparate from the language itself. The way that collection types are handled seems very awkward in almost every OOP language I've come across. Ruby, at least, has handled arrays in a nicer way. I will grant that to Ruby. But where Ruby has done better than most OOP languages with collections (especially with blocks) most Ruby code I run across still seems to suffer from the same set of problems related to mutating state. That's the problem I've come to realize about OOP. To put this concisely, OOP languages tend to suffer from two design problems:

* mutating state
* lack of idiomatic collection syntax

Now, for a long time I'd kept hearing that functional languages were trying to solve these problems. While I've been wanting to pick up functional programming. I wasn't entirely sure what language to start with; there is no shortage of functional languages. I wanted to start with a Lisp that was easy to understand, but also useful for the web. At the recommendation of a friend of mine, I finally decided to start with Clojure and blog about my journey through this learning adventure.

So as I was reading through the Clojure documentation and experimenting with the REPL, I began to realize that Clojure solved these two problems very nicely:

* Clojure encourages immutable data structures by default
* Clojure collection syntax is beautiful and idiomatic

Clojure is a dynamic functional language created by Rich Hickey. It is a Lisp dialect that runs on the JVM. This is very interesting because it means we have access to all the Java libraries already available. The JVM is very fast, very solid, and has tons of support out there.

So, as the name implies, a functional language makes use of functions. Clojure, in particular, makes use of immutable data structures. But it doesn't do copy-on-write. I'll get more into that in a later post.

## Install Clojure

The easiest way I found to get started with Clojure is to first install Leiningen. But you'll also need to install Java. If you're on macOS Sierra and homebrew, run:

```shell
brew cask install java
brew install leiningen
```

## Clojure REPL

Leiningen, which henceforth I will refer to as "lein", provides a REPL (Read Eval Print Loop). A REPL is an interactive terminal that you can program on. If you want to experiment with the language, you don't have to create a file and compile it. You can just fire up the REPL and type away:

```shell
lein repl
```

## Functions

Now that we've got everything installed and our REPL is up and running, let's define our first Clojure function and run it:

```clojure
(def square (fn [x] (* x x)))
(square 2)
;=> 4
```

What's all that?! The first line is declaring a function called square that, well, squares a number! But there's a shorter preferred way to do this in Clojure:

```clojure
(defn square [x] (* x x))
(square 2)
;=> 4
```

Using (defn) instead of (def) makes this a little shorter and cleaner. Clojure is all about neatness.

You might also notice that I'm enclosing each expression in parentheses. That is the Clojure way. These are called s-expressions. Those aren't important right now either, I'll cover that later as well.

The [x] in the function declaration is a parameter. The definition is (\* x x). That's another interesting thing to me. Clojure is all about functions and lists. Data is code. Code is data. These concepts become blurred, which is a good thing. The relationship between the code and data is concise and signifies *intent*. It does this in a "pure" way. The * is an operator function that gets applied to the list, comprised of the x. We can do this in Clojure:

```clojure
(+ 1 2 3)
;=> 6
```

That's a list of numbers that we're then applying the addition operator to. We can do the same with any operator:

```clojure
(- 1 2 3)
;=> -4
```

We can concatenate a list of strings:

```clojure
(str "John" "Matt" "Bob")
;=> "JohnMattBob"
```

Of course, there are no spaces in the result. To add those, we can do a join:

```clojure
(clojure.string/join " " ["John" "Matt" "Bob"])
;=> "John Matt Bob"
```

The join function is defined in the clojure.string namespace. Namespaces are a way of storing functions in an organized fashion. Why did I use square brackets instead of parentheses? Because that represents a vector, which is what the join function expects.

## Lists vs Vectors

```clojure
; List:
(list 1 2 3)
; or
'(1 2 3)

; Vector:
(vector 1 2 3)
; or
[1 2 3]
```

Two useful data structures Clojure provides us with are lists and vectors. C++ folks can think of something similar to std::vector. For Java folks, think ArrayList. However, this is not an exact one-to-one mapping. Vectors in C++ are stored sequentially in memory for very fast read operations. Accessing an element by integer index makes use of some very fast pointer arithmetic, providing O(1) search space. A Clojure vector, on the other hand, makes use of a branching shared node structure that gives a search space of O(log32n). This is not quite O(1), but is very very fast nonetheless. Now, for those who are easily frightened by O(log n) spaces, remember, *constants are important*. O(log32n) is still incredibly fast.

A Clojure list is implemented as a linked list. In C++ this would be like std::list<T>. In Java this would be like a LinkedList type. The search space complexity is O(n).

Anyway, I could write a whole blog post on algorithm space complexity, and maybe I will, but this is not the time to get too deep into that.

## Using Libraries

If I want to split a string:

```clojure
(use '[clojure.string :only (split)])
(split "Clojure is awesome!" #" ")
;=> ["Clojure" "is" "awesome!"]
```

Since the split function is not loaded when the REPL starts, I have to call the use function to include the clojure.string library. In this case, I am passing the :only keyword to include the join and split functions.

I'm also entering a single-quote mark before the vector of libraries to include. This means that everything past the quote mark should be treated as data only; it prevents evaluation of anything after the quote.

So, is Clojure perfect? I don't think perfection exists. But Clojure definitely seems to fit the bill nicely. It requires a different way of thinking about code, but in the end it handles collections very nicely and eliminates many of the issues inherent with mutating state. In a future blog I'll evaluate concurrency and parallelism in Clojure and why I think Clojure's methods are far superior to Golang's goroutines and channels.
