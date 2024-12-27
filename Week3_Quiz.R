#
#   Week 3 Quiz
#

## Question 1
#
# Take a look at the 'iris' dataset that comes with R. 
#The data can be loaded with the code:
library(datasets)
data(iris)

str(iris)
# 'data.frame':	150 obs. of  5 variables:
#   $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 


# There will be an object called 'iris' in your workspace. 
# In this dataset, what is the mean of 'Sepal.Length' for the species virginica? 
# Please round your answer to the nearest whole number.

library(data.table)
iris_dt <- as.data.table(iris)
iris_dt[Species == "virginica", mean(Sepal.Length) ]
# [1] 6.588     ->  7

iris_virginica <- iris_dt[Species=="virginica"]
mean(iris_virginica$Sepal.Length)
# [1] 6.588



## Question 2
#
# Continuing with the 'iris' dataset from the previous Question, what R code returns a vector 
# of the means of the variables 'Sepal.Length', 'Sepal.Width', 'Petal.Length', and 'Petal.Width'?

apply(iris[,1:4], 2, mean)


## Question 3
#
# Load the 'mtcars' dataset in R with the following code
library(datasets)
data(mtcars)

# How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)? 
#Select all that apply.

tapply(mtcars$mpg, mtcars$cyl, mean)
with(mtcars, tapply(mpg,cyl,mean))
sapply(split(mtcars$mpg, mtcars$cyl),mean)
#        4        6        8 
# 26.66364 19.74286 15.10000 


## Question 4
#
# Continuing with the 'mtcars' dataset from the previous Question, what is the absolute difference 
# between the average horsepower of 4-cylinder cars and the average horsepower of 8-cylinder cars?

data <- tapply(mtcars$hp, mtcars$cyl, mean)
data
#        4         6         8 
# 82.63636 122.28571 209.21429 
round(data[3]-data[1])
# 127


## Question 5

# If you run  
#             debug(ls)
# what happens when you next call the 'ls' function?
# 
# The execution of 'ls' will suspend at the beginning of the function and you will be in the browser



