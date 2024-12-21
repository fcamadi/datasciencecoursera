

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
corrrrr <- function(directory, threshold=0) {
  
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

cr <- corrrrr("specdata", 150)
head(cr)
summary(cr)

cr <- corr("specdata", 400)
head(cr)
summary(cr)


cr <- corr("specdata")
summary(cr)
length(cr)
