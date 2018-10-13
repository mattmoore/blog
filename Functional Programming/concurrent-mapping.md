# Concurrent Mapping

If you're reading this, you're probably at least a little familiar with map. The concept is fairly simple: Take a collection of values, and create a new collection of values.

A simple example in Ruby would go something like this:

```ruby
[1, 2, 3].map { |x| x * 2 }
#=> [2, 4, 6]

# or:
[1, 2, 3].map(&2.method(:*))
#=> [2, 4, 6]
```

In Haskell:

```haskell
map (\x -> x * 2) [1, 2, 3]
-- [2,4,6]

-- or:
map (* 2) [1, 2, 3]
-- [2,4,6]
```

What this does, then, is applies a function (x * 2) to each item in the collection, returning a new collection of results. It does this without mutating the original collection.

This is obviously an incredibly useful feature from the functional world, but there is an additional thing we can do with this. Imagine we have a list of files, and we want to fetch all the content and aggregate it. One way to do this is to iterate through a list of files and read them. However, this would be on the order of O(n). Instead, what if we can apply the map concept, but concurrently? In Haskell, this is as simple as importing the `Control.Concurrent.Async` library and then calling `mapConcurrently`:

```haskell
main =
  mapConcurrently readFile ["data1.txt", "data2.txt"]
  >>= \contents -> putStrLn (intercalate ">>>\n" contents)
```

We can also use the `do` notation in Haskell, which some find more readable (I rather enjoy the monadic bind operator, shown above):

```haskell
main = do
  contents <- mapConcurrently readFile ["data1.txt", "data2.txt"]
  putStrLn (intercalate ">>>\n" contents)
```

What mapConcurrently does then, is take a list of file names, and performs the IO operation `readFile` on each one, returning a list of results which are the contents of each file. Next, we `intercalate` the results (join) and print them out.

Our final Haskell program should look something like this:

```haskell
module Main where

import Control.Concurrent.Async
import Data.List

main :: IO ()
main =
  mapConcurrently readFile ["data1.txt", "data2.txt"]
  >>= \x -> putStrLn (intercalate ">>>\n" x)
```

The results:

```
First file contents
>>>
Second file contents
```

This allows us, in a very concise and clear way, to load multiple files concurrently and merge them together.

## Handling Unavailable Files: Broken IO

What if some of the files are unreadable? Haskell's `readFile` will end up throwing an exception. What if we want to apply a special operation to these files? We could apply any operation, but for the sake of clearness I will add a simple requirement: If a given file is unavailable, let's just exclude it from the list. How would we do this?

Let's take our simple example and redefine it. Let's create a new function called `fetchFile` that will take a file path and attempt to read it. The result will be returned as an `Either` monad, which is an ADT (Algebraic Data Type). Basically, that means the `Either` type is constructed of sub-types: `Left` and `Right`. The `Either` monad specifies that only a single of these types will be returned, depending on the result of the operation. When we fetch the file the result of that will either be a `Left` (error) or `Right` (and contain the file contents).

```haskell
fetchFile :: String -> IO String
fetchFile x = (try (readFile x) :: IO (Either IOException String))
  >>= return . fileResult
```

As the function signature indicates, it takes a `String` filename and returns an `IO String` type. This function is marked `IO` since it performs an IO operation, and in Haskell that is explicitly marked as a potentially dangerous operation (it has side effects and can fail). The line beginning with `(try $ readFile ...)` attempts to read the file. `readFile` from the earlier, simpler example will simply throw an IOException if it fails. Here, we are handling that by casting and passing it to the next lambda as an `Either` monad. If the type is `Left`, we got an exception and simply `return ""` - empty string. If it succeeds, we return the file's contents.

`fetchFile` calls another function, `fileResult`. Let's create `fileResult`:

```haskell
fileResult :: Either a String -> String
fileResult (Left _) = ""
fileResult (Right x) = x
```
The `fileResult` function is defined using pattern matching. In a nutshell, pattern matching allows for defining different actions polymorphically depending on the parameter types. If the type returned by `fetchFile` is `Left`, we return an empty string. If the type returned is `Right` then we return the value that was successfully fetched.

Now, let's define a `fetchFiles` method to map over each filename and call the `fetchFile` function we just defined above:

```haskell
fetchFiles :: [String] -> IO [String]
fetchFiles = mapConcurrently fetchFile
```

Think of `fetchFiles` as mapping a set of filenames onto file contents. Next let's define a function to merge the files' contents together:

```haskell
merge :: [String] -> String
merge = intercalate ">>>\n" . filter (/= "")
```

You may notice `merge` composes the `filter` and `intercalate` (join) functions together. We are filtering empty strings, then joining them together. Each file's content will be joined with `>>>`.

Each of these operations is now properly separated and composable. We have the IO operations separated from the logic. We can now put these functions together in the `main` function. Here is the final, full program:

```haskell
module Main where

import Control.Exception
import Control.Concurrent.Async
import Data.List

main :: IO ()
main = putStrLn . merge =<< fetchFiles
  ["data1.txt",
   "data2.txt",
   "data4.txt",
   "data3.txt"]

merge :: [String] -> String
merge = intercalate ">>>\n" . filter(/= "")

fetchFiles :: [String] -> IO [String]
fetchFiles = mapConcurrently fetchFile

fetchFile :: String -> IO String
fetchFile x = (try (readFile x) :: IO (Either IOException String))
  >>= return . fileResult

fileResult :: Either IOException String -> String
fileResult (Left  _) = ""
fileResult (Right x) = x
```

`main` is making more use of function composition, along with the monadic bind operator `=<<`. `fetchFiles` gets called with the list of filenames and the result gets passed to `merge`, then to `putStrLn` which then prints the result out on the console.

Running the above, with 'data4.txt' missing, yields the following:

```
First file
>>>
Second file
>>>
Third file
```

Notice the file order is 1, 2, 4, 3. However, because file 4 is missing, it gets filtered out. Consequently, only the contents of 1, 2 and 3 print out.
