################################################################
################################################################
# 
# Some data transformantions
# 
################################################################
################################################################

################################################################
# Sorting

# Generalised form:

# Vectors and Factors:
# order(x) # returns numbers of x elements sorted alphanumerically in ascending order
# order(-x) # returns numbers of x sorted alphanumerically in descending order
# x[order(x)] # returns x sorted alphanumerically in ascending order
# x[order(-x)] # returns x sorted alphanumerically in descending order

# Data frames:
# order(x$y) # returns numbers of x$y elements sorted alphanumerically in ascending order
# order(-x$y) # returns numbers of x$y elements sorted alphanumerically in descending order
# x[order(x$y),] # returns x sorted alphanumerically in ascending order of x$y
# x[order(-x$y),] # returns x sorted alphanumerically in descending order of x$y

# Examples

phil <- read.table("philosophers.txt", h=TRUE, sep="\t")

phil

phil.snd <- phil[order(-phil$NAMES),]

phil.snd

phil.sfa <- phil[order(phil$Freq),]

phil.sfa

phil.sfd <- phil[order(-phil$Freq),]

phil.sfd

################################################################
# Subsetting

# Generalised form:
# subset(x, conditions) # returns elements of x that meet the conditions

# Conditions can be specified in several ways:
# x == value # returns elements of x that are equivalent to the value (for all kinds of values except NA)
# x != value # returns elements of x that are not equivalent to the value (for all kinds of values except NA)
# x >= value # returns elements of x that are greater than or equal to the value (for numerical values only)
# x <= value # returns elements of x that are less than or equal to the value (for numerical values only)
# x > value # returns elements of x that are greater than the value (for numerical values only)
# x < value # returns elements of x that are less than the value (for numerical values only)

# Conditions can be combined:
# & # means logical AND
# | # means logical OR
# () # define the priorities in aplication of the conditions
# Examples:
# subset(x, condition.1 & condition.2)
# subset(x, condition.1 | condition.2)
# subset(x, condition.1 & (condition.2 | condition.3))

# Subset can be applied to both vectors/factors and data frames:
#
# Examples:

test <- rep(c(1:4),3)
test
subset(test, test > 2)
subset(test, test >= 1 & test < 3)

dim(students.df)
summary(students.df)

students.f.df <- subset(students.df, students.df$SEX == "f")
dim(students.f.df)
summary(students.f.df)

students.f.le155.df <- subset(students.df, students.df$SEX == "f" & students.df$HEIGHT <= 155)
dim(students.f.le155.df)
summary(students.f.le155.df)

################################################################
# Working with lists of values

# Generalised form:
# unique(x) # returns list of unique elements present in x
# intersect(x, y) # returns list of elements common to x and y
# setdiff(x, y) # returns elements present in x but not in y

test.201802261402.01 <- c("a","a","b","b","c","c","d","d")
test.201802261402.02 <- c("c","d","e","f")

test.201802261402.01
test.201802261402.02

unique(test.201802261402.01)
intersect(test.201802261402.01, test.201802261402.02)
intersect(test.201802261402.02, test.201802261402.01)
setdiff(test.201802261402.01, test.201802261402.02)
setdiff(test.201802261402.02, test.201802261402.01)

################################################################
# The for(){} loop and its use for subsetting

# Generalised form:

# for(i in x){
# looped operations
# }

# All variables used for looped operations must be created outside of the loop
# x : a vector of numerical values used sequentially as values for i in the loop iterations
# looped operations : any operations that are required

# Examples:
# The following script subsets data for dirfferent regions of the pres.2008 into elements of regions.ls list object
# The following code brings exactly the same results as the code for the while(){} loop in the following subsection; compare them, please
# The key difference is the way in which i values are specified; both ways are rather flexible, though in some cases one could be more convenient than the other

# Obtaining a sorted list of region names
regions.list <- unique(pres.2008$REGION)
regions.list <- regions.list[order(regions.list)]

# Creating regions.ls list object to be used later within the loop
regions.ls <- NULL
regions.ls <- as.list(regions.ls)

for(i in 1:length(regions.list)){ # starting the loop
regions.ls[[i]] <- subset(pres.2008 <- pres.2008$REGION == regions.list[i]) # subsetting lines with pres.2008$REGION equivalent to regions.list[i]
}

# Previewing two regions with summary() to observe the results
summary(regions.ls[[1]])

summary(regions.ls[[50]])

################################################################
# The while(){} loop and its use for subsetting

# Generalised form:

# i <- start.value.i
# while(condition.i){
# looped operations
# i <- i + increment.i
# }

