# Why Software Engineers Are The Worst Professionals

I've been a software engineer for a decent little while now, and there's an industry problem I've been noticing for a while that is nagging at me.

Software engineers seem focused on all the wrong things, and in the wrong order. In spite of our insistence that we're a scientifically-minded bunch, we constantly make claims that cannot be empirically validated.

Software engineers increasingly seem to focus on irrelevant and premature performance optimizations at the cost of readability and maintainability. We dedicate copious amounts of time fixing lots of small problems in a badly designed system when really the problem is systemic and the direct cause of an improper abstraction, with a Spaghetti Driven Design that a 5 year old could sort out.

Engineers care about ridiculous code styling issues with our shitty programming languages that make us feel morally superior because we spent the last two hours writing a bunch of nested loops with messy state that could easily have been done in mere minutes if we used the right tools. We're so intent on continuing to use tools that fit our preconceived notions, rather than evaluating the best ideas that have already been solved decades ago.

We regularly reject academia as "too difficult" or the idea of logical proofs or empirical demonstrations as not important. At the end of the day we demonstrate just how wrong we are by releasing crappy software that is fundamentally broken, and we shrug our shoulders and pretend that we're mad scientists and that the world just doesn't understand how difficult the work we're doing really is. The reality is that we are just children playing with technology we don't fully understand and we refuse to learn from our mistakes.

On behalf of software engineers, I would like to apologize to the world for the complete and total disgraces that we are. We should be ashamed of ourselves.

I got started in functional programming precisely because of the problems above. Over the last decade of my career I have seen most of the people in the industry focus on "tinkering" with their favorite languages and tools without taking a step back and fundamentally rethinking the problem.

Our industry is heavily dominated by people who love to spend lots of time writing imperative code to solve the same problems over and over. As I sit and listened for the millionth time as someone wrote yet another iterator and god-awful state tracking I began to wonder if there wasn't a better way. It seemed that every single line of code introduced caused a multitude of other bugs in the system. There _had_ to be a better way.

I became interested in two areas of mathematics: Category Theory and Lambda Calculus. Those two areas excited me because they gave me a fundamental shift in thinking about software. I realized that:

1. The scientific method is important.
1. Software engineers do not understand the scientific method.

While I realize that software engineers perceive themselves as the highest form of life on this planet, let me provide a simple definition of the scientific method:

1. Define your claims concisely.
1. Define your terms. Communicate those definitions clearly. Ask people if they understand them. If they nod their heads, ask them to define it back. Discuss examples.
1. Determine a method by which to support or falsify your claims. Understand the default hypothesis (there is no relationship between x and y until it is demonstrated).
1. Define a means by which to carry out an experiment and a way to collect data on the experiment that is meaningful in supporting or falsifying the claim.
1. If the data doesn't support the claim, **throw it into the waste bin!**
1. If your claim is invalid, tweak your claim, adjust the variables, and start over again.
  
I had another realization: formalisms are important. What's a formalism? In a nutshell it's a way to concisely state what a given concept is. If I write some code that loops over a deeply nested collection of items, and I do some computations on them, we're building what I would simply refer to as a big ball of mud. When someone later tries to reason about the code&mdash;for that matter, if we try to reason about it in the larger scale of our program&mdash;we end up with a piece of code that is not maintainable or flexible. Change one single operation, even if we think we know what we're doing, and the whole program burns. Our financial supporters end up with something they can't use, and we're responsible for wasting their money.

Lambda calculus and category theory attempt to formalize the operations we're performing and yield methods to reason formally about those operations in an easily testable manner&mdash;remember I harped on empirical evidence? Rather than having to reason through a bunch of deeply nested loops and state tracking mechanisms&mdash;the underlying mechanics of the code&dash;we should formalize the programming language and style to support two notions:

1. Code that is easy to reason about.
1. Code that is testable and provable.

While I won't go into great detail at this time (my rant is already long enough), here's an example of what I mean:

```golang
// Yes, this is go
func myShittyFunction(terriblePointerToSomeMutableCrap: TypeFromUselessTypeSystem) : [String]WTFAmIReturning {
  ...
  // I care about the mechanics of what's going on here, because it can be easily influenced by external state, as well as screw up the rest of my program via external state manipulation.
  ...
}
```

versus:

```haskell
-- Hello, Haskell!
top15AuthorsByLastName :: [Book] -> [Author]
top15AuthorsByLastName =
  -- I don't care what goes on here, because the function signature tells me everything I need to know about the transformation. Which is what literate FP is all about in Haskell: simple, composable transformations that refuse to mutate state they have no business mutating.
```

When all I have to think about is this line:


```haskell
top15AuthorsByLastName :: [Book] -> [Author]
```

I can easily reason about the program, and I don't have to remember a ton of details. There's an understanding in psychology that the typical human can hold only several things consciously in their brain at a time, before it becomes too much. This means we have to "chunk" and summarize information. Rather than focusing on tons of mechanical details, we should be reasoning abstractly about the goals. Instead, what we've managed to do as programmers is stuff so much useless garbage into our brains as possible that we are unable to reason about the program as a whole. If we make our functions reflect as concisely as possible the final goal we're trying to construct (a top-down approach), we end up with an easily testable program that is composable and adding lines of code has a very low probability of messing things up. Our program then becomes the following:

    Initial Conditions -> Result

Look similar to my Haskell example? When you have a language that allows you to reason like this, you can compose these things together like so:

    Initial Conditions A -> Result B -> Result C

I'm able to start chaining concepts together. This is known as "composition". Composition allows us to focus on the higher level concepts without worrying about the details. You can dig into the details when you want to optimize. Interestingly, however, when you write in a proper compositional style, you start to notice something else:

    Formally composable programs tend not to require as many optimizations.

Why? For two reasons:

1. Composable formalisms allow for easier reasoning, which in turn tends to prevent us from doing boneheaded things that make our software slow and buggy, precisely because there are fewer things to consciously juggle.
1. They're easier to test. Your inputs and outputs are all composable from function to function. They're easy to reason about. You don't have to make any assumptions. It's spelled out concisely in the signatures. You don't need to know the implementation details. And when you do, those implementation details are just other composed functions. Noticing the pattern yet?

Here's the deal: A language that supports proper composition and is written in a literate and functional style removes 90% of the sheer garbage that most engineers love to tinker with (translation: waste time with). OOP patterns, complex state management techniques&mdash;all that goes away. All you have to think about is data in, data out then another data in, data out....

It's all about managing complexity in a top-down fashion where we no longer care about mechanical details.
