# Class Variables vs Instance Variables in Ruby

Ruby differentiates between class variables and instance variables. For newcomers to Ruby, the difference might be difficult to grok. Let's examine the following class:

```ruby
class Robot
  require 'securerandom'

  attr_reader :serial

  def initialize
    @serial = SecureRandom.uuid
  end
end

asimov = Robot.new
=> #<Robot:0x007f9cec3297a0 @serial="5269e344-4e55-4311-b8ad-07cd77a0d398">
asimov.serial
=> "5269e344-4e55-4311-b8ad-07cd77a0d398"
fido = Robot.new
=> #<Robot:0x007f9cec2e8228 @serial="35668724-cb6c-430e-bbd1-1c069691574d">
fido.serial
=> "35668724-cb6c-430e-bbd1-1c069691574d"
```

While the serials appear different after creating each one, let's just make sure they're different. This might seem redundant, but it will make sense later. If we run the serial method on each object after they've both been created:

```ruby
asimov.serial
=> "5269e344-4e55-4311-b8ad-07cd77a0d398"
fido.serial
=> "35668724-cb6c-430e-bbd1-1c069691574d"
```

Notice the serials of each robot; they're different. Inside the initialize method, we're setting the serial instance attribute:

```ruby
@serial = SecureRandom.uuid
```

Instance attributes are tied to a given object. An object's attributes are not affected by another object's attributes. In the case above, asimov has a different serial than fido. What happens to asimov's serial doesn't affect fido's.

However, with class attributes, this changes. All objects of a given type share the class attribute. If I were to change the class above:

```ruby
class Robot
  require 'securerandom'

  def initialize
    @@serial = SecureRandom.uuid
  end
end

asimov = Robot.new
=> #<Robot:0x007fd6dc9de760>
asimov::serial
=> "bfad0c4c-e53d-43df-8957-7fed1f382bd5"
fido = Robot.new
=> #<Robot:0x007fd6dc2fc960>
fido::serial
=> "d1fd0092-1ee9-4446-b5d3-ae3d99f75c49"
```

While the behavior at this point looks the same, try calling serial again on each robot:

```ruby
asimov::serial
=> "d1fd0092-1ee9-4446-b5d3-ae3d99f75c49"
fido::serial
=> "d1fd0092-1ee9-4446-b5d3-ae3d99f75c49"
```

What happened? They're both the same! This is because, in Ruby, the @@ symbol treats serial as a class attribute instead of an instance attribute. You may also notice that I'm unable to call serial with the dot notation. This is because serial is not tied to the instance. It's tied to the class.

This can be very dangerous behavior if you're not careful. However, you may have a use case where you want this behavior. But you should know what you're doing. In general, most of the time you should not make use of class attributes. Be careful when setting instance attributes that you make sure to use a single '@' and not two '@@'. Two '@@' will create a class attribute and can seriously mess up program state.
