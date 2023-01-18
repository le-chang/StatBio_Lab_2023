kidney <- read.csv("kidney.csv")

## Mini activity

# If-else mini activity
# Give row names to the kidney dataset
# option 1
rownames(kidney) <- sample(c(letters, LETTERS), length(rownames(kidney)), replace = F)
# option 2
x <- seq(1:33)
names.x <- paste("patient", x, sep= "_")
rownames(kidney) <- names.x


# if else
if(kidney[10,3] < 18){
  print("young!")
}else if(kidney[10,3] > 18 & kidney[10,3] < 60){
  print("middle-aged!")
}else{
  print("old!")
}



# first replace missing w. average in each column
mean.vals <- apply(kidney, 2, function(x) mean(x, na.rm = TRUE))
kidney$creat_clear[is.na(kidney$creat_clear)] <- mean.vals[1]
kidney$creat_conc[is.na(kidney$creat_conc)] <- mean.vals[2]
kidney$age[is.na(kidney$age)] <- mean.vals[3]
kidney$weight[is.na(kidney$weight)] <- mean.vals[4]

#for loop
creat_conc <- kidney[,2]

risk_patients <- list()

for(i in 1:length(creat_conc)){
  
  if(creat_conc[i] > 1.2){
    risk_patients[[i]] <- rownames(kidney)[i]
  }
  
}

unlist(risk_patients)

# subset age <50 and >50 then calculate ttest
old <- kidney[(kidney$age > 50),]
young <- kidney[(kidney$age < 50),]
t.test(old$creat_conc, young$creat_conc)

# create age factor and append to kidney dataframe
cond <- ifelse(kidney$age < 50, "young", "old")
kidney$group <- factor(cond, levels = c("young", "old"))
t.test(kidney$creat_conc[kidney$group=="young"], kidney$creat_conc[kidney$group=="old"])
