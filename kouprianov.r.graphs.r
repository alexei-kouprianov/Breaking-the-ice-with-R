###############################################################################
###############################################################################
#
# Loading the files
#
###############################################################################
###############################################################################

# This is the code to re-create the students.df if it is lost;
# The file "kouprianov.students.v.2.1.txt" must be present
# in the working directory;
students.df <- read.table("kouprianov.students.v.2.1.txt", header=TRUE, sep="\t")

# The following two lines would help you checking if everything is OK;
dim(students.df)
head(students.df)

# Loading presidential election dataset
pres.2008 <- read.csv("pres.2008.en.csv", h=TRUE)

# Creating additional variables
pres.2008$TURNOUT <- (pres.2008$BALL.VALID + pres.2008$BALL.INVALID)/pres.2008$VOTERS
pres.2008$MEDVEDEV.sh <- pres.2008$MEDVEDEV/(pres.2008$BALL.VALID + pres.2008$BALL.INVALID)

# Loading philosophers dataset
phil <- read.table("philosophers.txt", h=TRUE, sep=" ")

# Some other datasets will be loaded later.

###############################################################################
###############################################################################
# The very first steps of analysis: descriptive statistics
###############################################################################
###############################################################################

# Calculating the sum of all individual heights;
sum(students.df$HEIGHT)
students.df$HEIGHT
help(sum)
sum(students.df$HEIGHT, na.rm=TRUE)

# Summary function
summary(students.df$HEIGHT)

# Structure of the summary's output
str(summary(students.df$HEIGHT))

# Calling individual elements of the summary's output
summary(students.df$HEIGHT)[2]
summary(students.df$HEIGHT)["1st Qu."]

# Retrieving some descriptive statistics from a numeric vector
# with more specialised functions;
mean(students.df$HEIGHT, na.rm=TRUE)
median(students.df$HEIGHT, na.rm=TRUE)
min(students.df$HEIGHT, na.rm=TRUE)
max(students.df$HEIGHT, na.rm=TRUE)
range(students.df$HEIGHT, na.rm=TRUE)

###############################################################################
# Traditional (mean-based) estimates of variation
###############################################################################

# Calculating variance manually and with var()
sum((students.df$HEIGHT-mean(students.df$HEIGHT, na.rm=TRUE))^2, na.rm=TRUE)/220
var(students.df$HEIGHT, na.rm=TRUE)

# Calculaing standard deviation and checking if it is square root of variance
sd(students.df$HEIGHT, na.rm=TRUE)
(sd(students.df$HEIGHT, na.rm=TRUE))^2

###############################################################################
# Robust estimates of variation
###############################################################################
IQR(students.df$HEIGHT, na.rm=TRUE)
help(quantile())

###############################################################################
# Summarising a qualitative variable
###############################################################################
summary(students.df$SEX)
summary(as.character(students.df\$SEX))

###############################################################################
# Summarising a data frame
###############################################################################
summary(students.df)

###############################################################################
###############################################################################
# Analysts' nightmare: Anscombe's quartet
###############################################################################
###############################################################################

# Loading and previewing data:
anscombe <- read.table("anscombe.txt", head=TRUE, sep="\t")
dim(anscombe)
anscombe

# Applying mean() and sd() to all columns and rounding the results
# to two decimal places:
round(apply(anscombe, 2, mean), 2)
round(apply(anscombe, 2, sd), 2)

# Plotting the four datasets
plot(anscombe$x.1, anscombe$y.1, xlim=c(0,20), ylim=c(0,20))
abline(lm(anscombe$y.1 ~ anscombe$x.1), lty=2, col="red")
plot(anscombe$x.2, anscombe$y.2, xlim=c(0,20), ylim=c(0,20))
abline(lm(anscombe$y.2 ~ anscombe$x.2), lty=2, col="red")
plot(anscombe$x.3, anscombe$y.3, xlim=c(0,20), ylim=c(0,20))
abline(lm(anscombe$y.3 ~ anscombe$x.3), lty=2, col="red")
plot(anscombe$x.4, anscombe$y.4, xlim=c(0,20), ylim=c(0,20))
abline(lm(anscombe$y.4 ~ anscombe$x.4), lty=2, col="red")

# Regression summaries (just to take a look at them)
summary(lm(anscombe$y.1 ~ anscombe$x.1))
summary(lm(anscombe$y.2 ~ anscombe$x.2))
summary(lm(anscombe$y.3 ~ anscombe$x.3))
summary(lm(anscombe$y.4 ~ anscombe$x.4))

