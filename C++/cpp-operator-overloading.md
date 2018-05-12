# C++ Operator Overloading

Some languages, like C++, have a feature called "operator overloading". This allows us to use various operators with our classes in interesting ways.

For example, let's say I have the following Box class:

```c++
class Box {
public:
  double height;
  double width;
  double depth;

  std::string to_string() {
    stringstream s;
    s << "Height: " << height << ", ";
    s << "Width" << width << ", ";
    s << "Depth: " << depth;
    return s.str();
  }
};
```

I can instantiate this and set its variables:

```c++
int main() {
  Box box1;
  box1.height = 10;
  box1.width = 10;
  box1.depth = 10;
  cout << box1.to_string() << endl;
}

Outputs:
$ Height: 10, Width: 10, Depth: 10
```

But what happens if I want to create another box and then combine the dimensions from both boxes? The way the Box class is defined would require me to do something like this:

```c++
box1.height + box2.height;
box1.width + box2.width;
box1.depth + box2.depth;
```

This is quite annoying as I'd have to type out those three lines every time I want to combine box dimensions. if I end up having to do this multiple times, it could get old fast. It's also more code to read and good programmers care about having fewer lines of code to read and the DRY (Don't Repeat Yourself) principle.

So how can we do this better? Wrapping this stuff in a method is one way:

```c++
class Box {
public:
  double height;
  double width;
  double depth;

  // Add dimensions from another box
  Box add(const Box& box2) {
    Box box3;
    box3.height = self->height + box2.height;
    box3.width = self->width + box2.width;
    box3.depth = self->depth + box2.depth;
    return box3;
  }

  std::string to_string() {
    stringstream s;
    s << "Height: " << height << ", ";
    s << "Width" << width << ", ";
    s << "Depth: " << depth;
    return s.str();
  }
};
```

Then we can call:

```c++
box3 = box1.add(box2);
```

While this will create another box with the dimensions of the first two combined, there's an even better way we can do this:

```c++
// Add dimensions from another box
Box add(const Box& box2) {
  Box box3;
  box3.height = self->height + box2.height;
  box3.width = self->width + box2.width;
  box3.depth = self->depth + box2.depth;
  return box3;
}
```

to this:

```c++
// Add dimensions from another box
Box operator+(const Box& box2) {
  Box box3;
  box3.height = self->height + box2.height;
  box3.width = self->width + box2.width;
  box3.depth = self->depth + box2.depth;
  return box3;
}
```

Now we can add two boxes together like so:

```c++
box3 = box1 + box2;
```

This does exactly the same thing as before but using the + operator. This is far more semantic and less clutter than calling a function. It more clearly relates to how we tend to think about the action of adding two boxes. Rather than creating an add function, we overload the + operator instead, and just think of the action as "adding" two boxes the same as we'd normally add two numbers.
