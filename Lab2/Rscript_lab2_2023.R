### Data Manipulation and dealing with missing variables

kidney <- read.csv("kidney.csv")
str(kidney) #shows structure of data frame
# We can see “NA”s – this is R telling us there are missing values

#how many are missing?
missing <- is.na(kidney$weight) #logical assessment if values are missing 
missing1<-as.numeric(is.na(kidney$weight)) #turns TRUE and FALSE to 0 and 1
sum(missing)

# missing values opt1.1
mean(kidney$weight) 
# # shows NA because it contains missing values!
# complete removal
# Calculate mean without missing data
mean(kidney$weight, na.rm=T)

# or opt 1.2
# Subset kidney data, keeping only samples with no missing data
complete <- complete.cases(kidney) #logical vector identifying rows with complete information
kidney.complete <- kidney[complete,] #subset only where rows are complete (TRUE)

# missing values opt2
# Replace missing with mean/min values
missing <- is.na(kidney$weight) # identify which are missing (true if missing)
missing
mean(kidney$weight[!missing]) # calculate mean weight of not missing values
kidney$weight[missing] <- 72.8 # assign missing values the mean

# create a function to replace missing vals

replace_missing <- function(data=NA){
  
  missing.inx <- is.na(data)
  non.missing.mean <- mean(data[!missing.inx])
  data[missing.inx] <- non.missing.mean
  return(data)
}

kidney <- replace_missing(kidney) # run the function!

# min in each column
replace_missing <- function(data=NA){
  
  data <- apply(data, 2, function(x) {x[is.na(x)] <- min(x, na.rm=T); x} )
  data <- as.data.frame(data)
  
  return(data)
}

kidney <- replace_missing(kidney)

## If statements

x <- 3
x <- 6

if(x>5){
  print("Hello world!")
}

## If else statements

x <- 3

if(x>5){
  print("Hello world!")
}else{
  print("Cowabunga!")
}



### Intro to for loops

## simple for loop

workshop <- c("Tim", "Laura", "Buzz", "Jay")

for (student in workshop){
  print(c("Hello", student))
}

## a little harder
x <- 1:10
y <- rep(0, 10) #create an empty vector

for (i in 1:10){ # for loop 
  y[i] <- sqrt (x[i]) #for every i in x
}

## Apply function

matrix <- matrix(rnorm(30), nrow=5, ncol=6)
output <- apply(matrix, 2, sum) 

## T-tests
t.test(kidney$age[1:3], kidney$age[4:6]) 

