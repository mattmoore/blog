# Folding Functions Part 1: Map

Topics:

- Lists
- Mutable Lists
- Maps

Welcome! Today let's talk about folding functions! What's a folding function? Well, we're about to find out in this and the next two episodes. In this and the next episode, we're going to talk about the first of the folding functions, `map`. We won't discuss just what the full definition of a folding function is, for pragmatic reasons. Just keep in mind that `map` is a folding function. In the third folding function episode we'll examine the meaning of "folding function" and why `map` belongs to this category of functions.

Let's talk about a very common aspect of programming. Often, we will need to store lists of things in memory and then process them. For example:

```kotlin
val list = listOf(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
```

Now, storing a list by itself isn't generally that useful. Usually we want to do something with a list. Let's say we want to create a new list containing a double of all the values. One classical way of doing this is with a loop:

```kotlin
var doubles = mutableListOf<Int>()
for (item in list) {
  doubles.add(item * 2)
}
println(doubles)
// Results in [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
```

This works. However, it is unsafe and inelegant. We are creating a mutable list `doubles` and adding items to it. If some other part of our program has access to the mutable list `doubles`, it can potentially make changes to it and cause conflicts.

Another way to do this is with the `map` function. This function is a "folding function". As mentioned at the beginning of this episode, we'll get to what that means in the third part of our folding functions series.

Here's how to use the `map` function to accomplish the same thing as a for loop:

```kotlin
val doubles = list.map { x -> x * 2 }
```

This does the same thing as the for loop, but we've done it in a concise line of code, it's self-contained, and no mutations are occurring. There's no danger of another program changing our variables in the middle of each item being doubled and stored, because there are simply no variables that can be mutated outside of this single `map` function.

All this is fine and dandy for simple toy examples of lists of numbers. What would we really use this for though? Let's say you have a list of user IDs and you want to get more information about those users, like their first and last names. We can use `map` to do this:

```kotlin
// Create a Kotlin data class to hold our information in a structured way.
data class User(val id: Int, val firstName: String, val lastName: String)

// Create a list of users with the User type we just created above.
val users = listOf(
  User(1, "Alonzo", "Church"),
  User(2, "Grace", "Hopper"),
  User(3, "Matt", "Moore")
)

// Create a lambda that will transform a user ID into the associated `User` object.
val getUser = { id: Int -> users.find { user: User -> user.id == id } }

// Create a lambda that will call the getUser lambda to convert a user ID into the associated `User`.
val getUsers = { ids: List<Int> -> ids.map { id: Int -> getUser(id) } }

// Let's run our function!
getUsers(listOf(1, 2))
```

This yields:

```kotlin
[
  User(id=1, firstName=Alonzo, lastName=Church),
  User(id=2, firstName=Grace, lastName=Hopper)
]
```

Rather than relying on mutable variables that can be changed, we've created immutable variables and lambdas (functions) that allow us to safely transform a list of user IDs into a list of `User` objects, with more details about the user.