###############################################################################
###############################################################################
###############################################################################
#
# Grammar of graphics: six most basic graphs
#
###############################################################################
###############################################################################
###############################################################################

###############################################################################
###############################################################################
# Visualising a single variable
###############################################################################
###############################################################################

###############################################################################
# Histogram
###############################################################################

# Generating a random sequence of 50 weights
# with mean 57000 and standard deviation 7200;
mass.rn <- rnorm(50, 57000, 7200)

# Rounding the mass.rn to the gram;
mass.rnr <- round(mass.rn)

# Drawing a graph resembling fig. 3
hist(mass.rnr, breaks=c((min(mass.rnr, na.rm=T)-.5):(max(mass.rnr, na.rm=T)+.5)))

# Gradually improving histogram for students
hist(students.df$HEIGHT)
hist(students.df$HEIGHT, main="Undergraduate students", xlab="Height, cm")
hist(students.df$HEIGHT, main="Undergraduate students", xlab="Height, cm", col="grey")
hist(students.df$HEIGHT, main="Undergraduate students", xlab="Height, cm", density=15, angle=45)
hist(students.df$HEIGHT, main="Undergraduate students", xlab="Height, cm", col="grey", breaks=20)
hist(students.df$HEIGHT, main="Undergraduate students", xlab="Height, cm", col="grey", breaks=seq(min(students.df$HEIGHT, na.rm=TRUE), max(students.df$HEIGHT, na.rm=TRUE), 4))

hist(pres.2008$TURNOUT, breaks=seq(-.0005, 1.0005, .001), col="black", main="", xlab="Voters' turnout at a polling station, 0.1% bin")
hist(pres.2008$TURNOUT, breaks=seq(-.0005, 1.0005, .001), ylim=c(0,400), col="black", main="", xlab="Voters' turnout at a polling station, 0.1% bin")

###############################################################################
# Digression: saving the graphs
###############################################################################
png("hist.students.df.height.png") # 1. Opening a graphic device;
hist(students.df$HEIGHT) # 2. Plotting a graph;
dev.off() # 3. Closing the device;

png("hist.students.df.height.png", height=500, width=500)
hist(students.df$HEIGHT,
main="Undergraduate students", xlab="Height, cm",
breaks=20,
density=15, angle=45)
dev.off()

###############################################################################
# Simple bar plots
###############################################################################

# Generic function plot() draws barplot from the raw data
plot(students.df$SEX)

# table() applied to qualitative variables
table(students.df$SEX)
table(students.df$SMOKING)

# table() used as an argument for a specialised barplot() function
barplot(table(students.df$SEX))
barplot(table(students.df$SMOKING))

# Gradually improving philosophers' barplot
barplot(phil$Freq)
barplot(phil$Freq, names.arg=phil$NAMES, ylab="Mentions")
barplot(phil$Freq, names.arg=phil$NAMES, horiz=TRUE, xlab="Mentions")
barplot(phil$Freq, names.arg=phil$NAMES, horiz=TRUE, las=1, xlab="Mentions")

# Identifying string width in inches
max(strwidth(phil$NAMES, units="inches"))

# The printing device parameters: par() function
par()$mar
par()$mai

# Using strwidth() to expand the left margin
par(mai = c(0.82, 0.42 + max(strwidth(phil$NAMES, units="inches")), 0.42, 0.42))
barplot(phil$Freq, names.arg=phil$NAMES, horiz=TRUE, las=1, xlab="Mentions")

# Sorting philosophers by Freq[uency]
phil.s <- phil[order(-phil$Freq),]

# Plotting the sorted philosophers
par(mai = c(0.82, 0.42 + max(strwidth(phil.s$NAMES, units="inches")), 0.42, 0.42))
barplot(phil.s$Freq, names.arg=phil.s$NAMES, horiz=TRUE, las=1, xlab="Mentions")

###############################################################################
###############################################################################
# Visualising interdependence: bivariate plots
###############################################################################
###############################################################################

###############################################################################
# Scatter plot
###############################################################################

