## Duck Typing

Duck typing is the concept that if an entity "walks like a duck, quacks like a duck, it is a duck." In other words, if I have two classes:

```ruby
class Person
  def self.make_noise
    "talk"
  end
end

class Duck
  def self.make_noise
    "quack"
  end
end

def make_noise(actor)
  actor.make_noise
end

make_noise(Person)
#=> "talk"
make_noise(Duck)
#=> "quack"
```

You'll notice that while both classes are different, they have a method that matches, so I can pass them into make_noise(actor) which doesn't care about whether the it's a Person type or Duck type. As far as its concerned, it's an object that has a make_noise defined and in Ruby, that's good enough.
