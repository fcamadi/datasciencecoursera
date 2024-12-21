

# Week 2 Prog. Assignment - Part 1.
pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  files <- list.files(directory)[id]
  #print(files)
  data <- data.frame()
  
  for (f in files) {
    fileData <- read.csv(file.path(directory,f), header=TRUE)
    data <- rbind(data,fileData)
  }
  mean(data[,pollutant], na.rm=TRUE) 
   
}

pollutantmean("specdata","sulfate",c(1))
pollutantmean("specdata","sulfate",c(1,10,20,30,55,332))

pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)


# week 2 Prog. Assignment - Part 2.
complete <- function(directory,id=1:332){

  files <- list.files(directory)[id]
  #print(files) 
  
  data <- data.frame()
  
  for (f in files) {
    path <- file.path(directory,f)
    #print(path)
    fileData <- read.csv(path, header=TRUE)
    #remove incomplete rows 
    fileData <- na.omit(fileData)
    nobs<-nrow(fileData)
    
    numrows <- nrow(fileData)
    data <- rbind(data,data.frame(f,nobs))
  }
  data
}

complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)  


# Week 2 Prog. Assignment - Part 3.
cor <- function(directory, threshold=0) {
  
  files <- list.files(directory)
  data <- vector(mode = "numeric")
  
  for (f in files) {
    fileData <- read.csv(file.path(directory,f), header=TRUE)
    fileData <- na.omit(fileData)
    nobs <- nrow(fileData)
    if(nobs>threshold){
      corr <- cor(fileData[,"sulfate"],fileData[,"nitrate"])
      data<-c(data,corr)
    }
  }
  data
}

cr <- cor("specdata", 150)
head(cr)
summary(cr)

cr <- corr("specdata", 400)
head(cr)
summary(cr)


cr <- corr("specdata")
summary(cr)
length(cr)

#Quiz questions:

pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "sulfate", 34)
pollutantmean("specdata", "nitrate")


cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)
cc <- complete("specdata", 54)
print(cc$nobs)

RNGversion("3.5.1")  
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])

cr <- corr("specdata")                
cr <- sort(cr)   
RNGversion("3.5.1")
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)    
RNGversion("3.5.1")
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))