# Gradually omproving scatter plot
plot(students.df$HEIGHT, students.df$MASS)
plot(students.df$HEIGHT, students.df$MASS, pch=20, xlab="Stature, cm", ylab="Body mass, kg")
plot(students.df$HEIGHT, students.df$MASS, pch=20, col=rgb(0,0,0,.3), xlab="Stature, cm", ylab="Body mass, kg")
plot(students.df$HEIGHT, students.df$MASS, pch=20, col=as.numeric(students.df$SEX), xlab="Stature, cm", ylab="Body mass, kg")

# Subsetting students by gender
students.f.df <- subset(students.df, students.df$SEX=="f")
students.m.df <- subset(students.df, students.df$SEX=="m")

# Superimposing two groups of students on the same graph
plot(students.df$HEIGHT, students.df$MASS, type="n", xlab="Stature, cm", ylab="Body mass, kg")
points(students.f.df$HEIGHT, students.f.df$MASS, pch=20, col=rgb(1,0,0,.4))
points(students.m.df$HEIGHT, students.m.df$MASS, pch=20, col=rgb(0,0,1,.4))

plot(students.df$HEIGHT, students.df$MASS, type="n", xlab="Stature, cm", ylab="Body mass, kg")
points(students.f.df$HEIGHT, students.f.df$MASS, pch=3)
points(students.m.df$HEIGHT, students.m.df$MASS, pch=4)

###############################################################################
# A special case: Time series
###############################################################################

###############################################################################
# Nine values for "type" argument of the plot() function

# Setting the objects;
plot.types = c("n", "p","l","o","b","c","s","S","h")
x.coord <- c(1:7)
y.coord <- c(1, 3, 7, 4, 2, 3, 5)

# Setting parameters for the plotting device;
par(mfrow=c(3, 3), pch=20)

# Using for(){} loop to print all plots in a single chart;
for (i in 1:9){
plot(x.coord, y.coord, xlim=c(0, 8), ylim=c(0, 8),
type=plot.types[i],
main=paste("Plot type =", plot.types[i]))
}

# Please, do not forget to close the plotting device after this exercise with
# dev.off()
# or reset it to the default
# par(mfrow=c(1, 1), pch=1)

###############################################################################
# Testing "type" argument with points() and lines()

# Setting parameters for the plotting device;
par(mfrow=c(2, 2), pch=20)

plot(x.coord, y.coord, xlim=c(0, 8), ylim=c(0, 8), type="n", main='Points default')
points(x.coord, y.coord)

plot(x.coord, y.coord, xlim=c(0, 8), ylim=c(0, 8), type="n", main='Points type="l"')
points(x.coord, y.coord, type="l")

plot(x.coord, y.coord, xlim=c(0, 8), ylim=c(0, 8), type="n", main='Lines default')
lines(x.coord, y.coord)

plot(x.coord, y.coord, xlim=c(0, 8), ylim=c(0, 8), type="n", main='Lines type="p"')
lines(x.coord, y.coord, type="p")

# Please, do not forget to close the plotting device after this exercise with
# dev.off()
# or reset it to the default
# par(mfrow=c(1, 1), pch=1)

###############################################################################
# On the importance of ordering the entries chronologically

# Putting together example objects;
x.coord.1 <- c(1, 3, 5, 6, 2, 7, 4)
y.coord.1 <- c(1, 7, 2, 3, 3, 5, 4)

# Setting parameters for the plotting device;
par(mfrow=c(2, 2), pch=20)
plot(x.coord, y.coord, xlim=c(0, 8), ylim=c(0, 8))
plot(x.coord.1, y.coord.1, xlim=c(0, 8), ylim=c(0, 8))
plot(x.coord, y.coord, xlim=c(0, 8), ylim=c(0, 8), type="o")
plot(x.coord.1, y.coord.1, xlim=c(0, 8), ylim=c(0, 8), type="o")

# Please, do not forget to close the plotting device after this exercise with
# dev.off()
# or reset it to the default
# par(mfrow=c(1, 1), pch=1)

###############################################################################
# X coordinate vs. index

# Putting together an example object;
x.coord.2 <- c(1, 3:8)
plot(y.coord, xlim=c(0, 8), ylim=c(0, 8), type="o")
plot(x.coord.2, y.coord, xlim=c(0, 8), ylim=c(0, 8), type="o")

###############################################################################
# A real-life time series example

# Loading the data for Imperial Moscow University students;
moscow <- read.table("Moscow.students.txt", h=TRUE, sep="\t")

# Plotting the time series for the faculty of Law;
plot(as.Date(moscow$DATE), moscow$L, type="l", lty=1,
ylim=c(0, max(moscow[,(2:4)])),
main="", xlab="Timeline", ylab="Number of students")