# All variables used for looped operations must be created outside of the loop
# condition.i : compares the counter variable (i) to some value which should be reached by increments
# looped operations : any operations that are required
# increment.i : some value (positive or negative) that is added to the counter (i) at the end of each cyclus

# Cycles can be nested

# Generalised form:

# i <- start.value.i
# j <- NULL
# while(condition.i){
# j <- start.value.j
#  while(condition.j){
#  looped operations
#  j <- j + increment.j
#  }
# i <- i + increment.i
# }

# Examples:
# The following script subsets data for dirfferent regions of the pres.2008 into elements of regions.ls list object
# The following code brings exactly the same results as the code for the for(){} loop in the preceding subsection; compare them, please
# The key difference is the way in which i values are specified; both ways are rather flexible, though in some cases one could be more convenient than the other

# Obtaining a sorted list of region names
regions.list <- unique(pres.2008$REGION)
regions.list <- regions.list[order(regions.list)]

# Creating regions.ls list object to be used later within the loop
regions.ls <- NULL
regions.ls <- as.list(regions.ls)

i <- 1 # assigning start value to the counter
while(i <= length(regions.list)){ # specifying condition

regions.ls[[i]] <- subset(pres.2008 <- pres.2008$REGION == regions.list[i]) # subsetting lines with pres.2008$REGION equivalent to regions.list[i]

i <- i + 1 # adding counter increment
}

# Previewing two regions with summary() to observe the results
summary(regions.ls[[1]])

summary(regions.ls[[50]])

################################################################
# Binding vectors together: cbind(), rbind(), 
# cbind.data.frame(), and rbind.data.frame()

# Generalised form:

# x12 <- cbind(x1, x2)
# x12 <- rbind(x1, x2)
# x12 <- cbind.data.frame(x1, x2)
# x12 <- rbind.data.frame(x1, x2)

# Note, please, that cbind(), which BINDs Columns together, 
# and rbind(), which BINDs Rows together, may corrupt data types 
# when used carelessly. They produce data frames at the output 
# only if one of the input objects is a data frame. When binding 
# vectors they end up with a matrix (converting everything to character 
# data type if the vectors are of different data types). 
#
# For data.frames, it is safer to use cbind.data.frame() and rbind.data.frame()



################################################################
# Transforming data types

# Generalised form:

# x.factor <- as.factor(x.chr)
# x.chr <- as.character(x.factor)
#
# x.num <- as.numeric(x.factor)
# x.factor <- as.factor(x.num)
#
# x.num <- as.numeric(x.chr) # If and only if x.chr contains numbers only
# x.chr <- as.character(x.numeric)

################################################################
# Managing factor levels: factor(), levels()

# Generalised form:

# x.factor <- as.factor(x.chr)
# x.factor <- factor(x.chr)
# levels(x.factor)
# x.factor.y <- factor(x.chr, levels=y)
#
# x.chr <- x.factor.y
# x.factor.z <- factor(x.chr, levels=z)

################################################################
# Merging two data frames into one: merge()

# Generalised form:

# x12 <- merge(x1, x2)

# Sometimes, you need to unite two data frames in which some columns 
# can be identified with each other while the others can not. 
# E. g., you managed to obtain variables A, B, and C for the dataset X1 
# and A, B, C, and D for the dataset X2. Even though it would not be 
# possible to consider interdependence of A and D in all the data available, 
# you can still do it for A, B, snd C on a combined dataset. Of course, 
# you can always play around with c(), rbind.data.frame(), data type 
# transformations and factor levels (if someting goes wrong), 
# but there is a quicker and safer way.
#
# merge() function can carefully join two data frames keeping all variables 
# or skipping the ones, which do not match.

# Creating experimental data frame 1:

X1 <- cbind.data.frame(
c(1),
sample(100, 10),
rnorm(10, 20, 4),
factor(c(rep("f", 5), rep("m", 5)), levels=c("f","m"))
)

# Assigning variable names:

colnames(X1) <- c("X", "A", "B", "C")

# Creating experimental data frame 2:

X2 <- cbind.data.frame(
c(2),
sample(100, 10),
rnorm(10, 20, 4),
sample(100, 10),
factor(c("f","m"), levels=c("f","m"))
)

# Assigning variable names:

colnames(X2) <- c("X", "A", "B", "D", "C")

# Merging two data frames:

X12 <- merge(X1, X2, all=TRUE)

# Read carefully help(merge), please. It is barely understandable but useful.

# Previewing the experimental data.frames and the result of merge()

X1
X2
X12
