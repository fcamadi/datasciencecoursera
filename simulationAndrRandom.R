#      Simulation
# Generating Random Numbers

#   R comes with a set of pseuodo-random number generators that allow you to simulate from well-known 
#  probability distributions like the Normal, Poisson, and binomial. Some example functions for probability 
#  distributions in R:
# 
# • rnorm: generate random Normal variates with a given mean and standard deviation
# • dnorm: evaluate the Normal probability density (with a given mean/SD) at a point (or vector of points)
# • pnorm: evaluate the cumulative distribution function for a Normal distribution
# • rpois: generate random Poisson variates with a given rate

# For each probability distribution there are typically four functions available that start with a “r”, “d”,
# “p”, and “q”:
#   
# • d for density
# • r for random number generation
# • p for cumulative distribution
# • q for quantile function (inverse cumulative distribution)


## Simulate standard Normal random numbers
x <- rnorm(10)
x
#[1]  0.9259915 -0.3741012  0.3147823 -0.5489113 -1.3847030  0.7443765  1.2084885 -0.9951390  0.2256072  0.7040200

# We can modify the default parameters to simulate numbers with mean 20 and standard deviation 2.
x <- rnorm(10, 20, 2)
x
#[1] 21.68471 18.66900 20.16383 18.85581 22.24963 17.48174 18.80869 21.27973 19.25095 21.28779
summary(x)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 17.48   18.82   19.71   19.97   21.29   22.25 

x <- rnorm(10, 20, 1)
x
#[1] 19.02303 18.78157 19.72775 19.03388 20.18787 19.03853 18.59484 20.04185 18.97067 21.32216


# Seed
# When simulating any random numbers it is essential to set the random number seed. Setting the
# random number seed with set.seed() ensures reproducibility of the sequence of random numbers.
set.seed(10)
rnorm(5)
# [1]  0.01874617 -0.18425254 -1.37133055 -0.59916772  0.29454513
rnorm(5)
# [1]  0.3897943 -1.2080762 -0.3636760 -1.6266727 -0.2564784
set.seed(10)
rnorm(5)
# [1]  0.01874617 -0.18425254 -1.37133055 -0.59916772  0.29454513  <-  again the same values

#
# In general, you should always set the random number seed when conducting a simulation!
#

# Now random numbers with poisson distribution

## Counts with a mean of 1
rpois(10, 1)
# [1] 2 1 2 0 1 1 2 0 2 0
## Counts with a mean of 2
rpois(10, 2)
# [1] 2 0 1 4 2 3 3 5 3 2
## Counts with a mean of 20
rpois(10, 20)
# [1] 17 22 15 14 26 19 20 19 20 14

## Cumulative distribution
ppois(2,2) 
# [1] 0.6766764  # Pr(x <= 2)
ppois(4,2) 
# [1] 0.947347   # Pr(x <= 4)
ppois(6,2) 
# [1] 0.9954662  # Pr(x <= 6)
