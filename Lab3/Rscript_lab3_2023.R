
# Replacing in R (sub, gsub) -----------------------------------

# sub() - replaces first instance of a substring
hello <- "Hello my name is Roger. I am a computer."
sub("a", "A", hello)

# gsub() -  replaces all instances of a substring
gsub("a", "A", hello)


# Matching in R (match) ---------------------------------------------------

# match() returns a vector of the position of the first occurence of vector1 
# in vector2. If no matches, NA returned.
x <- c(1,2,3,4,5,6,7,8)
match(7,x)
7 %in% x

# Matching in R (which) ---------------------------------------------------
#which() returns a vector of the position of the all occurrences of a value 
# if it satisfies the specified condition.
x
which(x>3)
which(x!=1)

phyla <- c("Kingdom","Phylum", "Class", "Order", "Family", "Genus", "Species")
which(phyla %in% "Genus")


