# Golang: Concurrency & Parallelism Part 2

Back in August I wrote up a sample executing a function 50 times in parallel using goroutines and channels. In that example, the code was as follows:

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

There's another way this could be written:

```go
package main

import "fmt"
import "time"

func process(i int, c chan string) {
  go func(i int, c chan string) {
    time.Sleep(time.Duration(1) * time.Second)
    c <- fmt.Sprintf("Job %d done", i)
  }(i, c)
}

func main() {
  jobCount := 50
  c := make(chan string)

  // Create 50 goroutines
  for i := 1; i <= jobCount; i++ {
    process(i, c) // send the result of process(i) to the channel c
  }

  // Fetch the goroutine messages in the channel once they're done.
  for i := 1; i <= jobCount; i++ {
    fmt.Println(<-c) // read the message from channel c
  }
}
```

You might notice I've moved the goroutine into the process() function, and I'm passing the channel itself as a parameter. This leaves us with the channel to be read from within the scope of main, but someone calling the process method doesn't need to explicitly declare the goroutine. Of course, this depends on the problem you're trying to solve, but this is another pattern you can use to remove the need for setup of the goroutine in the code calling your process() function, whatever it may be. It makes for a cleaner main() function.
