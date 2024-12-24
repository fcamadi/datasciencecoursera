#      Simulation
# Simulating a Linear Model

#  Simulating random numbers is useful but sometimes we want to simulate values that come from a
# specific model. For that we need to specify the model and then simulate from it using the functions
# described above.
#  Suppose we want to simulate from the following linear model
#                          
#                                  y = β0 + β1 x + ε
#
# where ε ∼ N (0, 2^2 ). Assume x ∼ N (0, 1^2 ), β0 = 0.5 and β1 = 2. 
# The variable x might represent an important predictor of the outcome y.

## Always set the seed
set.seed(20)

## Simulate predictor variable
x <- rnorm(100)

## Simulate the error term
e <- rnorm(100, 0, 2)

## Compute the outcome via the model
y <- 0.5 + 2 * x + e

summary(y)
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -6.4084 -1.5402  0.6789  0.6893  2.9303  6.5052 

# We can plot the results of the model simulation:
plot(x, y)


#  If we want to simulate a predictor variable x that is binary instead of having a Normal
# distribution. We can use the rbinom()

set.seed(10)
x <- rbinom(100, 1, 0.5)
str(x)
## 'x' is now 0s and 1s
# int [1:100] 1 0 0 1 0 0 0 0 1 0 ...

# Then we can procede with the rest of the model as before.
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e

plot(x, y)


# Sampling
##################

set.seed(1)
sample(1:10, 4)
# [1] 9 4 7 1
sample(1:10, 4)
# [1] 2 7 3 6

## Doesn't have to be numbers
sample(letters, 5)
# [1] "q" "b" "e" "x" "p"

## Do a random permutation
sample(1:10)
# [1] 4  7 10  6  9  2  8  3  1  5
sample(1:10)
# [1] 5 10 2 8 6 1 4 3 9 7

## Sample w/replacement
sample(1:10, replace = TRUE)
# [1] 6 6 8 1 5 8 7 5 9 5




