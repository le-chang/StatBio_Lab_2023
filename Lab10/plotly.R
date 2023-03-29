library(tidyverse)
library(plotly)

######this code from: https://plotly.com/ggplot2/geom_point/

# Make some noisily increasing data
dat <- data.frame(cond = rep(c("A", "B"), each=10),
                  xvar = 1:20 + rnorm(20,sd=3),
                  yvar = 1:20 + rnorm(20,sd=3))

p <- ggplot(dat, aes(x=xvar, y=yvar)) +
  geom_point(shape=1)      # Use hollow circles

fig <- ggplotly(p)

fig

######animations with plotly
####adapted from https://plotly-r.com/animating-views.html

###import cel data
cel <- read_csv(url("https://www.dropbox.com/s/4ebgnkdhhxo5rac/cel_volden_wiseman%20_coursera.csv?raw=1"))

###create a ggplot scatter plot of LES against seniority

cel$Party<-recode(cel$dem,`1`="Democrat",`0`="Republican")

ggplot(cel,aes(x=seniority,y=les,
                    color=Party))+
  geom_point()+
  scale_color_manual(values=c("blue","red"))

###wrap the whole ggplot figure in a ggplotly() function, and add a frame option in the aes(), telling plotly to redraw and figure for every year.
#This creates an animated figure

ggplotly(
ggplot(cel,aes(x=seniority,y=les,
               color=Party,
               frame=year))+####this animates the figure
  geom_point()+
  labs(x="Seniority",y="Leg. Effectiveness")+
  scale_color_manual(values=c("blue","red"))
)

####add an ids option to create object constancy - if the same member is in multiple congresses, move that point independently

ggplotly(
  ggplot(cel,aes(x=seniority,y=les,
               color=Party,
               frame=year,
               ids=thomas_name))+#####adds the object constancy
  geom_point()+
  labs(x="Seniority",y="Leg. Effectiveness")+
  scale_color_manual(values=c("blue","red"))
)


###you could further modify and refine this with animation_opts(), add_markers(), animation_button(), or animation_slider()




