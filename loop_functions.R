# From the book "R Programming", by Roger D. Peng

# lapply
#---------------------------
x <- list(a = 1:5, b = rnorm(10))
x
lapply(x, mean)

y <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
y
lapply(y, mean)


x <- 1:4
lapply(x, runif)    # runif: r uniform distribution
lapply(x, runif, min=100, max=1000)


# sapply
#---------------------------

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)

sapply(x, mean)

# Because the result of lapply() was a list where each element had length 1, sapply() collapsed the
# output into a numeric vector, which is often more useful than a list.


# split
#---------------------------
#  The combination of split() and a function like lapply() or sapply() is a common paradigm in R.
#  The basic idea is that you can take a data structure, split it into subsets defined by another variable,
# and apply a function over those subsets. The results of applying tha function over the subsets are
#then collated and returned as an object. 
#This sequence of operations is sometimes referred to as “map-reduce” in other contexts.


x <- c(rnorm(10), runif(10), rnorm(10, 1))  # we generate a vector with 30 elements
f <- gl(3, 10)   # gl "generate levels" (3 levels, with 10 elements in each)
split(x, f)   # -> it produces 3 groups, one for each of the levels


# A common idiom is split followed by an lapply.
lapply(split(x, f), mean)  # we get the meean of each group

# Splitting a Data Frame
library(datasets)
head(airquality)

#   Ozone Solar.R Wind Temp Month Day
#1    41     190  7.4   67     5   1
#2    36     118  8.0   72     5   2
#3    12     149 12.6   74     5   3
#4    18     313 11.5   62     5   4
#5    NA      NA 14.3   56     5   5
#6    28      NA 14.9   66     5   6

# We can split the airquality data frame by the Month variable so that we have separate sub-data
#frames for each month.

aq <- split(airquality, airquality$Month)
str(aq)

# Then we can take the column means for Ozone, Solar.R, and Wind for each sub-data frame.

lapply(aq, function(x) {
  colMeans(x[, c("Ozone", "Solar.R", "Wind")])
})

# $`5`
# Ozone  Solar.R     Wind 
# NA       NA 11.62258 
# 
# $`6`
# Ozone   Solar.R      Wind 
# NA 190.16667  10.26667 
# 
# $`7`
# Ozone    Solar.R       Wind 
# NA 216.483871   8.941935
# 
# $`8`
# Ozone  Solar.R     Wind 
# NA       NA 8.793548 
# 
# $`9`
# Ozone  Solar.R     Wind 
# NA 167.4333  10.1800 

# Using sapply() might be better here for a more readable output.

sapply(aq, function(x) {
  colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm=TRUE)
})

# 5         6          7          8         9
# Ozone    23.61538  29.44444  59.115385  59.961538  31.44828
# Solar.R 181.29630 190.16667 216.483871 171.857143 167.43333
# Wind     11.62258  10.26667   8.941935   8.793548  10.18000


# tapply
#---------------------------
# tapply() is used to apply a function over subsets of a vector. It can be thought of as a combination
#of split() and sapply() for vectors only.

## Simulate some data
x <- c(rnorm(10), runif(10), rnorm(10, 1))
## Define some groups with a factor variable
f <- gl(3, 10)
f
#[1] 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3
#Levels: 1 2 3
tapply(x, f, mean)
#          1          2          3 
# -0.4574914  0.4023084  0.4747578 


# apply
#---------------------------
#  The apply() function is used to a evaluate a function (often an anonymous one) over the margins
# of an array. It is most often used to apply a function to the rows or columns of a matrix (which is
# just a 2-dimensional array). However, it can be used with general arrays, for example, to take the
# average of an array of matrices. 
#  Using apply() is not really faster than writing a loop, but it works in one line and is highly compact.

## Simulate some data
m1 <- matrix(rnorm(200), 20, 10)
## Take the mean of each column
apply(m1, 2, mean) 
## Take the mean of each row
apply(m1, 1, mean) 

#  For the special case of column/row sums and column/row means of matrices, we have some useful shortcuts.
# rowSums = apply(x, 1, sum)
# rowMeans = apply(x, 1, mean)
# colSums = apply(x, 2, sum)
# colMeans = apply(x, 2, mean)

# You can apply also the quantiles function:
m2 <- matrix(rnorm(200), 20, 10)
## Get row quantiles
apply(m2, 1, quantile, probs = c(0.25, 0.75))


# mapply
#---------------------------
#  The mapply() function is a multivariate apply of sorts which applies a function in parallel over a set
# of arguments. Recall that lapply() and friends only iterate over a single R object. What if you want
# to iterate over multiple R objects in parallel? This is what mapply() is for.

# For example, the following is tedious to type
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
# With mapply(), instead we can do
mapply(rep, 1:4, 4:1)
