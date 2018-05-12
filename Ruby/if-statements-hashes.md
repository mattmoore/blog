# Should I Use if Statements? (Or Hashes to The Rescue)

In an [earlier post](/blog/ruby/if-statements-polymorphism) I began addressing a question that's been making the rounds: Should I use if statements? I've heard good programmers don't use them. You should start with that post, where I address this question&mdash;if statements have their place and shouldn't be unreasonably feared&mdash;however, I also gave an example of better design with OOP languages (such as Ruby) where polymorphism is often overlooked. A good rule of thumb is if your method is doing different things based on conditions, you should probably think about polymorphism.

In this post I want to address the "if question" using a different tool: hashes. Hashes are a wonderful first-class citizen in Ruby and can often be used to solve decision-type problems.

Let's say I have a list of people and their favorite fruit. I want to write a method that will accept a name and then return their favorite fruit. The less-than-ideal way to write this:

```ruby
def favorite_fruit(name)
  return "cherry" if name == 'Matt'
  return "banana" if name == 'John'
  return "strawberry" if name == 'Sara'
  "Don't know who that is"
end
```

Here's an example of abusing if statements. The method could become quite large depending on how big the list is. Additionally, this list won't scale very well. Adding people and their fruit involves too much knowledge of how the method works and requires changing it. Names and fruits are related data, and they should be treated as data. That list should be able to change without affecting our method.

Let's make use of a hash:

```ruby
@favorite_fruits = {
  matt: 'cherry',
  john: 'banana',
  sara: 'strawberry',
}

def favorite_fruit(name)
  return "Don't know who that is" unless fruit = @favorite_fruits[name]
  fruit
end

favorite_fruit(:matt)
```

What if each person has a different favorite fruit on Mondays but all other days are the same? Easy, we extend the hash and our method:

```ruby
@favorite_fruits = {
  matt: {
    default: 'cherry',
    monday: 'kiwi',
  },
  john: {
    default: 'banana',
    monday: 'orange',
  },
  sara: {
    default: 'strawberry',
    monday: 'passion fruit',
  }
}

def favorite_fruit(name, for_date = nil)
  return "Don't know who that is" unless fruits = @favorite_fruits[name]
  weekday = (for_date || Date.today).strftime("%A").downcase.to_sym
  fruits[weekday] || fruits[:default]
end

favorite_fruit(:matt, Time.new(2017, 4, 24))
```

Now we have a hash where we've added a default fruit for each person and a different one on Monday. You'll have to change your system time or you can enter a date for the for_date.

Technially, I've used a conditional for the guard clause:

```ruby
def favorite_fruit(name, for_date = nil)
  return "Don't know who that is" unless fruits = @favorite_fruits[name]
```

This is a perfectly acceptable use of conditionals. The key take away here is that we're avoiding unnecessary if statements to check the name of the person. By making use of the hash, we don't have to write a bunch of conditionals for every possible combination of name and weekday. We can add more people and days of the week to this hash without having to modify our method.
