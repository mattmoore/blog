# Functional Composition

A key component to functional programming is composition. Composition is the ability to take a list of functions and apply them to a given input. To understand composition, let's create an `adder` function that takes a value and adds 1 to it:

```ruby
adder = ->(x) { x + 1 }

adder(1)
#=> 2
```

If I want to add 2 to the number, I can call adder twice:

```ruby
adder(adder(1))
```

And 3:

```ruby
adder(adder(adder(1)))
```

And so on and so forth. However, this gets a little crazy with all the parentheses. We have another option:

```ruby
compose = ->(*functions) { functions.reduce { |f, g| ->(x) { f.(g.(x)) } } }
adder = ->(x) { x + 1 }

compose.(adder, adder, adder).(1)
```

This is what is meant by "composition". The compose function takes a set of functions and reduces over them, creating new functions each step of the way that will result in a final lambda containing all the lambdas we passed, and executing them as a function pipeline.

Let's try another example. Let's say we have a set of books and authors and a set of functions for them:

```ruby
class Author
  attr_accessor :first_name, :last_name, :birth_year

  def initialize(first_name:, last_name:, birth_year:)
    self.first_name = first_name
    self.last_name = last_name
    self.birth_year = birth_year
  end
end

class Book
  attr_accessor :title, :author
end

search_author = ->(authors, query) do
  authors.filter do |author|
    authors.first_name.include?(query) ||
    authors.last_name.include?(query) ||
    birth_year == query
  end
end
```
