# Ruby's Inject Method

In many other languages, if you have a list of things you are summing together, you would normally have a list of numbers and then a loop. Here's what I mean using Ruby:

```ruby
numbers = [1, 2, 5, 3, 1, 1, 2]
sum = 0

for i in numbers
  sum += i
end

puts sum
```

That works, but in the Ruby world we want elegance. There is a nicer way to do this in Ruby:

```ruby
numbers = [1, 2, 5, 3, 1, 1, 2]
numbers.inject { |sum, number| sum += number }
=> 15
```

The inject method acts as a reducer. It allows you to specify an aggregator (sum) and apply an operation on the aggregator. In this case I'm applying addition for each number in the numbers array.

You may also see the exact same thing but with reduce:

```ruby
numbers = [1, 2, 5, 3, 1, 1, 2]
numbers.reduce { |sum, number| sum += number }
=> 15
```

The reduce method is an alias for inject. You can use either naming.

There's an even shorter version of inject. If you want to simply apply the number to the aggregator (sum from above) you can do this:

```ruby
numbers = [1, 2, 5, 3, 1, 1, 2]
numbers.inject(:+)
=> 15
```

You can do the same thing with multiplication:

```ruby
numbers = [1, 2, 5, 3, 1, 1, 2]
numbers.inject(:*)
=> 15
```

We can also reduce arrays! If we take the numbers above and, instead of summing them together we want a list of them multiplied by 2. I can pass in an empty array to the inject method and Ruby will set up the aggregator as an array instead of a single item:

```ruby
numbers.inject([]) { |result, number| result << number * 2 }
=> [2, 4, 10, 6, 2, 2, 4]
```

We could also have done this with map:

```ruby
numbers.map { |number| number * 2 }
=> [2, 4, 10, 6, 2, 2, 4]
```

There are often multiple ways to do things in Ruby, which I consider a good thing! As long as they are simple, elegant solutions that are easy to understand.

We can do the same thing with a hash. I recently ran into a codebase where there was a list of keys but no values. In order to call the value, you had to call a method (named after the key) that would then return the value. Kind of a silly design, but this was easy with inject/reduce:

```ruby
method_keys = ['method1', 'method2', 'method3']

def method1
  "value 1"
end

def method2
  "value 2"
end

def method3
  "value 3"
end

hash = method_keys.inject({}) { |hash, key| hash.merge({ "#{key}": send(key) }) }
=> {:method1=>"value 1", :method2=>"value 2", :method3=>"value 3"}
```

What's happening here is we're passing in an empty hash '{}'. The inject method represents that inside the block with the hash variable. We could have called that anything, it doesn't have to be called hash. The key parameter, which also could be called anything else, represents each individual method_keys item. Next. we call the hash.merge method, which adds two hashes together. The new hash, in this case, which is getting passed into the merge method, is comprised of the current key in this iteration, and we're using the send() method to call the method that is named after it. send() will call any method whose name matches the string passed in. In this example, the method is stored in 'key'.
