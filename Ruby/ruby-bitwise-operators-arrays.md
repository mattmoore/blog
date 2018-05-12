# Ruby Bitwise Operators with Arrays

Ruby supports bitwise operators. Most languages support these operators. But most guides I've seen demonstrate these operators with binary values. What if we apply these in Ruby to arrays?

If we have two arrays containing numbers and we want to create a third array with the contents of the two arrays merged together? We can do this with the binary OR operator:

```ruby
[1, 2, 3] | [3, 4, 5]
=> [1, 2, 3, 4, 5]
```

Notice that the new array contains all values from both, but does not duplicate the 3. The binary OR operator will always copy what exists in either operand (in this case array), but will not duplicate entries.

The AND operator is useful as well. Let's say we want to only copy values that match:

```ruby
[1, 2, 3] & [3, 4, 5]
=> [3]
```

Only the 3 matches in both operands, so only it gets copied. What if we want to only copy stuff from the first array that are not in the second array:

```ruby
[1, 2, 3] - [3, 4, 5]
=> [1, 2]
```

Here's a slightly more interesting one. What if I want all items merged from both, *except* for the matching ones? In other words, I want all the numbers except the common 3. Here's how:

```ruby
a, b = [1, 2, 3], [3, 4, 5]
a - b | b - a
=> [1, 2, 4, 5]
```

As you can see, that gives us all non-matching elements from both sets.

By the way, this all applies to strings as well:

```ruby
a, b = ["Matt", "Joe"], ["Bob", "Joe"]

a | b
=> ["Matt", "Joe", "Bob"]

a & b
=> ["Joe"]

a - b | b - a
=> ["Matt", "Bob"]
```

All of this is done without the need for if statements. I could have written a bunch of loops to create the datasets that I needed, and it would have taken a lot of looping and if statements. Instead, I'm making use of operators on the arrays.

What about lists of objects? We can do the same thing! If we have the following class, we can apply these same operations to the objects, using a property of the object:

```ruby
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

a = [Person.new("Matt"), Person.new("Joe")]
b = [Person.new("Bob"), Person.new("Joe")]

a.map(&:name) | b.map(&:name)
=> ["Matt", "Joe", "Bob"]

a.map(&:name) & b.map(&:name)
=> ["Joe"]

a.map(&:name) - b.map(&:name)
=> ["Matt"]

a.map(&:name) - b.map(&:name) | b.map(&:name) - a.map(&:name)
=> ["Matt", "Bob"]
```

While I'm using the name, I could have just as easily had an ID attribute on the person and used that instead. Using operators is a very easy and quick way to get unions and intersects of various sets.

I can also find out what characters are shared between two names:

```ruby
'John'.split('') & 'Joe'.split('')
=> ["J", "o"]
```

Or I can find the combination of all letters used in both names:

```ruby
'John'.split('') | 'Joe'.split('')
=> ["J", "o", "h", "n", "e"]
```

What about comparing the binary representation of those characters?

```ruby
'John'.split('').map { |c| c.unpack('B*') } & 'Joe'.split('').map { |c| c.unpack('B*') }
=> [["01001010"], ["01101111"]]
```

Here I'm converting the names to arrays with split(''), then mapping that result to binary via the use of unpack('B*'). Then we apply the AND bitwise operator to determine the shared binary values.
