# Rscript is adapted from Jasmine Chong

# Start with getting and setting the working directory
getwd()
setwd("/Users/le/Desktop/StatBINF_lab") # this the directory that I want to work from
getwd()

### Basic assignment

a <- 1
b <- 5
a/b
b-a


### Intro to Logical Variables

100 != 101
100 >= 101
"yeS" == "yes"
"yes" <= "yesterday"

##

c <- T # T or TRUE
d <- F # F or FALSE

c & d
c|d

### Sequences of numbers

1:30
30:1 # reverse
2*1:30 # applied to each number separately

#sequence function

seq(1,30) # equivalent to 1:30
x <- seq(from=1, to=30, by=0.2) # incremental increase 
x <- seq(from=1, to=30, length.out=12) # number of variables

### Intro to Vectors in R

baby.weights <- c(7.5, 6.1, 5.9, 6.2)

## Naming a vector

names(baby.weights) <- c("Amanda", "Nick", "Jessica", "Andy") #opt1 to name baby.weights

baby.names <- c("Amanda", "Nick", "Jessica", "Andy") #opt2 to name baby.weights
names(baby.weights) <- baby.names

## Functions on vectors

c <- c(11, 6, 12, 7, 8)
d <- c(13, 10, 9, 8, 11) 

length(c)
mean(c)
var(c)
sqrt(var(c))
summary(c)
summary(c)
cor(c,d)

## Indexing a vector

# by number
x <- c(1, 2, 3, 4, 5)
x[1] # first element

# by name
names(x) <- c("blue", "green", "orange", "yellow", "pink") 
x[c("green", "pink")]

# by logic
baby.weights <- c(7.5, 6.1, 5.9, 6.2)
big.baby.weights <- baby.weights>6 #Evaluates vector, true if >6, false if <6
big6.baby.weights  <- baby.weights[big.baby.weights]


### Intro to Matrixes in R

matrix(1:16, byrow=TRUE, nrow=4, ncol=4) #byrow is logical

## Creating a matrix

# Create 3 vectors
baby_weights <- c(7.5, 6.1, 5.9, 6.2)
baby_gest_age <- c(37, 35, 36, 38)
baby_length <- c(51.3, 47.7, 42.1, 49.6)

# Combine into 1 vector
baby_info <- c(baby_weights, baby_gest_age, baby_length) 

# Create matrix
baby_matrix <- matrix(baby_info, byrow=TRUE, nrow=3)

# Name the baby_matrix
info <- c("birth weight", "gestational age", "length at birth") 
names <- c("Amanda", "Nick", "Jessica", "Andy") 

rownames(baby_matrix) <- info
colnames(baby_matrix) <- names 

##Editing the matrix

# column bind (add new column) new matrix
new_baby <- c(7.1, 39, 50.1)
baby_matrix_c <- cbind(baby_matrix, new_baby) 

# row bind (add new row) new matrix
baby_head <- c(37.8, 35.2, 34.2, 36.1)
baby_matrix_r <- rbind(baby_matrix, baby_head) 

## Select and matrix elements

baby_matrix_r[2,2] # element at second row, second column
baby_matrix_r[1:3, 1:3] # first 3 elements in rows 1,2,3 and columns 1,2,3

baby_matrix_r[,2] # all elements from 2nd column
baby_matrix_r[2,] # all elements from 2nd row

baby_matrix_new <- baby_matrix_r[,-2] # removes the second column 
baby_matrix_new2 <- baby_matrix_r[-2,] # removes the second row

### Intro to Factors

## Unordered factors
gender <- c("Male", "Female", "Female", "Male", "Female")
genderf <- factor(gender)

print(genderf) # shows the levels
levels(genderf) # find out levels of the factor 

## Ordered factors
temperatures <- c("High", "Low", "High", "Low", "High")
tempf <- factor(temperatures)
print(tempf) # Levels are High/Low
tempf <- factor(tempf, levels=c("Low", "High"))
print(tempf) 

day1 <- tempf[1] #extract element 1
day2 <- tempf[2] #extract element 2
day1 > day2 # NA

## Ordered factors - set to ordered factors, natural ordering
temp_ordered <- factor(temperatures, ordered=TRUE, levels=c("Low", "High"))
day1 <- temp_ordered[1]
day2 <- temp_ordered[2]
day1 > day2

## Question
# vector representing the amount of salt in 5 bags of chips
# "h","l","m","h","m"

