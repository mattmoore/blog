# Should I Use if Statements? (Or Polymorphism to The Rescue)

I have been asked a lot lately about whether good programmers don't use if statements. I find this question amusing because it seems that those who ask about it almost have a fear of if statements. I thought I'd address this concern by talking about good design over a few blog posts, of which this is the first.

First, there's nothing wrong with a good old-fashioned if statement. It's OK to use them. There are times when overthinking and over-engineering can turn otherwise simple and easy-to-read code into an unmaintainable mess. Good design is about keeping things readable, maintainable, and avoiding unnecessary complexity.

That being said, there are a few basic principles that good code tends to follow. First, code should be broken down into functional and modular units. Classes and methods should be short, succinct, and precise. They should be easy to understand. Sandy Metz, well-known in the Ruby community, has a guideline that I like: classes should be 100 lines of code or less, and each method should be no more than 5 lines. That means you won't have a lot of room for complex if statements. Also, we should avoid "arrowhead" programming. This refers to the nesting of statements such that the indentation of the code resembles an arrowhead. For example:

```ruby
def figure_something_out
  if some_condition?
    if some_other_condition?
      if a_third_thing_is_true?
      end
    end
  end
end
```

As you can see, we're nesting more and more if statements in that code. Each nested if statement starts to resemble an arrowhead pointing right. This is terrible. What if we have even more conditions to check for? Those nested if statements will begin to get unwieldy. Additionally, with each if statement that we're checking, we introduce yet another branch of logic that our method can fall into, and another condition that needs to be tested in the context of this method. Each additional condition creates what is referred to as high cyclomatic complexity. We want our methods to have low cyclomatic complexity. They should, as much as is possible, do one thing and do it well. It should be clear what the method is doing after reading the code for no more than 5 seconds.

This brings me to polymorphism. What is polymorphism? If you're familiar with object-oriented programming, you've seen this term before and may know what it is. If you're new to OOP, you may not have seen it yet. Polymorphism makes use of a concept in OOP languages known as the type system. In OOP, we create classes to represent the types of things we're programming for and we use the type system to make decisions for us that, in many cases, can eliminate the need for lots of if statements that often results from beginners who aren't familiar with the type paradigm.

Let's say I have a class called Animal, and that class has a method called move():

```ruby
class Animal
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def move
    if @type == :dog
      walk
    elsif @type == :fish
      swim
    end
  end

  private

  def walk
    puts "walking"
  end

  def swim
    puts "swimming"
  end
end
```

Now, to use this class:

```ruby
dog = Animal.new(:dog)
=> #<Animal:0x007fcfdd8a4030 @type=:dog>
dog.move
=> walking
```

As you can see, the console will print "walking". It's pretty obvious why. It's because our if statements in move() determine what type of action the animal needs to perform in order to actually move. But, while this works, it's not very clean and doesn't make use of the type system. What if we have 1,000 animals that need to move in 1,000 different ways? This solution will not scale very well. We'd end up having to have 1,000 different if statements. The move() method would get very long.

Instead, we can make use of subclassing and rely on the type system to do its thing. This is what we mean when we say "polymorphism". Let's rewrite our animal class:

```ruby
class Animal
  def type
    self.class
  end

  def move
  end
end
```

Pretty simple eh? But wait, it doesn't do anything now! That's OK. Let's add two more classes that inherit from Animal:

```ruby
class Dog < Animal
  def move
    puts "walking"
  end
end
```

```ruby
class Fish < Animal
  def move
    puts "swimming"
  end
end
```

Now, let's make use of these:

```ruby
dog = Dog.new
=> #<Dog:0x007fa23d348848>
dog.type
=> Dog
dog.move
=> walking

fish = Fish.new
=> #<Fish:0x007fa23d29b9b8>
fish.type
=> Fish
fish.move
=> swimming
```

As you can see, we're now making use of the type system. Both are animals, and both share the type() method. They both also share the move() method, but their move() methods are different. We are getting these objects to respond to the same command of move() but they know that they move in different ways. We achieved this behavior without writing a single if statement.
