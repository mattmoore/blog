# Getting Started with Haskell

## The Haskell Setup: Confusing, Not Impossible

I've been on a functional programming quest of late, with my goal being to become familiar with at least a few functional languages. Earlier I posted about Clojure, which opened my eyes on the functional world, but Clojure does dynamic typing. Now I'm not against that, but I was curious to try a statically-typed functional language. I also wanted to try a "purer" functional language, to see what all the rant was about. One of the ones "inspired by the maths". To this end, I fairly randomly decided to pick Haskell. When I say fairly randomly, I mean that I had no better reason other than having watched a few talks about the language and reading up on how it made you think differently.

OK, so the first issue I ran into was how to get a basic Haskell build system. This was not intuitive at all. Basically, the best option it seems these days is to install ```stack```. This can be done on the Mac with homebrew: ```brew install stack ```.

That'll give you a functional compiler called GHC (Glasgow Haskell Compiler). It's part of the haskell-stack that you just installed, so you'll need to call it via ```stack ghc```. There's also a Haskell REPL, which can be called in similar fashion by appending an "i" to the ghc command: ```stack ghci```.

Once that's all done, you're pretty much ready to start writing some Haskell!

## The Haskell Code: Have You a Great Good!

So, first things first, let's discuss a few Haskell basics. Like a lot of languages, you'll need a main function as the entry point into your program. To do this, let's create a folder somewhere on your system called "surveyor". We're going to make a simple survey app that asks people a series of questions about themselves. Inside this folder, let's create a ```Main.hs``` file, and write the cliched hello world app:

```haskell
-- Main.hs
module Main where

main :: IO()
main = putStrLn "Hello World"
```

There are a few things going on here. First, we're declaring a module, named Main. Now, your module name should be the same as the filename. Modules are just a file containing a bunch of functions that, presumably, are related to each other. There are ways to have private and public functions, which I'll get into shortly.

Next, we're declaring a main function via ```main :: IO()```. This means that we will have a function, called main, which will return the IO monad. Oh geez! What's a monad?! Don't worry, I'll explain how that works in a bit. Patience! They're not as hard as you may have heard, they're just described to newbies very poorly.

Finally, we're defining main as ```putStrLn "Hello World"```. ```putStrLn``` is a function that will print a line containing the text passed to it. In Haskell, like Clojure, you don't call functions like ```function(arg)```, you call them like ```(function arg)```. However, unlike Clojure, you don't need the parentheses except to clear up ambiguities. You can therefore call ```function arg``` without them. This is the preferred style in Haskell, it seems.

## The Haskell Compiler: Make Your Code a Great Good!

Now, our code is useless without compiling it. Haskell, by the way, compiles to a native binary. Which is another strength in my view. Given your code is saved in the Main.hs file I mentioned earlier, you can do the following:

```shell
stack ghc -- Main.hs -o surveyor
```

That will generate your program, assuming you have no syntax errors. To run it on the command line:

```shell
./surveyor
Hello World
```

## A Haskell More Useful: Your Input to My Output

So what good is a computer program unless it can take input and adjust its output? No good! The whole point of computers is to interact with the real world. Learn from its environment and then have its say in the environment. If not for this, computers would be a phenomenal waste of time.

Let's modify our program a bit. I could go on creating more functions in ```Main.hs``` and then calling them, but I want to start by creating a new module called Survey that will contain my functions instead. That'll keep the program more modular. So, make a ```Survey.hs``` file:

```haskell
-- Survey.hs
module Survey where
  
import System.IO
import Data.Char
import Data.List

giveSurvey :: IO()
giveSurvey = hSetBuffering stdin LineBuffering
             >> putStr "What is your name? " >> hFlush stdout >> getLine
             >>= (\name -> putStr (greet name)) >> hFlush stdout
             >> putStr "How old are you? " >> hFlush stdout >> getLine
             >>= (\age -> putStr (ageNotice age)) >> hFlush stdout >> getLine
             >>= (\feels -> putStrLn (feelsNotice feels))
       
greet :: String -> String
greet name = "Hello, " ++ properCase name ++ ". "

ageNotice :: String -> String
ageNotice age = "You are " ++ age ++ " years old. Do you feel " ++ age ++ "? "

feelsNotice :: String -> String
feelsNotice feels
  | isPrefixOf "y" feels = "You feel your age."
  | otherwise            = "You should seek help."

properCase :: String -> String
properCase = unwords . map capitalize . words
  where capitalize (x:xs) = toUpper x : map toLower xs
```

Then, let's modify our ```Main.hs``` file to make use of it:

```haskell
-- Main.hs
module Main where

import Survey

main :: IO()
main = giveSurvey
```

Now it's time to compile and run:

```shell
stack ghc -- Main.hs -o surveyor && ./surveyor
What is your name? Matt moore
Hello, Matt Moore. How old are you? 30
You are 30 years old. Do you feel 30? no
You should seek help.
```

In spite of my improperly casing my last name on the input, the application properly cases it, based on the properCase function in the Survey module. Now take some time to study that module, and google each portion you don't know. If you still have questions, you can email me at ```mattmoore at carbonhelix dot com```

## Monads

OK, I wanted to draw your attention to something important to understand here. In the giveSurvey function, notice I'm using a special operator: ```>>``` and ```>>=```. These are often referred to as the "bind" operator. But, their more technical term is a "monadic bind operator". Ah, now we're back to monads! So what is a monad? I feel that most of the explanations I've run across are terrible at explaining them. I'm going to attempt to do a better job, but you'll ultimately be the judge of that. There was a lot in this post to try out and get familiar with, and monads have enough of a learning curve that I'm going to end this post here and continue a full discussion about monads in the next post.