# Adding time series for the other three faculties;
points(as.Date(moscow$DATE), moscow$HP, type="l", lty=2)
points(as.Date(moscow$DATE), moscow$PM, type="l", lty=3)
points(as.Date(moscow$DATE), moscow$M, type="l", lty=4)

###############################################################################
# Multiple boxplot
###############################################################################

# Creating boxplots with plot()
plot(students.df$SEX, students.df$HEIGHT)

# Creating boxplots with plot(), mind the as.factor() data transformation with
# numerical codes used as entity names (e.g. for a group of sudents, its
# number is a name);

plot(as.factor(students.df$GROUP), students.df$HEIGHT)

# Creating boxplots with boxplot()

# Attempt #1
boxplot(students.df$SEX, students.df$HEIGHT)

# Attempt #2
boxplot(students.df$HEIGHT ~ students.df$SEX)

# Combining different objects in the same boxplot
boxplot(students.f.df$HEIGHT, students.m.df$HEIGHT, axes=FALSE)
axis(1, at=c(1,2), labels=c("f","m"), col="white")
axis(2)

###############################################################################
# Scatter plot with jitter
###############################################################################

# Raw plot HEIGHT ~ SEX
plot(students.df$HEIGHT, students.df$SEX)

# Using jitter()

# Attempt #1
plot(students.df$HEIGHT, jitter(students.df$SEX))

# Attempt #2
plot(students.df$HEIGHT, jitter(as.numeric(students.df$SEX)))

# Controlling the axes and text labels
plot(students.df$HEIGHT, jitter(as.numeric(students.df$SEX), factor=.5),
xlab="Height, cm", ylab="Gender", pch=20, col=rgb(0,0,0,.3), axes=FALSE)
axis(1)
axis(2, at=c(1:2), labels=c("f","m"), las=1, col="white")

###############################################################################
# Structured barplots
###############################################################################

# Exploring relationship between gender and smoking with plot()
plot(students.df$SEX, as.factor(students.df$SMOKING))
table(students.df$SEX, students.df$SMOKING)
table(students.df$SEX)
table(students.df$SMOKING, students.df$SEX)

# Exploring relationship between gender and department with barplot()
table(students.df$SEX, students.df$DEPARTMENT)
barplot(table(students.df$SEX, students.df$DEPARTMENT))
barplot(table(students.df$SEX, students.df$DEPARTMENT), beside=TRUE)

# Experimenting with a data frame as a source for barplot()

# Create the data frame
test.df <- data.frame(c(10,12,8), c(16,6,4), c(5,7,9))
colnames(test.df) <- c("A","B","C")

# Preview the data
test.df

# Experimenting
barplot(test.df)
barplot(as.matrix(test.df))
barplot(as.matrix(test.df), beside=TRUE)

###############################################################################
###############################################################################
# Drawing math: abline() and curve()
###############################################################################
###############################################################################

# Creating an empty plot;
plot(-10:10, -10:10, type="n")

# Drawing a number of lines;
abline(0, 1, lty=1) # y=0+1*x;
abline(6, -.5, lty=2) # y=8-0.5*x;
abline(-7, 2, lty=3) # y=-7+2*x;
abline(4, sqrt(2), lty=4) # y=4+sqrt(2)*x;

# Re-creating an empty plot;
plot(-10:10, -10:10, type="n")

# Adding the grid;
abline(h=seq(-10,10,1), v=c(-10:10), lty=3, col=8)

# Adding the axes;
abline(h=0, v=0)

# Adding back the lines;
abline(0, 1, lty=1) # y=0+1*x;
abline(6, -.5, lty=2) # y=8-0.5*x;
abline(-7, 2, lty=3) # y=-7+2*x;
abline(4, sqrt(2), lty=4) # y=4+sqrt(2)*x;

# Plotting the data points;
plot(students.df$HEIGHT, students.df$MASS,
pch=20, col=rgb(0,0,0,.3),
xlab="Stature, cm", ylab="Body mass, kg")

# Adding regression line;
abline(lm(students.df$MASS ~ students.df$HEIGHT), col=red, lwd=3)

# Previewing coefficients
lm(students.df$MASS ~ students.df$HEIGHT)$coefficients

# Adding regression line in a different way;
abline(-85.2, .852, col="blue", lty=2, lwd=3)

