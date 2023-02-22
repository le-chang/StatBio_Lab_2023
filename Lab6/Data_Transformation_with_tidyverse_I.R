library(tidyverse)
# Data Transformation with tidyverse (I) ----------------------------------


# Convert an untidy data set into a tidy data -----------------------------

# Example of an untidy data set
student_scores <- data.frame(
  name = c("Alice", "Bob", "Charlie"),
  math = c(85, 92, 78),
  science = c(89, 93, 81),
  english = c(91, 87, 84)
)

# Output
# name math science english
# 1   Alice   85      89      91
# 2     Bob   92      93      87
# 3 Charlie   78      81      84

# Load the tidyr package
library(tidyr)

# Convert the data to tidy format using gather
tidy_student_scores <- gather(student_scores, key = "subject", value = "score", -name)

# Output
# name  subject score
# 1    Alice     math    85
# 2      Bob     math    92
# 3  Charlie     math    78
# 4    Alice  science    89
# 5      Bob  science    93
# 6  Charlie  science    81
# 7    Alice  english    91
# 8      Bob  english    87
# 9  Charlie  english    84

# Principles of the "verb" syntax -----------------------------------------


# Load the tidyverse package
library(tidyverse)

# Load the mtcars dataset
data(mtcars)

# Filter to only include cars with four gears
mtcars %>%
  filter(gear == 4) %>%
  
  # Select only the mpg  hp, and cyl columns
  select(mpg, hp, cyl) %>%
  
  # Create a new variable based on existing ones
  mutate(hp_per_mpg = hp / mpg) %>% 
  
  # Group the data by the number of cylinders
  group_by(cyl) %>%
  
  # Calculate the average hp_per_mpg by cylinder
  summarise(avg_hp_per_mpg = mean(hp_per_mpg)) %>%
  
  # Arrange the results by descending hp_per_mpg
  arrange(desc(avg_hp_per_mpg))


# Data importing and exporting --------------------------------------------

# Import
library(readr)
mydata <- read_csv("mydata.csv")

# Export
mydata <- data.frame(
  Name = c("John", "Mary", "David"),
  Age = c(30, 25, 40),
  Height = c(180, 165, 175)
)
write_csv(mydata, "mydata_exported.csv")



# Data wrangling with dplyr -----------------------------------------------

library(tidyverse)

# Import data
my_data <- read_csv("my_data.csv")

my_data <- data.frame(
  Date = c("2023-01-23", "2023-01-24", "2023-01-25"),
  Temp = c(30, 25, 40)
)
# Select and rename variables
my_data %>%
  select(date = Date, temperature = Temp) %>%
  
  # Filter rows and group data
  filter(temperature > 0) %>%
  group_by(date) %>%
  
  # Summarize data and arrange results
  summarise(mean_temp = mean(temperature)) %>%
  arrange(date) %>%
  
  # Export results
  write_csv("mean_temps.csv")



# Selecting columns with select() -----------------------------------------

mydata <- data.frame(
  Name = c("John", "Mary", "David"),
  Age = c(30, 25, 40),
  Height = c(180, 165, 175),
  Weight = c(75, 60, 80)
)
library(dplyr)
mydata_selected <- select(mydata, Name, Age)
# Display the selected columns
mydata_selected

# Name Age
# 1  John  30
# 2  Mary  25
# 3 David  40


# Filtering rows with filter() --------------------------------------------

# to select only the rows where Age is greater than 25
mydata_filtered <- filter(mydata, Age > 25)

# Display the filtered rows
mydata_filtered
# Name Age Height Weight
# 1  John  30    180     75
# 2 David  40    175     80


# Grouping and summarizing with group_by() and summarize() ----------------

mydata <- data.frame(
  Gender = c("Male", "Female", "Male", "Male", "Female", "Female"),
  Age = c(30, 25, 40, 35, 28, 32),
  Height = c(180, 165, 175, 170, 160, 175),
  Weight = c(75, 60, 80, 70, 55, 65)
)
mydata_summary <- mydata %>%
  group_by(Gender) %>%
  summarize(
    AvgAge = mean(Age),
    AvgHeight = mean(Height),
    AvgWeight = mean(Weight)
  )
# Display the summary statistics
mydata_summary

# A tibble: 2 x 4
# Gender AvgAge AvgHeight AvgWeight
# <chr>   <dbl>     <dbl>     <dbl>
#   1 Female   28.3      166.7      60 
# 2 Male     33.3      175        75 


# Mutating data with mutate() ---------------------------------------------

mydata <- data.frame(
  Name = c("John", "Mary", "David"),
  Age = c(30, 25, 40),
  Height = c(180, 165, 175),
  Weight = c(75, 60, 80)
)

mydata_mutated <- mydata %>%
  mutate(BMI = Weight / (Height/100)^2)

# Display the mutated data
mydata_mutated

# Name Age Height Weight      BMI
# 1  John  30    180     75 23.14815
# 2  Mary  25    165     60 22.03857
# 3 David  40    175     80 26.12245


# Joining tables with left_join() -----------------------------------------

mydata1 <- data.frame(
  Name = c("John", "Mary", "David"),
  Age = c(30, 25, 40),
  Height = c(180, 165, 175)
)

mydata2 <- data.frame(
  Name = c("Mary", "David", "Peter"),
  Weight = c(60, 80, 70)
)

mydata_joined <- left_join(mydata1, mydata2, by = "Name")

# Display the joined data
mydata_joined


# Name Age Height Weight
# 1  John  30    180     NA
# 2  Mary  25    165     60
# 3 David  40    175     80