salt_chips <- factor(c("h","l","m","h","m"), ordered=TRUE)
salt_chips <- factor(c("h","l","m","h","m"), levels=c("Low", "Medium", "High"))
salt_chips <- factor(c("h","l","m","h","m"), levels=c("Low", "Medium", "High"), ordered=FALSE)
salt_chips <- factor(c("h","l","m","h","m"), levels=c("Low", "Medium", "High"), ordered=TRUE)


### Intro to Lists 

apples <- c("McIntosh", "Fuji", "Gala", "Honeycrisp", "Granny Smith")
trees <- c(100, 200, 300, 150, 175)
good_yield <- c(F, T, T, F, T)

apple_list <- list(apples, trees, good_yield)
print(apple_list)
names(apple_list) <- c("a", "b", "c") #opt 1
print(apple_list)

apple_list_named <- list(a=apples, b=trees, c=good_yield) #opt 2
print(apple_list_named)

# Subsetting a list
apple_list[1] #sub-list of vector 1 - [ ] always a list
apple_list[c(1,3)] #sub-list of vector 1 & 3
apple_list[[2]][1] #returns element 1 in 2nd vector - no longer a list
apple_list[[2]][1] <- 150 #directly change element
apple_list_named$a #subset named elements, works like [[ ]] 



### Intro to Data Frames in R

mtcars
head(mtcars)

# Subsetting data frames

mtcars[4, 3] #what is it selecting?
mtcars["Valiant", "vs"] #subset by row/col name
ncol(mtcars) #number of columns in mtcars
nrow(mtcars) #number of rows in mtcars

# Extending data frames

mtcarsnew <- mtcars[1:4, 1:4]
mtcarsnew$manual <- c(0,1,1,0)
mtcarsnew 

mtcarsnew <- mtcars[1:4, 1:4] #start new (rm manual)
mtcarsnew2 <- mtcars[5:8, 1:4]
mtcarsnew3 <- rbind(mtcarsnew, mtcarsnew2)
print(mtcarsnew3)


### Importing data in R

setwd("~/Desktop/R/R workshop")
bps <- read.csv (file="bps.csv", header=T) #header means that the columns are true titles
head (bps)
attach(bps)

# One-variable plots in R

hist(SYSTBP)
hist(SYSTBP, xlab="Systolic Blood Pressure (mmHg)", main="Histogram of Systolic Blood Pressure") #variable names are all in capitals, don't neet to put datafile name bc of attach function, make sure to seperate things by commas
boxplot(SYSTBP, xlab="Systolic Blood Pressure (mmHg)")
boxplot(SYSTBP~SEX) #how systbp changes with sex 

# Two Variable Plots in R

plot(SYSTBP, DIASTBP) 
plot(SYSTBP[SEX==0], DIASTBP[SEX==0], ylab="Diastolic Blood Pressure", xlab="Systolic Blood Pressure", main="Plot of diastolic against systolic blood pressure for men and women", col="maroon", pch=5)
points(SYSTBP[SEX==1], DIASTBP[SEX==1], col="yellow", pch=4) #points and lines will add to the previous plot, plot will give you a new plot!
legend('topleft', c("Women","Men"), pch=c(2,4), col=c("maroon","yellow"), lty=c(2,4))

# Saving images in R
png(file="example.png")
plot(1:10)
dev.off()


### Data Manipulation and dealing with missing variables

kidney <- read.csv("kidney.csv")
str(kidney) #shows structure of data frame

#how many are missing?
missing <- is.na(kidney$weight) #logical assessment if values are missing 
missing1<-as.numeric(is.na(kidney$weight)) #turns TRUE and FALSE to 0 and 1
sum(missing)

# missing values opt1.1
mean(kidney$weight)
mean(kidney$weight, na.rm=T)

# or opt 1.2
complete <- complete.cases(kidney) #logical vector identifying rows with complete information
kidney.complete <- kidney[complete,] #subset only where rows are complete (TRUE)

# missing values opt2
missing <- is.na(kidney$weight) # identify which are missing (true if missing)
missing
mean(kidney$weight[!missing]) # calculate mean weight of not missing values
kidney$weight[missing] <- 72.8 # assign missing values the mean

### Intro to Functions in R

replace_missing <- data{
  missing <- is.na(data);
  nonmissvalue <- mean(data[!missing]);
  data[missing] <- nonmissvalue;
  return(data);
}


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


