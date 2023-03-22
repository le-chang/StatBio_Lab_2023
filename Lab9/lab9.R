
# traceback() -------------------------------------------------------------

# Define a function that will throw an error
my_function <- function(x) {
  if (x < 0) {
    stop("x must be greater than or equal to 0")
  }
  return(x)
}

# Call the function with an invalid argument
my_function(-1)

# Use traceback() to see the call stack
traceback()


# browser() ---------------------------------------------------------------

# Define a function that will throw an error
my_function <- function(x) {
  if (x < 0) {
    browser()
  }
  return(x)
}

# Call the function with an invalid argument
my_function(-1)

# Enter the browser environment, allowing you to interactively inspect the values of variables and other objects. 
# You can use the n command to step through the code line by line, 
# and the Q command to exit the browser environment.


# debug() -----------------------------------------------------------------
# Define a function that will throw an error
my_function <- function(x) {
  if (x < 0) {
    stop("x must be non-negative")
  }
  return(x)
}

# Call the function with an invalid argument
my_function(-1)

# debug
debug(my_function)
my_function(-1)


# use printing out values of variables to debug your code. ----------------

# Define a function that will throw an error
my_function <- function(x) {
  if (x < 0) {
    print(paste0("x is negative: ", x))
  }
  return(x)
}

# Call the function with an invalid argument
my_function(-1)