# Trying the y=x^2 curve for different values for 'n';
curve(x^2, from=-2, to=2, n=1)
curve(x^2, from=-2, to=2, n=2)
curve(x^2, from=-2, to=2, n=3)
curve(x^2, from=-2, to=2, n=10)

# Trying the curve: 2;
curve(x^3, from=-2, to=2, xlim=c(-3, 3), ylim=c(-3, 3))
curve(x^2, add=TRUE, lty=2)
curve(1*x, add=TRUE, lty=3)
abline(h=0, v=0)

# Trying the curve: 3;
curve(sin(x), from=-2*pi, to=2*pi, ylim=c(-2, 2)*pi)
curve(exp(x), lty=2, add=TRUE)
curve(log(x), lty=3, add=TRUE, n=303)
abline(h=0, v=0)

###############################################################################
###############################################################################
# Many layers of dots
###############################################################################
###############################################################################

png("pres2008_2dh01.png", height=3000, width=3000)
par(cex=6, lwd=6, mar=c(4,4,2,0), mgp=c(2.5,1,0))

plot(pres.2008$TURNOUT, pres.2008$MEDVEDEV.sh, pch=".",
xlim=c(0,1.01), ylim=c(0,1.01),
col=rgb(0,0,0,.3),
axes=FALSE,
xlab="Voters' turnout", ylab="Medvedev's share",
main="Presidential elections in Russia, 2008")
axis(1, lwd=6)
axis(2, lwd=6)

dev.off()

###############################################################################
###############################################################################
# Visualising everything: graphical primitives
###############################################################################
###############################################################################

# A list of functions (not to be executed):
# abline()
# points()
# lines()
# segments()
# arrows()
# polygon()
# rect()
# text()

# Drawing line segments
plot(1, 1, type="n", xlim=c(0, 10), ylim=c(0, 10)) # creating an empty plot
segments(x0=c(1, 2, 4, 2), y0=c(1, 2, 1, 6), x1=c(2, 3, 6, 8), y1=c(5, 4, 8, 7))

# Drawing arrows
plot(1, 1, type="n", xlim=c(0, 10), ylim=c(0,10)) # re-creating an empty plot
arrows(x0=c(1, 2, 4, 2), y0=c(1, 2, 1, 6), x1=c(2, 3, 6, 8), y1=c(5, 4, 8, 7))
arrows(x0=1, y0=8, x1=8, y1=9, length=.15, angle=15, code=1)
arrows(x0=6, y0=4, x1=10, y1=2, length=.2, angle=10, code=3)

# Drawing rectangles
plot(1, 1, type="n", xlim=c(0, 10), ylim=c(0, 10)) # re-creating an empty plot
rect(xleft=c(1, 2, 6), ybottom=c(1, 3, 0), xright=c(3, 8, 10), ytop=c(4, 8, 1))

# Drawing polygons
plot(1, 1, type="n", xlim=c(0, 10), ylim=c(0, 10)) # re-creating an empty plot
p.1.x <- c(2, 1, 1, 3, 5, 4)
p.1.y <- c(0, 1, 3, 5, 2, 1)
polygon(p.1.x, p.1.y) # Adding polygon 1
p.2.x <- c(1, 2, 3, 4, NA, 7, 5, 9, 8)
p.2.y <- c(6, 8, 9, 5, NA, 5, 5, 8, 9)
polygon(p.2.x, p.2.y, density=c(12, 24)) # Adding two polygons

# Two ways of dealing with intersections

# Default way (fillOddEven=FALSE)
p.3.x <- c(6, 7, 8, 5.5, 8.5)
p.3.y <- c(0, 3.2, 0, 2, 2)
polygon(p.3.x, p.3.y, density=12, angle=-45)

# fillOddEven=TRUE
p.4.x <- c(7.5, 8.5, 9.5, 7, 10)
p.4.y <- c(2.5, 5.7, 2.5, 4.5, 4.5)
polygon(p.4.x, p.4.y, density=12, angle=-45, fillOddEven=TRUE)

###############################################################################
# Examples of real-life graphs using polygon() function
###############################################################################

###############################################################################
# Dorpat faculty dynamics

# Loading dataset;
dpt.dyn <- read.table("dpt.dyn.txt", h=TRUE, sep="\t")

# An empty plot
plot(dpt.dyn$YEAR, dpt.dyn$TOT, type="n", ylim=c(0,85),
xlab="Timeline", ylab="Number of persons")

