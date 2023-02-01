## Intro to ggplot2
# download the data from here
# https://drive.google.com/file/d/1EHVwF8VgweSx4ogbSLZHCANiYr0cOUcw/view?usp=share_link

library(ggplot2)
happy <- read.csv("~/github_repo/StatBio_Lab_2023/Lab4/happy.csv")
happy <- happy[,-1]
str(happy)

ggplot(data = happy, mapping = aes(x = gdpPercap, y = lifeExp)) + geom_point()

# modifying text
ggplot(data = happy, mapping = aes(x = gdpPercap, y = lifeExp)) + geom_point() + 
  labs(x = "GDP per capita", y = "Life expectancy", title = "Figure 1") +
  theme(axis.text.x = element_text(angle=90, hjust = 1)) 

## Mini activity
# 1. Add a new column to the data frame specifying which continent the country
# belongs to using the “countrycode” R package
library(countrycode)
countrycode("Canada", origin = "country.name", destination = 'continent')
continent.res <- countrycode(happy$country, origin = "country.name", destination = 'continent')
happy$continent_new <-  countrycode(happy$country, origin = "country.name", destination = 'continent')
  
# example life expectancy over time + centered title
ggplot(data = happy, mapping = aes(x = year, y = lifeExp)) + geom_point() + 
  labs(x = "Year", y = "Life expectancy", title = "Figure 1") +
  theme(axis.text.x = element_text(angle=45, hjust = 1)) + theme(plot.title = element_text(hjust=0.5))

# 2. add color by continent
ggplot(data = happy, mapping = aes(x = year, y = lifeExp, color=continent)) + geom_point() + 
  labs(x = "GDP per capita", y = "Life expectancy", title = "Figure 1", color="Continent") +
  theme(axis.text.x = element_text(angle=45, hjust = 1))

# 3. change the font size of the axis labels to 15 and colored blue
ggplot(data = happy, mapping = aes(x = year, y = lifeExp, color=continent)) + geom_point() + 
  labs(x = "GDP per capita", y = "Life expectancy", title = "Figure 1", color="Continent") +
  theme(axis.text.x = element_text(angle=45, hjust = 1, size = 15, color = "blue"))

# 4. Change the size of the points according to any variable in the dataframe.
# geom_point(aes(size = pop))
ggplot(data = happy, mapping = aes(x = year, y = lifeExp, color=continent)) + geom_point(aes(size = pop)) + 
  labs(x = "GDP per capita", y = "Life expectancy", title = "Figure 1", color="Continent") +
  theme(axis.text.x = element_text(angle=45, hjust = 1, size = 15, color = "blue"))
# 5. Save the plot as a png using ggsave
ggsave("happy.png", width = 4, height = 4)

# 6. Now make it interactive and save it!

library(plotly)

p <- ggplot(data = happy, mapping = aes(x = year, y = lifeExp, color=continent)) + geom_point(aes(size = pop)) + 
  labs(x = "GDP per capita", y = "Life expectancy", title = "Figure 1", color="Continent") +
  theme(axis.text.x = element_text(angle=45, hjust = 1, size = 15, color = "blue"))

int_plot <- ggplotly(p)
htmlwidgets::saveWidget(int_plot, "interactive_plot.html")

# 7 barchart

ggplot(data=happy, aes(continent)) +
  geom_bar()

