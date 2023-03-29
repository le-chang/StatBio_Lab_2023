# Library
library(tidyverse)

# Dummy data
x <- LETTERS[1:20]
y <- paste0("var", seq(1,20))

?expand.grid
dat <- expand.grid(X=x, Y=y)

?runif
dat$Z <- runif(400, 0, 5)

# Heatmap 
ggplot(dat, aes(x=X, y=Y, fill= Z)) + 
  geom_tile()

#####practice again using a more substantive example

players <- c("Michael","LeBron","Kobe")
points <- c(35, 40,45)
assists <- c(10,12,5)
rebounds <- c(15,12,5)

basketball <- tibble(players,points,assists,rebounds)

#####standardize the values

basketball$stanardize_points <- basketball$points/max(basketball$points)
basketball$stanardize_assists <- basketball$assists/max(basketball$assists)
basketball$stanardize_rebounds <- basketball$rebounds/max(basketball$rebounds)

basketball_stanardize <- select(basketball,"players","stanardize_points","stanardize_assists","stanardize_rebounds")

long_basketball_scaled <- pivot_longer(basketball_stanardize,c("stanardize_points","stanardize_assists","stanardize_rebounds"),names_to="stat",values_to = "value")

ggplot(long_basketball_scaled, aes(x=players,y=stat,fill=value)) + 
  geom_tile()