# Adding polygons;
polygon(x=c(dpt.dyn$YEAR[1], dpt.dyn$YEAR, dpt.dyn$YEAR[nrow(dpt.dyn)]), y=c(0, dpt.dyn$TOT, 0), col="#0072CE")
polygon(x=c(dpt.dyn$YEAR[1], dpt.dyn$YEAR, dpt.dyn$YEAR[nrow(dpt.dyn)]), y=c(0, (dpt.dyn$U1.DPT.TOT + dpt.dyn$U1.EUR.TOT), 0), col="black")
polygon(x=c(dpt.dyn$YEAR[1], dpt.dyn$YEAR, dpt.dyn$YEAR[nrow(dpt.dyn)]), y=c(0, dpt.dyn$U1.EUR.TOT, 0), col="white")

###############################################################################
# Presidential elections Monte-Carlo simulation results

# Loading datasets;
ru.2018 <- read.table("ru.2018.txt", h=TRUE, sep="\t")
ru.hist.MC <- read.table("ru.hist.MC.txt", h=TRUE, sep=" ")

# Plotting the histogram;
hist(ru.2018$TURNOUT, breaks=seq(-.0005, 1.0005, .001),
ylim=c(0, 500), col=rgb(0, 0, 1, .3), border=rgb(0, 0, 1, .3),
main="Presidential elections in Russia, 2018-03-18",
xlab="Voters' turnout at a polling station, 0.1% bin",
ylab="Frequency")

# Adding the polygon for the MC simulation mean +/- 3 standard deviations;
polygon(
c(ru.hist.MC$PCT, ru.hist.MC$PCT[1001:1]),
c(ru.hist.MC$MEAN + 3 * ru.hist.MC$SD,
(ru.hist.MC$MEAN - 3 * ru.hist.MC$SD)[1001:1]),
col=rgb(0, 0, 0, .3), border=rgb(1, 0, 0, .3), lwd=.5)

# Adding the mean of the MC simulation;
lines(ru.hist.MC$PCT, ru.hist.MC$MEAN, col=2)

# See the end of file for:
# Bonus: Monte-Carlo simulation for St. Petersburg voters' turnout histogram

###############################################################################
###############################################################################
# Getting inside: numeric output of the plotting functions
###############################################################################
###############################################################################

# This line creates both a histogram plot and an object:
students.mass.hist <- hist(students.df$MASS)

# Preview object structure:
str(students.mass.hist)

# Visualise the object with plot()
plot(students.mass.hist, main="Undergraduate students", xlab="Body mass, kg", col="grey")
text(x=students.mass.hist$mids, y=students.mass.hist$counts, labels=students.mass.hist$counts, pos=3)

# Adjusting ylim
plot(students.mass.hist, ylim=c(0,max(students.mass.hist$counts)+5), main="Undergraduate students", xlab="Body mass, kg", col="grey")
text(x=students.mass.hist$mids, y=students.mass.hist$counts, labels=students.mass.hist$counts, pos=3)

# This line creates both a boxplot and an object:
students.mass.box <- boxplot(students.df$MASS)

# Preview object structure:
str(students.mass.box)

# Another, slightly more complex, object:
students.mass.2.box <- boxplot(students.df$MASS ~ students.df$SEX)

# Preview object structure:
str(students.mass.2.box)

# Comparing stats elements:
students.mass.box$stats
students.mass.2.box$stats

# Trying boxplot.stats():
boxplot.stats(students.df$MASS)

###############################################################################
###############################################################################
##
## Bonus: Monte-Carlo simulation for St. Petersburg voters' turnout histogram
##
###############################################################################
###############################################################################

###############################################################################
#
# The following script is based on the methods described in
# Dmitry Kobak, Sergey Shpilkin, and Maxim S. Pshenichnikov "Integer
# percentages as electoral falsification fingerprints". The Annals of Applied
# Statistics. Volume 10, Number 1 (2016), 54-73.
# [https://arxiv.org/abs/1410.6059]
#
# I am indebted to Sergey Shpilkin for his kind explanations and critical
# remarks on the early versions of the script.
# I am grateful to Boris Ovchinnikov for a stimulating discussion.
#
# Alexei Kouprianov, alexei.kouprianov@gmail.com
#
###############################################################################

