
# traceback() -------------------------------------------------------------

# Define a function that will throw an error
# Define function 'a'
a <- function(x) {
  b(x + 1)
}

# Define function 'b'
b <- function(y) {
  c(y * 2)
}

# Define function 'c'
c <- function(z) {
  stop("An error occurred!")
}

# Call function 'a'
a(5)
# After running the above code, run this command
traceback()

# debug() -----------------------------------------------------------------

# Define function 'a'
a <- function(x) {
  b(x + 1)
}

# Define function 'b'
b <- function(y) {
  c(y * 2)
}

# Define function 'c'
c <- function(z) {
  stop("An error occurred!")
}

# Set debug mode for function 'c'
debug(c)

# Call function 'a'
a(5)

# browser() ---------------------------------------------------------------

# Define function 'a'
a <- function(x) {
  b(x + 1)
}

# Define function 'b'
b <- function(y) {
  c(y * 2)
}

# Define function 'c'
c <- function(z) {
  browser() # Insert the breakpoint using browser() to start interactive debugging
  stop("An error occurred!")
}

# Call function 'a'
a(5)

# Print out values of variables to debug ----------------------------------

# Define function 'a'
a <- function(x) {
  cat("Inside function a: x =", x, "\n")
  b(x + 1)
}

# Define function 'b'
b <- function(y) {
  cat("Inside function b: y =", y, "\n")
  c(y * 2)
}

# Define function 'c'
c <- function(z) {
  cat("Inside function c: z =", z, "\n")
  stop("An error occurred!")
}

# Call function 'a'
a(5)

# print(paste("Inside function a: x =", x))

