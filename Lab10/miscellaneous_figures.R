library(tidyverse)

######Import example data, dropping NAs
#########You can use the URLs here, or if they are broken or you prefer, download files to your own computer and put in working directory

cces <- drop_na(read_csv(url("https://www.dropbox.com/s/ahmt12y39unicd2/cces_sample_coursera.csv?raw=1")))

cel <- read_csv(url("https://www.dropbox.com/s/4ebgnkdhhxo5rac/cel_volden_wiseman%20_coursera.csv?raw=1"))

#####Variations on Scatterplots
####Add a best-fit line with geom_smooth

####Adapted from https://r-graphics.org/recipe-scatter-fitlines
####Also adapted from https://ggplot2.tidyverse.org/reference/geom_smooth.html

####Using some survey data

ggplot(cces,aes(x=educ,y=ideo5))+
  geom_jitter()
  

ggplot(cces,aes(x=educ,y=ideo5))+
  geom_jitter()+
  geom_smooth() ####the default line is a loess curve
  
ggplot(cces,aes(x=educ,y=ideo5))+
  geom_jitter()+
  #geom_smooth(method="loess") ####the default line is a loess curve
  geom_smooth(method="lm") ####change the method for drawing the line, here using linear regression

###Change the confidence level

ggplot(cces,aes(x=educ,y=ideo5))+
  geom_jitter()+
  #geom_smooth(method="loess") ####the default line is a loess curve
  #geom_smooth(method="lm") ####change the method for drawing the line
  geom_smooth(method="lm",level=.9) ###specify confidence level




####Scatterplot Matrix
#https://rkabacoff.github.io/datavis/Other.html#scatterplot-matrix

#install.packages("GGally")
library(GGally)

####Make up some numeric data. Two variables will be positively correlated, and the third will be negatively correlated with the first

var1<-runif(100,min=0,max=1)
var2<- var1+rnorm(100,1,.2)
var3<- var1*(-rnorm(100,1,.2))

df<-tibble(var1,var2,var3)

ggpairs(df)

######Customize the matrix figures

####Write your own function for the scatterplot

my_scatter<-function(data,mapping){
  ggplot(data=data,mapping=mapping)+
    geom_jitter(color="red")
}

####Write your own function for the density plot

my_density<-function(data,mapping){
   ggplot(data=data,mapping=mapping)+
   geom_density(alpha=.05,
               fill="red")
}

#####substitute your functions for the functions that ggpairs() uses to draw the figures
  
ggpairs(df,
        lower=list(continuous=my_scatter),
        diag=list(continuous=my_density))

#### Correlation plots
#https://rkabacoff.github.io/datavis/Models.html#Corrplot

#install.packages("ggcorrplot")
library(ggcorrplot)
library(ggthemes)

#####Use some example survey data

df<- cces %>% select("educ","pid7","pew_religimp")

#####calculate correlation coefficients

r<-cor(df,use="complete.obs")

####generate the correlation plot

ggcorrplot(r)

####show just the lower part of the figure (to avoid 1 correlations on the diagonals)

ggcorrplot(r,type="lower")

####modify some visual elements

ggcorrplot(r,type="lower",
           title="Correlations",
           colors=c("yellow","green","blue"),
           outline.color="purple")

####Use a ggtheme if you want

ggcorrplot(r,type="lower",
           title="Correlations",
           ggtheme=theme_dark())



#####Cleveland Dot Plots
#Adapted from https://r-graphics.org/recipe-bar-graph-dot-plot

####Use some of the congress data

cel_114<- cel %>% filter(congress==114)

members<-sample_n(cel_114,25)

####points only

ggplot(members,aes(x=les,y=thomas_name))+
  geom_point()

####Some refinements

ggplot(members,aes(x=les,y=reorder(thomas_name,les)))+######reorder in descending
  geom_point(size=5)+
  theme(panel.grid.major.x=element_blank(),
        panel.grid.minor.x=element_blank(),
        panel.grid.major.y=element_line(linetype="dashed",color="blue"))+
  labs(x="Legislative Effectivness",y="")

#Lollipop figure

ggplot(members,aes(x=reorder(thomas_name,les),y=les))+
  geom_point()+
  geom_segment(aes(x=thomas_name,xend=thomas_name,y=0,yend=les))+
  theme(axis.text.x=element_text(angle=90))

########More temporal figures

#####geom_area()

#####A line chart that is filled in below
#Adapted from https://r-graphics.org/recipe-line-graph-area

#####make temporal data

var1<-runif(10,0,25)
time<-seq(1:10)

df<-tibble(var1,time)

####just filling in the space under the line

ggplot(df,aes(x=time,y=var1))+
  geom_area() ####color in the area under the line

####a little aesthetic tweaking

ggplot(df,aes(x=time,y=var1,fill="red"))+ ####set the color
  geom_area()+
  guides(fill=FALSE) ##drop legend

#####Make a stacked line graph

##adapted from https://r-graphics.org/recipe-line-graph-stacked-area

####Create fake data for three people at three different time points

Bob<-tibble(person=rep("Bob",5),time=seq(1:5),change=runif(5,0,25))
Sue<-tibble(person=rep("Sue",5),time=seq(1:5),change=runif(5,0,25))
Lisa<-tibble(person=rep("Lisa",5),time=seq(1:5),change=runif(5,0,25))

df<-bind_rows(Bob,Sue,Lisa)

####plot the stacked lineplot

ggplot(df,aes(x=time,y=change,fill=person))+
  geom_area()

####test your understanding of what the plot is showing
df_wide<- df %>% 
  pivot_wider(id_cols=time,values_from=change,names_from=person)