###############################################################################
# Loading data
###############################################################################
spb.2018 <- read.table("spb.q.20180319.txt", h=TRUE, sep="\t")
spb.2018$VOTED <- spb.2018$BALL.INVALID + spb.2018$BALL.VALID
spb.2018$TURNOUT <- spb.2018$VOTED/spb.2018$VOTERS

###############################################################################
# Declaring objects for the loop
###############################################################################
# MK.repeats <- 100 # For preliminary testing;
# MK.repeats <- 1000 # For preliminary testing;
# DO NOT try the following line on larger datasets. 10,000 iterations on
# the dataset for the whole Russia (97+K records) and for 0.1% bins
# may take days to complete.

MK.repeats <- 1000 # Working repeats number;

spb.ksp.rbinom.ls <- NULL # ls of simulated polling stations;
spb.ksp.rbinom.ls <- as.list(spb.ksp.rbinom.ls)
spb.ksp.rbinom.TURNOUT <- NULL # complete vector of simulated turnouts;

# df for simulated histograms' counts:

spb.ksp.rbinom.TURNOUT.hist.counts.df <- NULL
spb.ksp.rbinom.TURNOUT.hist.counts.df <- as.data.frame(spb.ksp.rbinom.TURNOUT.hist.counts.df)

j <- NULL
i <- NULL

###############################################################################
# Main simulation loop begins
###############################################################################

for (k in 1:MK.repeats) {
spb.ksp.rbinom.ls <- NULL # ls of simulated polling stations;
spb.ksp.rbinom.ls <- as.list(spb.ksp.rbinom.ls)
spb.ksp.rbinom.TURNOUT <- NULL # complete vector of simulated turnouts;

# Simulating polling stations' turnouts
j <- 1
while(j <= length(spb.2018$VOTERS)){
spb.ksp.rbinom.ls[[j]] <- rbinom(n=1, size=spb.2018$VOTERS[j], prob=spb.2018$TURNOUT[j])
j <- j + 1
}

# Gathering simulated turnouts in a vector

i <- 1
while(i <= length(spb.2018$VOTERS)){
spb.ksp.rbinom.TURNOUT <- c(spb.ksp.rbinom.TURNOUT, spb.ksp.rbinom.ls[[i]]/spb.2018$VOTERS[i])
i <- i + 1
}

# Calculating hist for simulated turnouts, bin 1% (hist plots appear
# in the graphics console)

spb.ksp.rbinom.TURNOUT.hist <- hist(spb.ksp.rbinom.TURNOUT, breaks=seq(-.005, 1.005, .01))

# Extracting simulated hist counts

spb.ksp.rbinom.TURNOUT.hist.counts.df <- rbind.data.frame(
spb.ksp.rbinom.TURNOUT.hist.counts.df,
spb.ksp.rbinom.TURNOUT.hist$counts
)
}

###############################################################################
# Main simulation loop ends
###############################################################################

# Extracting summary stats for counts from all MK.repeats simulated hists into
# a data frame

spb.ksp.rbinom.TURNOUT.hist.counts.MEAN <- NULL
spb.ksp.rbinom.TURNOUT.hist.counts.SD <- NULL
spb.ksp.rbinom.TURNOUT.hist.counts.MEDIAN <- NULL
spb.ksp.rbinom.TURNOUT.hist.counts.Q1 <- NULL
spb.ksp.rbinom.TURNOUT.hist.counts.Q3 <- NULL
spb.ksp.rbinom.TURNOUT.hist.counts.IQR <- NULL

for (i in 1:101){
spb.ksp.rbinom.TURNOUT.hist.counts.MEAN <- c(
spb.ksp.rbinom.TURNOUT.hist.counts.MEAN,
mean(spb.ksp.rbinom.TURNOUT.hist.counts.df[,i])
)

spb.ksp.rbinom.TURNOUT.hist.counts.SD <- c(
spb.ksp.rbinom.TURNOUT.hist.counts.SD,
sd(spb.ksp.rbinom.TURNOUT.hist.counts.df[,i])
)

spb.ksp.rbinom.TURNOUT.hist.counts.MEDIAN <- c(
spb.ksp.rbinom.TURNOUT.hist.counts.MEDIAN,
median(spb.ksp.rbinom.TURNOUT.hist.counts.df[,i])
)

spb.ksp.rbinom.TURNOUT.hist.counts.Q1 <- c(
spb.ksp.rbinom.TURNOUT.hist.counts.Q1,
summary(spb.ksp.rbinom.TURNOUT.hist.counts.df[,i])[2]
)

spb.ksp.rbinom.TURNOUT.hist.counts.Q3 <- c(
spb.ksp.rbinom.TURNOUT.hist.counts.Q3,
summary(spb.ksp.rbinom.TURNOUT.hist.counts.df[,i])[5]
)

spb.ksp.rbinom.TURNOUT.hist.counts.IQR <- c(
spb.ksp.rbinom.TURNOUT.hist.counts.IQR,
IQR(spb.ksp.rbinom.TURNOUT.hist.counts.df[,i]))
}

