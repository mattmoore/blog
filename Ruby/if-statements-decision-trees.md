# Should I Use if Statements? Part 2 (Or Decision Trees to The Rescue)

Yesterday I posted about using proper OOP to replace unnecessary if statements. I discussed implementing polymorphic behavior using the type system inherent to OOP. By doing this, we went from messy if statements to no if statements and yet achieving the desired functionality.

Now let's talk about decision trees. As I mentioned in the last article on polymorphism, while it's OK to use if statements, we want to make sure we don't end up nesting a bunch of if statements (leading to arrowhead code) nor do we want to make methods more complex than they should be. We want each method to be clear about what it's doing. We also want to keep cyclomatic complexity as low as possible.

Writing code is all about making decisions. If statements are a very basic component of that. Let's say we are a lender that operates in 5 different states in the U.S. We've got a customer who has a loan and we're trying to determine what the interest rate should be for that customer. Each statement has laws which specify how much you can charge for interest in terms of percent of principal:

- California: 5%
- Illinois: 4%
- Kansas: 8%
- New York: 6%
- Colorado: 3%

Simple enough? Well, we could use a bunch of if statements to figure out what the customer state is and then apply the calculation. But we'd need 5 if statements to determine that. We could instead create a hash that stores these values using the state as the key and the interest rate as the value:

```ruby
INTEREST_RATES = {
  CA: 0.05,
  IL: 0.04,
  KS: 0.08,
  NY: 0.06,
  CO: 0.03,
}

customer.state
=> :CA
customer.loan.principal
=> 2000
customer.credit_score
=> 800
interest_amount = interest_rates[customer.state] * customer.loan.principal
```

As you can see, we have a customer living in CA, an 800 credit score and a $2,000 principal loan. So, we apply the simple interest calculation above to determine the amount of interest in dollar terms that we can charge the customer. This works, and doesn't make use of a single if statement. But, the interest rate decision is limited to a single dimension: the customer state. What happens if we need to add an additional dimension? For example, the customer credit score. Let's say a customer can have a credit score ranging between 200 and 800, where 200 is terrible and 800 is perfect. Now let's say that&mdash;only in CA&mdash;we're allowed to charge 8% interest if the customer's score is below 600. If the customer's score is at least 600, then we can only charge 5%. How can we code this?

Well, we could start by writing a lot of if statements:

```ruby
if customer.state = :CA
  if customer.credit_score >= 600
    interest_rate = 0.05 * customer.loan.principal
  elsif customer.credit_score < 600
    interest_rate = 0.08 * customer.loan.principal
  end
end
```

That is starting to get a bit untidy and, as we add more conditions, it will become very difficult to read and understand later. It's becoming drastically more error-prone. If we instead implement a decision tree, we can solve this problem in a much nicer, less error-prone way.

The basic concept behind a decision tree is that we define a set of features, and then associate those features with a given label (interest rate). In our example, we have the following features to look at:

- Customer state
- Customer credit score

We also have labels. The label in this case would be the interest rates we defined for each state. But, rather than use a simple hash of state/rate key/value pairs, since we are moving in a more complex direction, let's create a mapping between the features and the interest rate.

```ruby
INTEREST_RATES = [
  0.05: [:good_credit_score, :state_ca]
]
```
