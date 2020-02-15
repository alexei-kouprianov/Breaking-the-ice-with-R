###############################################################################
###############################################################################
##
## Basics of data analysis and graphics in R.
## Part one: command-line interface, objects, functions, and file management
##
###############################################################################
###############################################################################

###############################################################################
# The very first steps
###############################################################################

# The first lines of code

5+2
5-2
5*2
5/2
5-2*3
(5-2)*3
2^3
8^(1/3)

# The first functions

sqrt(4)

exp(1)
exp(2)
exp(3)

log(7.4)
log10(100)

# Objects and the 'assign' operator (<-)

a <- 5
b <- 2
c <- a+b
c
pi

###############################################################################
# R objects and functions that create them
###############################################################################

# Introducing classes of R objects

# [Contains no code]

# Vector: the first of the basic classes of objects

test.1 <- c(2, 3, 5, 4, 6, 12)
test.1

2^31-1

test.verylong <- c(1:100)
test.verylong

test.1 + 2
test.1 + c(1, 2)
test.1 + c(1:3)
test.1 + c(1:4)

test.2 <- c(7, 3, 5, 8, 2, 1)
test.1 + test.2

# Not just numbers

test.3 <- c("mouse", "cat", "dog", "cat", "dog", "elephant")
test.3

test.logical <- c(TRUE, FALSE)
test.illogical <- c("TRUE", "FALSE")
test.logical * TRUE
test.illogical * TRUE

# More on functions and a generalised form of their syntax

c(2, 3, 5, 4, 6, 12, 7, 3, 5, 8, 2, 1)
c(test.1, 7, 3, 5, 8, 2, 1)
c(test.1, sqrt(49), 9^(1/2), (6-1), (4+4), 1*2, 9/9)

seq(from=1, to=9, by=2)
seq(by=2, to=9, from=1)
seq(from=1, by=2, to=9)
seq(1, 9, 2)
seq(2, 9, 1)
seq(9, 1, 2)
seq(9, 1, -2)

rep(2, 5)

# Calling elements of a vector

test.1
test.1[2]
test.1[2:4]
test.1[3:1]
test.1[c(1,3:5)]

length(test.1)

length(100)

# Data frames and their elements. Factors

test.df <- data.frame(test.1, test.2, test.3)
test.df
dim(test.df)
nrow(test.df)
ncol(test.df)
length(test.df)

test.df[,1]
test.df[1,]
test.df[2:4,]
test.df[2,3]

str(test.df)
test.df[,3]
str(test.1)
str(test.3)
test.3.f <- as.factor(test.3)
test.3.f
str(test.3.f)

test.df$test.1
test.df$test.3
test.df$test.3[2]
test.df[,"test.2"]

colnames(test.df)
colnames(test.df) <- c("AGE", "NO.OF.SIBLINGS", "SPECIES")
test.df

# Lists and their elements

test.ls <- list(test.1, test.3.f, test.df, test.3[6])
test.ls
str(test.ls)
length(test.ls)

test.ls[[1]]
test.ls[[2]][3]
test.ls[[3]][3,2]
test.ls[[3]]$SPECIES[2]

test.1.ls <- list(test.1.n, test.3, test.ls)
test.1.ls[[3]][[1]][6]

names(test.ls) <- c("SOME.NUMBERS","ANIMALS","ANIMALS.DATA","LONE.ELEPHANT")

test.ls$ANIMALS.DATA$SPECIES[2]

test.1.n <- test.1
names(test.1.n) <- c("Mickey", "Bastet", "Wolfy", "Kitty", "Anubis", "Hannibal")
test.1.n["Mickey"]

test.1.ls <- list(test.1.n, test.3, test.ls)
test.1.ls[[3]][[1]][6]
test.1.ls[[3]]$SOME.NUMBERS[6]

# Reviewing the objects and getting rid of them

ls()
rm("a")
ls()
# To quote help page for rm():
# "You will get no warning, so don't do this unless you are really sure."
# Do not execute the following line mindlessly (it erases all objects)!
# rm(list=ls())

NULL
length(NULL)

b
b <- NULL
b
length(b)

x

test.df
test.df$AGE <- NULL
test.df

test.1.ls
test.1.ls[[3]][[3]] <- NULL
test.1.ls

test.df <- test.df[c(1:3,5:6),]
test.df

###############################################################################
# File management in R
###############################################################################

# Preparing datasets for R

# [Contains no code]

# Navigating through folders

getwd()
dir()
# Do not execute the following line mindlessly!
# setwd()

# Loading your first dataset

students.df <- read.table("kouprianov.students.v.2.0.txt", header=TRUE, sep="\t")
students.1.df <- read.table(dir()[2], h=TRUE, sep="\t")
str(students.df)
str(students.1.df)

help(read.table)

# Saving the code and data

# The following line of code will not work under Mac OS X:
savehistory("myhistory.r")
# Read more on saving the code in Mac OS X at:
# https://cran.r-project.org/bin/macosx/RMacOSX-FAQ.html#History

write.table(test.df, file="animals.txt", sep="\t", row.names=FALSE)

animals.structure <- str(test.df)
writeLines(animals.structure, con=file("animals_structure.txt"))

# Two of the three ways to use the code you saved

# Do not execute the following line of code mindlessly!
loadhistory("myhistory.r") # Comments can be placed at the end of the line too;

# Do not execute the following line of code mindlessly!
source("myscript.r") # This script must be created first;

# Say 'no' to the idea to save the working environment!
q()
