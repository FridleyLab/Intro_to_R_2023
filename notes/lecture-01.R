##### installing and using packages 
# here package and tidyverse

library(tidyverse)
library(here)

# working directories 

getwd()

# R works as a calculator

7*8^2

# we can create new objects in r with <- 
# follows the same pattern: object_name <- object_value
# object names must start with a letter and can only contain 
# letters, numbers, _ and .

x <- 3*4

this_is_a_really_annoying_long_name <- 8
this_is_a_really_annoying_long_name
This_is_a_really_annoying_long_name

# data types and structures
# types: logical, numerical, character
# structures: vector, list, matrix, dataframe/tibble

# c() stands for combine - easiest way to make a vector

x <- c(86, 75, 30, 9)
1/x

c(x, 0, x)
c(x, "additional value", x)

sum(x)

# logical values
# logical operators: <, >, <=, >=, ==, !=

x > 50

# missing values 

y <- c(x, NA)

y+2
y/0
is.na(y)