spb.hist.ksp.simulated.stats.1pct <- data.frame(
seq(0, 1, .01),
spb.ksp.rbinom.TURNOUT.hist.counts.MEAN,
spb.ksp.rbinom.TURNOUT.hist.counts.SD,
spb.ksp.rbinom.TURNOUT.hist.counts.MEDIAN,
spb.ksp.rbinom.TURNOUT.hist.counts.Q1,
spb.ksp.rbinom.TURNOUT.hist.counts.Q3,
spb.ksp.rbinom.TURNOUT.hist.counts.IQR
)

colnames(spb.hist.ksp.simulated.stats.1pct) <-
c("PCT","MEAN","SD","MEDIAN","Q1","Q3","IQR")

# Control plots

png("hist.TURNOUT.spb.MEDIAN-IQR.simul.png", height=750, width=750)
par(cex=1.5, lwd=1.5)

hist(spb.2018$TURNOUT, breaks=seq(-.005, 1.005, .01),
ylim=c(0,190), col=rgb(0,0,1,.3), border=rgb(0,0,1,.3),
main="Presidential elections in Russia, 2018-03-18\nSt. Petersburg",
xlab="Voters' turnout, 1% bin",
ylab="Frequency")

polygon(c(spb.hist.ksp.simulated.stats.1pct$PCT,
spb.hist.ksp.simulated.stats.1pct$PCT[101:1]),
c(spb.hist.ksp.simulated.stats.1pct$MEDIAN +
1.5*spb.hist.ksp.simulated.stats.1pct$IQR,
(spb.hist.ksp.simulated.stats.1pct$MEDIAN -
1.5*spb.hist.ksp.simulated.stats.1pct$IQR)[101:1]),
col=rgb(0,0,0,.3), border=rgb(1,0,0,.3))

points(spb.hist.ksp.simulated.stats.1pct$PCT,
spb.hist.ksp.simulated.stats.1pct$MEDIAN, type="l", col=2, lwd=3)

legend("topleft", lwd=c(3,1), col=c(2,2),
legend=c("MC-simulated median", "MC-simulated median +/- 1.5 IQR"), bty="n")

axis(1, at=seq(0,1,.1), labels=FALSE, lwd=1.5)
axis(2, at=seq(0,190,10), tcl=-.25, labels=FALSE, lwd=1.5)

dev.off()

png("hist.TURNOUT.spb.MEAN-SD.simul.png", height=750, width=750)
par(cex=1.5, lwd=1.5)

hist(spb.2018$TURNOUT, breaks=seq(-.005, 1.005, .01),
ylim=c(0,190), col=rgb(0,0,1,.3), border=rgb(0,0,1,.3),
main="Presidential elections in Russia, 2018-03-18\nSt. Petersburg",
xlab="Voters' turnout, 1% bin",
ylab="Frequency")

polygon(c(spb.hist.ksp.simulated.stats.1pct$PCT,
spb.hist.ksp.simulated.stats.1pct$PCT[101:1]),
c(spb.hist.ksp.simulated.stats.1pct$MEAN +
3*spb.hist.ksp.simulated.stats.1pct$SD,
(spb.hist.ksp.simulated.stats.1pct$MEAN -
3*spb.hist.ksp.simulated.stats.1pct$SD)[101:1]),
col=rgb(0,0,0,.3), border=rgb(1,0,0,.3))

points(spb.hist.ksp.simulated.stats.1pct$PCT,
spb.hist.ksp.simulated.stats.1pct$MEAN, type="l", col=2, lwd=3)

legend("topleft", lwd=c(3,1), col=c(2,2),
legend=c("MC-simulated mean", "MC-simulated mean +/- 3 SD"), bty="n")

axis(1, at=seq(0,1,.1), labels=FALSE, lwd=1.5)
axis(2, at=seq(0,190,10), tcl=-.25, labels=FALSE, lwd=1.5)

dev.off()

### End of script ###