# Asynchronous Ruby

## What is asynchronous processing?

Normally, when a beginner learns to program, the typical program will be synchronous. This means the program executes in a linear fashion from start to end. This works most of the time for simple tasks, but there are certain tasks that can take too long and need to be broken down into smaller pieces that can be run asynchronously. Asynchronous processing, unlike synchronous processing, means parts of the execution of the program can run in parallel.

Many languages, like C++, Java, Erlang, among others, have built-in functionality for asynchronous processing. The common way to handle parallel programming in C++ and Java is via threads. If your computer has multiple processor cores (and most computers do these days), those threads can be distributed out among multiple cores so they are run in parallel. Other languages, like Matz's Implementation of Ruby (known commonly as the MRI), while they contain threads, they are not safe to program using threads. I will get into examples of why this is later.

So is Ruby just hopelessly bereft of parallel processing? Not at all! While you can make use of threads in MRI, it's not recommended to, unless you know what you're doing. However, if you know the right tools and techniques, you can accomplish parallel processing with Ruby in a similar yet different way as languages like C++ and Java.

## Job Queues
