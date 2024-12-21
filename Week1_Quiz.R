getwd()
hw1_data <- read.csv("hw1_data.csv")

# 11) In the dataset provided for this Quiz, what are the column names of the dataset?

names(hw1_data)
str(hw1_data)

# 12)  Extract the first 2 rows of the data frame and print them to the console. What does the output look like?

head(hw1_data, 2)


# 13) How many observations (i.e. rows) are in this data frame?
  
str(hw1_data)

# 14) 

tail(hw1_data, 2)

# 15) What is the value of Ozone in the 47th row?

hw1_data[47,]
hw1_data[47,1]
hw1_data[47,"Ozone"]

# 16) How many missing values are in the Ozone column of this data frame?

sum(is.na(hw1_data$Ozone))


#  17) What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.

mean(hw1_data$Ozone, na.rm = TRUE)

# 18 ) Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90.
# What is the mean of Solar.R in this subset?

# First we clean the dataset
clean <- complete.cases(hw1_data)
hw1_data_clean <- hw1_data[clean, ]

o31_t90 <- hw1_data_clean[hw1_data_clean$Ozone>31 & hw1_data_clean$Temp>90,]
mean(o31_t90$Solar.R)

# 19) What is the mean of "Temp" when "Month" is equal to 6? 

m6 <- hw1_data[hw1_data$Month==6,]
mean(m6$Temp, na.rm = TRUE)

# 20) What was the maximum ozone value in the month of May (i.e. Month is equal to 5)?

m5 <- hw1_data[hw1_data$Month==5,]
max(m5$Ozone, na.rm = TRUE)


