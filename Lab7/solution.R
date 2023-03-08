library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)

# Load data
data <- read.csv("employee_data.csv")

# Task 1: Calculate age based on DOB
data <- data %>%
  mutate(Age = as.integer(difftime(Sys.Date(), mdy(DOB), units = "days")/365))

# Task 2: Calculate years of service based on HireDate
data <- data %>%
  mutate(YearsOfService = as.integer(difftime(Sys.Date(), mdy(HireDate), units = "days")/365))

# Task 3: Separate Name into LastName and FirstName variables
data <- data %>%
  separate(Name, into = c("LastName", "FirstName"), sep = "_")

# Task 4: Calculate average salary by department
data_summary <- data %>%
  group_by(Department) %>%
  summarize(AvgSalary = mean(Salary))

# Task 5: Filter employees who have worked for the company for at least 5 years and 
# earn a salary of at least $50,000.
data_filtered <- data %>%
  filter(YearsOfService >= 5 & Salary >= 50000)


# exercise 2
library(tidyr)
library(stringr)

# Read in the data
sales_data <- read_csv("sales_data.csv")

# Rename columns to be consistent
sales_data <- rename(sales_data, Salesperson = "Sales person", Product = "Product", 
                     Region = "Region", Sales = "Sales_total")

# Extract product codes into a new column
sales_data$Product_Code <- str_extract(sales_data$Product, "\\((.*?)\\)")

# Remove product codes from Product column
sales_data$Product <- str_remove(sales_data$Product, "\\(.*?\\)")

# Split Region column into City and State columns
sales_data <- separate(sales_data, col = Region, into = c("City", "State"), sep = ",\\s*")

# Remove dollar signs from Sales column
sales_data$Sales <- as.numeric(str_remove_all(sales_data$Sales, "[$]"))

# Print the cleaned data
sales_data
