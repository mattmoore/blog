# Category Theory: Functors & Monoids

## Topics

- [Introduction](#introduction)
- [Why do mathematicians use funny words?](#mathematicians-funny-words)
- [What's Category Theory?](#category-theory)
- [What's a functor?](#functor)
- [What's a monoid?](#monoid)

<a name="introduction"></a>

## Introduction

As part of my interest in functional programming, I am also interested in the related mathematical branches of lambda calculus and category theory. Category theory is a very abstract branch of mathematics that can be difficult to understand. On my journey to understand category theory, I wanted to share what I've learned and hopefully others learn along the way.

One of the reasons mathematics education is so difficult is because of terminology. There are a lot of weird sounding words that mathematicians use to describe certain concepts that can often confuse those not familiar with them. I am hoping to demonstrate how these concepts translate into programming, with the hope that it will become clear what's going on with these terms and concepts.

Some of those terms you've possibly heard before, such as functors, semi-groups, monoids and monads. In this first post I'll cover functors, semi-groups and monoids. In a future article, I will talk about monads, but we first need to understand some building blocks.

<a name="mathematicians-funny-words"></a>

## Why do mathematicians use funny words?

We humans use words to describe things. You can use simple words to describe things, but it can take a lot of simple words to describe more complex concepts. So we humans create new words to describe more complex thoughts that are made up of simpler thoughts. Mathematicians do the same thing, as do physicists, chemists, biologists and computer scientists.

Mathematicians, like scientists, build their own vocabulary over time so they can communicate with each other using those terms and phrases so it's very clear what ideas they're talking about. However, this can be confusing to those not familiar with the terminology. My goal is to explain the concept in code, then provide the name that mathematicians happen to use when describing that concept. The etymology of these words is not particularly important to understanding the concepts, but knowing the terminology can be helpful when digging into the mechanics of functional programming languages.

<a name="category-theory"></a>

## What's Category Theory?

Category theory is a branch of mathematics invented in the 1940s by Samuel Eilenberg and Saunders Mac Lane as a way of expressing certain constructions in algebraic topology.

### Algebraic Topologies & Structures

You can think of an algebraic topology as a set of numbers. For example, if you've got a set of numbers 1, 2 and 3, you've got an algebraic topology. Now, there are things we can do with sets such as add 1 to every number in the set (yielding 2, 3 and 4) or multiply every number in the set by 2 (yielding 2, 4 and 6).

If you have a set and one or more operations that you can do to them&mdash;like addition or multiplication&mdash;you've got what mathematicians call an "algebraic structure".

    This is an algebraic structure:
    
    A topology, such as a set x: [1, 2, 3]
    Then an operation, such as multiplication by 2, yielding [2, 4, 6]

Algebraic structures are used in functional programming a lot. Ultimately, it just all boils down to data arranged in specific ways (topologies) and some actions (rules or operations) we can do to the data in these structures. We'll examine some of these structures and rules as we go through this series on category theory.

<a name="functor"></a>

## What's a functor?

From a functional programming perspective, a functor is a data structure (topology) that holds a value or set of values. A common example encountered in programming is a collection of some type, such as a list or an array. But functors don't have to be a list. They can be any kind of structure that holds values.
