################################################################################
#         Week 4 - Programming Assignment: Hospital Quality                    #
################################################################################

getwd()
data <- read.csv("hospitalQuality/outcome-of-care-measures.csv", colClasses = "character")

str(data)

#rename columns not needed
#new_names <- gsub("...Hospital.30.Day.Death..Mortality..Rates.from.", ".Mortality.", colnames(data))
#new_names <- gsub("...Hospital.30.Day.Readmission.Rates.from.", ".Readmission.", new_names)
# colnames(data) <- tolower(new_names)


#colnames(data)
table(data$State)
data_state_TX <- data[State=="TX"]  # not working! (?)
data_state <- subset(data, State == "TX")



# 1) Plot the 30-day mortality rates for heart attack
# 
data[, 11] <- as.numeric(data[, 11]) # because the data in the csv comes as character
## You may get a warning about NAs being introduced; that is okay
hist(data[, 11])


# 2) Finding the best hospital in a state
#
best <- function(state, outcome) {

  # Read outcome data
  data <- read.csv("hospitalQuality/outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  list_states <- unique(data$State)
  list_diseases <- c("heart attack", "heart failure", "pneumonia")
  
  if (!state %in% unique(data$State)) {
    stop("Invalid state")
  }
  if (!tolower(outcome) %in% list_diseases) {
    stop("Invalid outcome")
  }
  
  #data_state <- data[data$State == state]  # not working! (?)
  data_state <- subset(data, State == state)
  
  if (outcome == "heart attack") {
    colnum <- 11
  }
  else if (outcome == "heart failure") {
    colnum <- 17
  }
  else {
    colnum <- 23
  }
  
  data_state_disease <- as.numeric(data_state[ ,colnum])
  minrow <- which.min(data_state_disease)
  hospitals <- data_state[minrow, 2]
  hospitals <- sort(hospitals)
  hospitals[1]
}

#Examples       
best("TX","heart attack")     # -> [1] "CYPRESS FAIRBANKS MEDICAL CENTER"
best("TX", "heart failure")   # -> [1] "FORT DUNCAN MEDICAL CENTER"
best("MD", "heart attack")    # -> [1] "JOHNS HOPKINS HOSPITAL, THE"
best("MD", "pneumonia")       # -> [1] "GREATER BALTIMORE MEDICAL CENTER"

#Quiz questions
best("SC","heart attack")     # -> [1] "MUSC MEDICAL CENTER"
best("NY","pneumonia")        # -> [1] "MAIMONIDES MEDICAL CENTER"
best("AK","pneumonia")        # -> [1] "YUKON KUSKOKWIM DELTA REG HOSPITAL"



# 3) Ranking hospitals by outcome in a state
#
rankhospital <- function(state, outcome, num = "best") {
  
  # Read outcome data
  data <- read.csv("hospitalQuality/outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  list_states <- unique(data$State)
  list_diseases <- c("heart attack", "heart failure", "pneumonia")
  
  if (!state %in% unique(data$State)) {
    stop("Invalid state")
  }
  if (!tolower(outcome) %in% list_diseases) {
    stop("Invalid outcome")
  }
  
  data_state <- subset(data, State == state)

  if (outcome == "heart attack") {
    colnum <- 11
  }
  else if (outcome == "heart failure") {
    colnum <- 17
  }
  else {
    colnum <- 23
  }
  
  ## Return hospital name in that state with the given rank 30-day death rate
  data_state[ ,colnum] <- as.numeric(data_state[ ,colnum])
  date_state_ordered <- data_state[order(data_state[ ,colnum],data_state[,2]), ]
  date_state_ordered <- date_state_ordered[(!is.na(date_state_ordered[ ,colnum])),]

  if(num == "best"){
    num <- 1
  }            
  else if (num == "worst"){
    num <- nrow(date_state_ordered)
  }      

  date_state_ordered[num,2]
}

# Examples
rankhospital2("TX", "heart failure", "best")
rankhospital2("TX", "heart failure", 4)
rankhospital2("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)

# Quiz questions
rankhospital2("NC", "heart attack", "worst")
rankhospital2("WA", "heart attack", 7)
rankhospital2("TX", "pneumonia", 10)
rankhospital2("NY", "heart attack", 7)


# 4) Ranking hospitals in all states
#
rankall <- function(outcome, num = "best") {
  
  # Read outcome data
  data <- read.csv("hospitalQuality/outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  list_states <- unique(data$State)
  list_diseases <- c("heart attack", "heart failure", "pneumonia")
  
  if (!state %in% unique(data$State)) {
    stop("Invalid state")
  }
  if (!tolower(outcome) %in% list_diseases) {
    stop("Invalid outcome")
  }
  
  if (outcome == "heart attack") {
    colnum <- 11
  }
  else if (outcome == "heart failure") {
    colnum <- 17
  }
  else {
    colnum <- 23
  }
  
  ## For each state, find the hospital of the given rank
  
  data[ ,colnum] <- as.numeric(data[ ,colnum])
  data <- data[!is.na(data[ ,colnum]),]
  
  data_states <- split(data, data$State)
 
  # we order each state in data_states
  sol = lapply(data_states, function(x, num) {
    x = x[order(x[,colnum], x$Hospital.Name),]
    
    if(num == "best") {
        return (x$Hospital.Name[1])
    }
    else if(num == "worst") {
      return (x$Hospital.Name[nrow(x)])
    }
    else {
      return (x$Hospital.Name[num])
    }
  }, num)
  
  ## Return a data frame with the hospital names and the (abbreviated) state name
  data.frame(hospital=unlist(sol), state=names(sol))
  
}

# Examples
head(rankall("heart attack", 20), 10)
# hospital state
# AK                                <NA>    AK
# AL      D W MCMILLAN MEMORIAL HOSPITAL    AL
# AR   ARKANSAS METHODIST MEDICAL CENTER    AR
# AZ JOHN C LINCOLN DEER VALLEY HOSPITAL    AZ
# CA               SHERMAN OAKS HOSPITAL    CA
# CO            SKY RIDGE MEDICAL CENTER    CO
# CT             MIDSTATE MEDICAL CENTER    CT
# DC                                <NA>    DC
# DE                                <NA>    DE
# FL      SOUTH FLORIDA BAPTIST HOSPITAL    FL
head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

# Quiz questions
r <- rankall("heart attack",4)
as.character(subset(r, state=="HI")$hospital)
r <- rankall("pneumonia", "worst")
as.character(subset(r, state=="NJ")$hospital)
r <- rankall("heart failure", 10)
as.character(subset(r, state=="NV")$hospital)