####note that the stacked areas add up to the totals
df_wide$total<-
  df_wide$Bob+
  df_wide$Sue+
  df_wide$Lisa

####Dumbbell charts
#Adapted from https://rkabacoff.github.io/datavis/Time.html#dumbbell-charts

#install.packages("ggalt")
library(ggalt)

#####reformat the fake data from the stacked area chart, so we are comparing times at 1 and 5 for Bob, Sue, and Lisa

df2<- df %>%
  filter(time==1 | time==5) %>%
  pivot_wider(names_from = time,values_from=change) %>%
  rename(year1=`1`,year5=`5`)

###basic dumbbell chart

ggplot(df2,
       aes(y=person,
           x=year1, ####the starting point, earliest time
           xend=year5))+ ####the ending point, final time
       geom_dumbbell() ####connects the points

####reorder the y axis

ggplot(df2,
       aes(y=reorder(person,year1), ####reorders the y axis
           x=year1,
           xend=year5))+
       geom_dumbbell()
      
####change the colors and sizes

ggplot(df2,
       aes(y=reorder(person,year1), ####reorders the y axis
           x=year1,
           xend=year5))+
  geom_dumbbell(
    colour_x="purple", ####adds color --- makes sure you "colour", not color
    colour_xend="red",
    size_x=3,
    size_xend=3
  )

####clean the axis labels

ggplot(df2,
       aes(y=reorder(person,year1),
           x=year1,
           xend=year5))+
  geom_dumbbell(
    colour_x="purple", 
    colour_xend="red",
    size_x=3,
    size_xend=3
  )+
  labs(x="",#### clears out the x axis
       y="Person")

##########Flows

######Alluvial Diagrams
#Adapted from: https://github.com/corybrunson/ggalluvial

#install.packages("ggalluvial")
library("ggalluvial")

####Let's create some fake data about student performance in classes
####21 students are divided in 3 groups, they are men and women, and they get High Pass, Pass, or Fail


group1<-tibble(groupid=groupid<-rep("group1",7),
               studentID=sample(seq(from=1,to=20),7),
               gender=sample(c("M","F"),7,replace=TRUE),
               grades=sample(c("High Pass","Pass","Fail"),7,replace=TRUE))

group2<-tibble(groupid=groupid<-rep("group2",7),
               studentID=sample(seq(from=21,to=30),7),
               gender=sample(c("M","F"),7,replace=TRUE),
               grades=sample(c("High Pass","Pass","Fail"),7,replace=TRUE))

group3<-tibble(groupid=groupid<-rep("group3",7),
               studentID=sample(seq(from=31,to=40),7),
               gender=sample(c("M","F"),7,replace=TRUE),
               grades=sample(c("High Pass","Pass","Fail"),7,replace=TRUE))

students<-bind_rows(group1,group2,group3)

####Summarize data
students_table<- students %>%
  group_by(groupid,gender,grades) %>%
  count()

####barebones alluvial
ggplot(students_table,
       aes(axis1=groupid,
           axis2=grades,
           y=n))+
  geom_alluvium()

####add strata
ggplot(students_table,
       aes(axis1=groupid,
           axis2=grades,
           y=n))+
  geom_alluvium()+
  geom_stratum()

####add labels
ggplot(students_table,
       aes(axis1=groupid,
           axis2=grades,
           y=n))+
  geom_alluvium()+
  geom_stratum()+
  geom_text(stat="stratum",
            aes(label=after_stat(stratum)))

####Change colors
ggplot(students_table,
       aes(axis1=groupid,
           axis2=grades,
           y=n))+
  geom_alluvium(aes(fill=gender))+
  geom_stratum()+
  geom_text(stat="stratum",
            aes(label=after_stat(stratum)))+
  scale_fill_manual(values=c("purple","green"))


#Packed circle figure

#Adapted from https://www.r-graph-gallery.com/305-basic-circle-packing-with-one-level.html

#install.packages("packcircles")
library(packcircles)

####Use congress data as an example
####Sample a number of members from the 114th Congress
cel_114<- cel %>% filter(congress==114)
members<-sample_n(cel_114,25)


####circleProgressiveLayout automatically creates a data frame with x and y centers for circles and radii, based on the values for the data you feed it.
####You'll probably get a message about missing values, don't worry about it - some members didn't get any bills passed, so they are non-positive and are ignored
packing<-circleProgressiveLayout(members$all_pass,sizetype='area')

####add the centers and radii to the sample data
members<-add_column(members,packing)

####Provides more points for ggplot to draw the perimeters of the circles
dat.gg<-circleLayoutVertices(packing,npoints=50)

####combine the circle data with text data
ggplot()+
  geom_polygon(data=dat.gg,
               aes(x=x, ###this x value is the x-axis value of the center of the circles
                   y=y, ###this y value is the x-axis value of the center of the circles
                   group=id, ####this is the id number for the circles
                   fill=as.factor(id), ####fill in the colors for the circles
                   alpha=0.6))+ ####adds some transparency to the colors
  geom_text(data=members, ####You have to respecifiy the data here for the labels
            aes(x=x, ###this x value is the x-axis value of the center of the circles
                y=y,###this y value is the x-axis value of the center of the circles
                size=all_pass,####vary the size of the text based on relative magnitude of the variable of interest
                label=thomas_name))+
  theme(legend.position="none")+
  coord_equal() ####makes your plot square




####Pie Charts

#Don't make these, use a barplot instead. For why, see https://www.data-to-viz.com/caveat/pie.html

#If you really want to make a pie chart, just use pie() from Base R


#This code from https://www.r-graph-gallery.com/131-pie-plot-with-r.html
# Create Data
Prop <- c(3,7,9,1,2)

# Make the default Pie Plot
pie(Prop)

