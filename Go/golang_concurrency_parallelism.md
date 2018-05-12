# Golang: Concurrency & Parallelism

In the past I've used threads in C++ and Java for parallel programming. But I'd heard that concurrency and parallelism is easier in Go. So I set out to understand the basics of concurrency and parallelism in Go.

Go uses the concept of channels. The idea is that you can design concurrent processes and then have them communicate via channels. You can then make use of goroutines to parallelize them. Goroutines are simply functions with the keyword "go" in front of them, which makes them spin off as a parallel routine.

Here's a simple Go program that processes 50 jobs that take 1 second each:

```go
package main

import "fmt"
import "time"

func process(i int) string {
  time.Sleep(time.Duration(1) * time.Second)
  return fmt.Sprintf("Job %d done", i)
}

func main() {
  for i := 1; i <= 50; i++ {
    fmt.Println(process(i))
  }
}
```

Not terribly much interesting happening here. It does 50 things in serial&mdash;which takes 50 seconds to complete. Pretty boring and slow, eh? So how do we make this happen in parallel in Go? First, it's important to understand that concurrency isn't the same thing as parallelism. You should watch [Rob Pike - Concurrency Is Not Parallelism](https://www.youtube.com/watch?v=cN_DpYBzKso). You should design your code to be separated into decoupled processes (functions and such).

In languages like C++ or Java, we had to make use of threads and mutexes, and keep track of what was going on with resources. Go handles all of this through goroutines and channels. A goroutine can be written like this:

```go
go func() {
  // do something
}()
```

This will spawn off a separate routine - similar to how "&amp;" in bash will send a process to the background. But if we put that directly into our program, the main() function will end before the process() function has a chance to finish. In order to fix this, we need a way to tell the main() function to wait until the processes it spawns are complete. This is where channels come in:

```go
c := make(chan string)
go func() {
  // do stuff
  c <- "some message"
}()
fmt.Println(c)
```

Let's apply this generic example to our original program:

```go
package main

import "fmt"
import "time"

func process(i int) string {
  time.Sleep(time.Duration(1) * time.Second)
  return fmt.Sprintf("Job %d done", i)
}

func main() {
  jobCount := 50
  c := make(chan string)

  // Create 50 goroutines
  for i := 1; i <= jobCount; i++ {
    go func(i int) {
      c <- process(i) // send the result of process(i) to the channel c
    }(i)
  }

  // Fetch the goroutine messages in the channel once they're done.
  for i := 1; i <= jobCount; i++ {
    fmt.Println(<-c) // read the message from channel c
  }
}
```

Sweet! Now when we run it, we get all 50 jobs completing in 1 second. And we did all this without needing to mess with threads or mutexes. Trust me, that gets old fast!
