# Class vs Instance Methods in Ruby

## What's a method?

A method is just a function that is defined inside a class. Ruby has two types of methods: class and instance. A class method belongs to the class and cannot be called from an object. An instance method belongs to an object and cannot be called from a class. Given the following class:

```ruby
class Robot
  def first_name
    "Asimov"
  end
end

asimov = Robot.new
=> #<Robot:0x007ff73537ad28>
asimov.first_name
=> "Asimov"
```

As you can see, we create a robot object and then call the name method. Because the name method belongs to the particular instance of this robot, this works. However, if I were to try to call name like this:

```ruby
Robot.first_name
NoMethodError: undefined method 'first_name' for Robot:Class
```

We get an error. If we want to make this work, we could change our class by prepending "self" to the first_name method:

```ruby
class Robot
  def self.first_name
    "Asimov"
  end
end

asimov = Robot.new
=> #<Robot:0x007ff73537ad28>
Robot.first_name
=> "Asimov"
```

But if we try to call it the original way:

```ruby
asimov.first_name
NoMethodError: undefined method 'first_name' for #<Robot:0x007ff73537ad28>
```

Why? Because now we've defined the method on the class and not the instance.

## Why is this important?

Sometimes the method you write is something related to the class, but not something that you want to have to instantiate an object in order to call. Perhaps you want to add a method that returns the name of the company that made the robots. For this you could do a class method:

```ruby
class Robot
  def self.company
    "Robots Inc."
  end
end

Robot.company
=> "Robots Inc."
```

Doing that allows you to avoid creating a robot object every time you want to know the company that makes robots. Otherwise, with an instance method you'd have to do this:

```ruby
class Robot
  def company
    "Robots Inc."
  end
end

robot = Robot.new
=> #<Robot:0x007fd74fac4e40>
robot.company
=> "Robots Inc."
```

Now, that would get rather annoying for something that has nothing to do with a specific robot, but all robots in general.

By the way, other languages (Java, C++, C#) refer to class methods as static methods and instance methods as dynamic methods. Semantics...
