
above10 <- function(x) {
  #use <- x>10
  x[x>10]
}


isAboveN <- function(x,n = 10) {
  y = vector("logical", length(x))
  for(i in seq_along(x)) {
    #print(x[i])
    if (x[i]>n) { 
        y[i] <- TRUE
    }
  } 
  y
}

formals(isAboveN)
args(isAboveN)

v1 <- c(22343,13,34,6,34,5,53,14,80234)

result <- above10(v1)
result


result20 <- isAboveN(v1,20)
result20

result10 <- isAboveN(v1)
result10



columnMean <- function(matrix, removeNA = TRUE) {
  numCol <- ncol(matrix)
  means <- numeric(numCol)   
  # means <- vector("numeric",numCol)
  for (i in 1:numCol) {
    means[i] <- mean(matrix[,i], na.rm = removeNA)
    #print(means[i])
  }
  means
}

m1 <- matrix(1:24, 6,4, byrow = TRUE)
#m1[2,2] <- NA
m1
columnMean(m1)


make.power <- function(n) {
  pow <- function(x) {
          x^n
      }
      pow
}

power25 <- make.power(25)
power25(2)

ls(environment(power25))


# Telegrams used to be peppered with the words START and STOP in order to
# demarcate the beginning and end of sentences. Write a function below called 
# telegram that formats sentences for telegrams.
# For example the expression `telegram("Good", "morning")` should evaluate to:
# "START Good morning STOP"

telegram <- function(...){
  paste("START", paste(..., "STOP"))
}




# Let's explore how to "unpack" arguments from an ellipses when you use the
# ellipses as an argument in a function. Below I have an example function that
# is supposed to add two explicitly named arguments called alpha and beta.
# 


# add_alpha_and_beta <- function(...){
#   # First we must capture the ellipsis inside of a list
#   # and then assign the list to a variable. Let's name this
#   # variable `args`.
#
#   args <- list(...)
#
#   # We're now going to assume that there are two named arguments within args
#   # with the names `alpha` and `beta.` We can extract named arguments from
#   # the args list by using the name of the argument and double brackets. The
#   # `args` variable is just a regular list after all!
#   
#   alpha <- args[["alpha"]]
#   beta  <- args[["beta"]]
#
#   # Then we return the sum of alpha and beta.
#
#   alpha + beta 
# }
#
# Have you ever played Mad Libs before? The function below will construct a
# sentence from parts of speech that you provide as arguments. We'll write most
# of the function, but you'll need to unpack the appropriate arguments from the
# ellipses.

mad_libs <- function(...){
  # Do your argument unpacking here!
  args <- list(...)
  place <- args[["place"]]
  adjective <- args[["adjective"]]
  noun <- args[["noun"]]
  
  # Don't modify any code below this comment.
  # Notice the variables you'll need to create in order for the code below to
  # be functional!
  paste("News from", place, "today where", adjective, "students took to the streets in protest of the new", noun, "being installed on campus.")
}