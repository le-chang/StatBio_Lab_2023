
# Exercise 1 --------------------------------------------------------------

library(dplyr)

# read in the dataset
students <- read.csv("students.csv")

# 1. Filter the dataset to only include students in their freshman and sophomore years.
students_filtered <- students %>% 
  filter(Year %in% c("Freshman", "Sophomore"))

# 2. Create a new column called `GPA_Level`
students_filtered <- students_filtered %>% 
  mutate(GPA_Level = case_when(
    GPA >= 3.5 ~ "High",
    GPA >= 2.5 & GPA < 3.5 ~ "Medium",
    GPA < 2.5 ~ "Low"
  ))

# 3. Group the dataset by `Class`, and calculate the average `GPA` and `Attendance` for each class.
students_grouped <- students_filtered %>% 
  group_by(Class) %>% 
  summarize(avg_GPA = mean(GPA), avg_Attendance = mean(Attendance))

# 4. Arrange the dataset by `Year` and `GPA_Level` in ascending order.
students_arranged <- students_filtered %>% 
  arrange(Year, GPA_Level)

# print the final results
students_filtered
students_grouped
students_arranged


# Exercise 2 --------------------------------------------------------------

library(dplyr)
library(ggplot2)

# read in the dataset
movies <- read.csv("movies.csv")

# 1. Filter the dataset to only include movies from the 21st century.
movies_filtered <- movies %>%
  filter(Year >= 2000)

# 2. Group the dataset by `Year`, and calculate the average `Rating` for each year.
movies_grouped <- movies_filtered %>%
  group_by(Year) %>%
  summarize(avg_rating = mean(Rating))

# 3. Create a bar chart to visualize the results of step 2.
ggplot(movies_grouped, aes(x = Year, y = avg_rating)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Average Movie Ratings by Year",
       x = "Year",
       y = "Average Rating")

