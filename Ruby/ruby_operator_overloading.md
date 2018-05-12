# Ruby Operator Overloading

A while ago I had written about operator overloading in C++. I was asked about whether Ruby can do this&mdash;absolutely!

Let's define a Ruby Box class, and override the + \* / operators:

```ruby
class Box
  attr_accessor :x, :y, :z

  def initialize(x, y, z)
    @x, @y, @z = x, y, z
  end

  def +(x)
    self.class.new(@x + x.x,
                   @y + x.y,
                   @z + x.z)
  end

  def *(x)
    self.class.new(@x * x,
                   @y * x,
                   @z * x)
  end

  def /(x)
    self.class.new(@x / x,
                   @y / x,
                   @z / x)
  end

end
```

Now we can use the Ruby class with the overloaded operators:

```ruby
box1 = Box.new(1, 1, 1)
box2 = Box.new(2, 2, 2)

puts "Created boxes:"
puts "box1: #{box1.inspect}"
puts "box2: #{box2.inspect}"

puts "\nAdding two boxes:"
puts "box1 + box2: #{(box1 + box2).inspect}"

puts "\nIncrease box size by factor:"
puts "box1 * 2: #{(box1 * 2.0).inspect}"
puts "box1 / 2: #{(box1 / 2.0).inspect}"
```

The result:

```shell
Created boxes:
box1: #<Box:0x007f9c04a2c5b8 @x=1, @y=1, @z=1>
box2: #<Box:0x007f9c04a2c4f0 @x=2, @y=2, @z=2>

Adding two boxes:
box1 + box2: #<Box:0x007f9c04a2ea48 @x=3, @y=3, @z=3>

Increase box size by factor:
box1 * 2: #<Box:0x007f9c04a27e28 @x=2.0, @y=2.0, @z=2.0>
box1 / 2: #<Box:0x007f9c04a27c98 @x=0.5, @y=0.5, @z=0.5>```
```

As you can see, adding two box objects together yields a third box object with the overall combined dimensions x, y, z. Multiplying a given box by a number yields a box with dimensions multiplied by the provided factor. Dividing it does the reverse.
