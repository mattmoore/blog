# Go Is Not Production-Ready

A while back I had picked up Go. I spent some time working with the language for work projects, as well as studying the language outside work. Having come from a C++/Java background, I had found Go's goroutines to be interesting.

I have been studying other languages as well. In particular, I've become very interested in functional programming lately with Clojure and then Haskell. I haven't yet evaluated languages like Erlang or Elixir, though I plan to look into those soon. I do believe that software engineers should be familiar with multiple languages&mdash;enough that they can understand the strengths and weaknesses of the various types of languages and what problems they tend to be best suited to.

This is not intended to be a full examination of Clojure or Haskell. Clojure and Haskell are not the only good FP languages out there. This is also not intended to be an examination of functional programming. However, I will examine why I think doing functional programming in Go is far from ideal. I will only mention it because I have heard this as a defense for Go from some engineers I've worked with. However, I realize that the Go community does not have any intention of Go being an FP styled language, so I won't devote much time to this. While it's possible to do FP in nearly any language that supports functions, those who are serious about Go having an equal footing with better functional languages have clearly not spent any time with those languages.

## But First: A Note on Software Engineering

Before I begin talking about Go, I feel I need to mention something that has bothered me considerably. I'm a professional software engineer. I've worked in a lot of fields over the past 10 years: Aerospace, Military, Healthcare (from both an operations and development perspective), and financial. My job is to help organizations better understand their problems, and then develop a solution to their problems that is cost-effective and drives their bottom line. Those solutions should provide value: they need to solve the organization's current problems without introducing other problems, and they need to be sustainable and scalable. Doing all of that is a very hard task. How well a software engineer accomplishes that is how a software engineer should be evaluated.

I mention this because I think a lot of software engineers fail miserably at it. I don't always do it perfectly myself, but I try to focus on what I've said above as my driving philosophy and end goal when doing my job. A lot of software engineers I've run into either know too little of their own field and are doomed to continue repeating the mistakes of others, or they let their subjective and petty preferences get in the way of accomplishing the final end goal and purpose of software engineering: to solve the organization's problems.

I make a distinction between what I call a programmer versus an engineer. Programmers tend to get hung up on their favorite language without considering how well those languages solve problems. An engineer solves real-world problems with the best tools possible. In the land of software, programming languages are an important tool, but only one of many tools that are necessary for solving problems. That being said, a good software engineer should know multiple languages, and be proficient enough at them to understand their strengths and weaknesses, and understand the domains they are best suited to solving. But it's not enough to know multiple languages under the same category. A good engineer should be familiar with the philosophies of widely differing languages. Why? Because often there is an existing solution to a problem that has proven itself against the battles of engineering history that is best suited to the problem at hand. If we don't learn from the past, we will be doomed to repeat its failures, simply because we never bothered to look at its lessons.

There is a major crisis in software engineering as a profession: software engineers lack professionalism. If doctors behaved the way software engineers behave, we'd have entire populations wiped out by disease. If police officers and soldiers behaved that way, there'd be violence and anarchy, we'd lose wars, and be conquered by tyrants. If firefighters did, the world would go up in flames. Software engineers behave like whiny, lazy little children that fail to take responsibility for their actions and fail to let go of subjective biases and preferences in their work in favor of rationalism and objective empiricism.

Software engineers: keep what I have said in mind as you continue reading.

## How I Evaluate Languages

When evaluating a language, I tend to ask these questions:

- What are the current problems in software engineering?
- What are the goals of the language's designers? How well do they understand the current problems?
- How well do the designer's goals actually align with solving current engineering problems?
- How well does the language achieve the goals of its designers?
- Finally, how well does the language solve real-world problems?

Those questions are very important to me. Again, I'm a software engineer. Programming languages are my primary tools. How well they help me solve actual problems in a high-quality way is tantamount to my being a successful software engineer. At the end of the day, any professional software engineer should evaluate languages and other tools in this manner.

## Current Problems in Software Engineering

There are a lot. I cannot possibly address all of them in detail, but I will highlight some areas that I see as problems, from a language perspective.

### Defects

You'll notice I am calling software problems "defects" and not "bugs". Why? Because I feel that the term "bug" has become trivialized. If there's an issue with a program, often programmers will just shrug their shoulders and say "meh, it's just a minor bug, we'll fix it later". The problem is that this view allows "bugs" to pile up. I prefer to call bugs defects.

Software has a lot of defects&mdash;far more than any other product of engineering, as a general rule. Take, for example, the auto industry. Cars have far fewer defects, on average, than software products. Electronics in general tend to be fairly defect-free when compared to most software.

Software is disgraceful. Software engineers are a disgraceful bunch. Engineers should not be OK with building terrible stuff and releasing it half-baked. There is no good excuse for this. There are ways to ensure the quality of software and yet so many engineers simply don't put in the effort to learn, think, and rigorously apply quality principals. How do we solve defects? Well, there are lots of ways, but here we're focusing on programming languages, so I'll try to keep in line with that.

Software should solve the organization's problems. At the end of the day, a defect is a failure of the software to do that. In order to solve the organization's problems, the engineer has to properly understand the organization and what it does. Then the engineer can create the proper solutions. Given that programming languages are the software engineer's main tool, the engineer needs to understand that some languages are better suited to implementing certain kinds of solutions than others.

### Complexity

Part of why software is so full of defects is because of its complexity. Software does a lot today. I mentioned earlier that the hardware industry is very defect-free compared to the software industry. Part of the reason is that, while hardware has become much improved and somewhat complex over time, its design has been abstracted away toward generic computational models, rather than specific logic. In other words, complex operations aren't implemented in hardware anymore, they're implemented in software. Hardware focuses on running our software based on its much simpler binary system. Consequently, whereas hardware has to focus on how to do more of X computational units, software is where the complex logic is actually implemented.

How do we deal with complexity from a language perspective? We can try to organize our code into logical partitions according to their functional use or domain. That's a very hard thing to do in practice. Some languages let us do it better than others. How easily and concisely we can define domain-specific logic is an important consideration for a language. While any Turing complete language will let us define logic, not all let us do it concisely or efficiently.

Speaking of complexity...

### Concurrency & Parallelism

This is a very difficult topic. As computers take on more, we're finding that orchestrating what they do is becoming increasingly complex. Concurrency and parallelism are not the same. Concurrency is the ability for a given piece of code to run independently from another safely, without damaging the internal state of machinery.

## Problems with Go

### Dependency System

Lack of versioning

### Error Handling

Multiple Return Values

Nils
