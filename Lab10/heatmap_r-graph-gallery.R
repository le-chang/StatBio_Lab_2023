# https://docs.google.com/presentation/d/1FLJgQh6gnL-H6CrQKnjn5_oa3Pp7b17XdQIwMu8forU/edit?usp=sharing
# Most basic Heatmap ------------------------------------------------------

# The mtcars dataset:
data <- as.matrix(mtcars)

# Default Heatmap
heatmap(data)


# Normalization -----------------------------------------------------------

heatmap(data, scale="column")

# Dendrogram and Reordering -----------------------------------------------

# No dendrogram nor reordering for neither column or row
heatmap(data, Colv = NA, Rowv = NA, scale="column")

# Color palette -----------------------------------------------------------

# 1: native palette from R
heatmap(data, scale="column", col = cm.colors(256))
heatmap(data, scale="column", col = terrain.colors(256))

# 2: Rcolorbrewer palette
library(RColorBrewer)
coul <- colorRampPalette(brewer.pal(8, "PiYG"))(25)
heatmap(data, scale="column", col = coul)
?pheatmap
coul <- colorRampPalette(rev(brewer.pal(n = 7, name ="RdYlBu")))(100)
heatmap(data, scale="column", col = coul)

# R Color Brewer’s palettes -----------------------------------------------

par(mar=c(3,4,2,2))
display.brewer.all()

# Custom Layout -----------------------------------------------------------

# Add classic arguments like main title and axis title
heatmap(data, Colv = NA, Rowv = NA, scale="column", col = coul, xlab="variable", ylab="car", main="heatmap")

# Custom x and y labels with cexRow and labRow (col respectively)
heatmap(data, scale="column", cexRow=1.5, labRow=paste("new_", rownames(data),sep=""), col= colorRampPalette(brewer.pal(8, "Blues"))(25))

# Add color beside heatmap ------------------------------------------------

# Example: grouping from the first letter:
my_group <- as.numeric(as.factor(substr(rownames(data), 1 , 1)))
colSide <- brewer.pal(9, "Set1")[my_group]
colMain <- colorRampPalette(brewer.pal(8, "Blues"))(25)
heatmap(data, Colv = NA, Rowv = NA, scale="column" , RowSideColors=colSide, col=colMain   )


# interactive heatmap -----------------------------------------------------

# Libraries
library(tidyverse)
library(hrbrthemes)
library(viridis)
library(plotly)
library(d3heatmap)
library(htmlwidgets)

# Load data 
data <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/multivariate.csv", header=T, sep=";")
colnames(data) <- gsub("\\.", " ", colnames(data))

# Select a few country
data <- data %>% 
  filter(Country %in% c("France", "Sweden", "Italy", "Spain", "England", "Portugal", "Greece", "Peru", "Chile", "Brazil", "Argentina", "Bolivia", "Venezuela", "Australia", "New Zealand", "Fiji", "China", "India", "Thailand", "Afghanistan", "Bangladesh", "United States of America", "Canada", "Burundi", "Angola", "Kenya", "Togo")) %>%
  arrange(Country) %>%
  mutate(Country = factor(Country, Country))

# Matrix format
mat <- data
rownames(mat) <- mat[,1]
mat <- mat %>% dplyr::select(-Country, -Group, -Continent)
mat <- as.matrix(mat)

# Heatmap

library(heatmaply)
p <- heatmaply(mat, 
               dendrogram = "none",
               xlab = "", ylab = "", 
               main = "",
               scale = "column",
               margins = c(60,100,40,20),
               grid_color = "white",
               grid_width = 0.00001,
               titleX = FALSE,
               hide_colorbar = TRUE,
               branches_lwd = 0.1,
               label_names = c("Country", "Feature:", "Value"),
               fontsize_row = 5, fontsize_col = 5,
               labCol = colnames(mat),
               labRow = rownames(mat),
               heatmap_layers = theme(axis.line=element_blank())
)
p

# hierarchical clustering -------------------------------------------------

p <- heatmaply(mat, 
               #dendrogram = "row",
               xlab = "", ylab = "", 
               main = "",
               scale = "column",
               margins = c(60,100,40,20),
               grid_color = "white",
               grid_width = 0.00001,
               titleX = FALSE,
               hide_colorbar = TRUE,
               branches_lwd = 0.1,
               label_names = c("Country", "Feature:", "Value"),
               fontsize_row = 5, fontsize_col = 5,
               labCol = colnames(mat),
               labRow = rownames(mat),
               heatmap_layers = theme(axis.line=element_blank())
)

#save the widget
library(htmlwidgets)
saveWidget(p, file= "Lab10/heatmapInter.html")
