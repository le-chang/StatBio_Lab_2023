library(tidyverse)
# Here is an example of how to use pivot_longer() on the iris dataset in R:
# Load iris dataset
data(iris)
head(iris)
# Pivot iris from wide to long format
iris_long <- iris %>% 
  pivot_longer(cols = -Species, names_to = "Variable", values_to = "Value")
head(iris_long)

# Here is an example of how to use pivot_wider() on a long data frame:
# Create sample data frame
df <- data.frame(
  id = c(1, 2, 3),
  variable = c("A", "B", "A"),
  value = c(10, 20, 30)
)
df
# Pivot data frame from long to wide format
df_wide <- df %>% 
  pivot_wider(names_from = variable, values_from = value)
df_wide

# To remove rows with missing values, we can use the drop_na() function:
# Create sample dataset with missing values
df <- data.frame(
  ID = 1:5,
  Name = c("John", "Jane", "Jim", "Jack", "Jill"),
  Age = c(25, 32, NA, 41, 28),
  Gender = c("M", "F", "M", "M", NA)
)
# View the data
df
# Remove rows with missing values
df_clean <- drop_na(df)
# View the cleaned data
df_clean


# Load the stringr package
library(stringr)

# Create a character vector
my_string <- c("R is awesome", "data science is cool", "visualization is fun", "machine learning is exciting")

# Use str_length to get the length of each string
str_length(my_string)

# Use str_sub to extract a substring
str_sub(my_string, start = 1, end = 3)

# Use str_replace to replace a substring
str_replace(my_string, "is", "was")

# Use str_detect to check if a pattern is present
str_detect(my_string, "learning")

# an example
# Create a character vector with some messy names
names <- c("John Doe", "Jane Smith", "Bob Johnson Jr.")

# Create a data frame with the names
my_df <- data.frame(names)

# Use str_split_fixed to split the names into first and last names
new_cols <- str_split_fixed(my_df$names, " ", n = 2)

# Rename the columns
colnames(new_cols) <- c("first_name", "last_name")

# Add the new columns to the data frame
my_df <- cbind(my_df, new_cols)

# View the final data frame
my_df

# Here's an example of how to work with dates and times in the tidyverse using the lubridate package.
#First, we need some example data. Let's create a data frame with two columns: one for dates and one for times.
library(lubridate)

data <- tibble(
  date = as.Date(c("2022-01-01", "2022-01-02", "2022-01-03")),
  time = hms(c("01:00:00", "02:30:00", "03:45:00"))
)

data %>% mutate(year = year(date))
data %>% mutate(hour = hour(time))
# Create example data frame
data <- data.frame(
  id = c(1, 2, 3),
  start_time = as.POSIXct(c("2022-02-01 10:30:00", "2022-02-01 11:15:00", "2022-02-01 12:00:00")),
  end_time = as.POSIXct(c("2022-02-01 11:00:00", "2022-02-01 12:30:00", "2022-02-01 13:00:00"))
)

# Calculate difference in time between start_time and end_time for the first row
difftime(data$start_time[1], data$end_time[1], units = "hours")

