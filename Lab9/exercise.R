# Dataset
data <- data.frame(
  id = 1:5,
  name = c("Alice", "Bob", "Charlie", "David", "Eva"),
  age = c(25, 30, 28, 33, 27),
  salary = c(60000, 55000, 70000, 68000, 62000)
)

# R Script with error:
# Load required package
library(dplyr)

# Calculate average age
average_age <- data %>% select(age) %>% mean()

# Calculate average salary
average_salary <- data %>% select(salary) %>% mean()

# Print the results
cat("The average age is:", average_age, "\n")
cat("The average salary is:", average_salary, "\n")
