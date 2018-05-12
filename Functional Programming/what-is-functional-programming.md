# What is Functional Programming?

I've been evangelizing functional programming a lot lately. I've been particularly interested in and pushing for Lisps. But I was recently asked, from my perspective, what is functional programming? What is the basic, central concept?

I think the core concept of functional programming is the lambda calculus! Don't get scared by that though, it really just means functions. Instead of the classical OOP concepts of objects that have methods that mutate state, everything collapses down to a pure chain of function calls. There are no OOP-like methods, just pure functions.

To formalize this in more mathematical terms, the OOP notion of a function can be defined as:

*A relation from a set X to a set Y is called a function if each element of X is not directly and deterministically related to a single element in Y; it lacks a direct relationship and can return no element, one element, or multiple elements in Y.*

In other words: *[a|b|c] = f(x)*. You may get some other set of values a, b or c, for the same input x in the function *f(x)* than the values you're expecting. In OOP, where functions can be affected by state, it is not possible to guarantee that the function will always return the same output, even for the same inputs to the function. To contrast that with the FP notion of a function:

*A relation from a set X to a set Y is called a function if each element of X is related to exactly one element in Y.*

To state this in a math-familiar way: *y = f(x)*. This is important to note. Whereas the OOP concept doesn't guarantee that functions are deterministic&mdash;their input set doesn't map directly to a single output set&mdash;FP tries to guarantee a formal mapping between input and output.

What about functional programming in non-functional languages like Ruby, Go or C++? It's entirely possible to do this. However, keep in mind that these languages do not force you to write proper mathematically sound functions, and they don't provide good options for immutable data structures, making safe concurrency much harder. You will have to rely on your dev teams to write proper functional code, and that can be hard to do consistently until everyone has got the concept and coding styles mastered. Consequently, using a proper FP language will force the dev team into writing safer code than if you just rely on them to be very careful with a non-FP language.
