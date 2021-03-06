#install 'Gapminder' package from Github 
#contains the life expectancy, GDP per capita, 
#and population by country, every five years, from 1952 to 2007
library(devtools)
install_github("jennybc/gapminder")
library(gapminder)
?gapminder# find more about the dataframe
data(gapminder) # loads data
head(gapminder)# returns first few lines of the data
#Create a vector 'x' of the life expectancies of each 
#country for the year 1952. Plot a histogram of these 
#life expectancies to see the spread of the different countries.
View(gapminder) #see the table
x<- gapminder[gapminder$year<1953,c(1,4)] # created a vector 'x' extracted the column
#year with values less than 1953 for all rows (as I require only 1952) and combined 
#columns 1 (country) and 4 (lifeexpectancy)
x # see the extracted data
plot(x) # plot
s <- split(x$lifeExp, x$country) # split life exp and country from x
a<-c(x$lifeExp) # another vector a as lifeexp   
names(a) <- c(x$country)# and names to a as countries
barplot(a, las=1, space=0) # plotted a barplot
hist(a)# hist of 
install.packages("ggplot2")
library(ggplot2)      
bp<-ggplot(x, aes(x=country, y=lifeExp)) + geom_bar(stat="identity", width=0.5)
bp + theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5)) # just 
#playing around with ggplot2 ;)
mean(x$lifeExp<=40)#What is the proportion of countries in 1952 that have a life expectancy less than or equal to 40?
#[1] 0.2887324
#dat1952 = gapminder[ gapminder$year == 1952, ]
#x = dat1952$lifeExp
#mean(x <= 40)
mean(x$lifeExp<=60) - mean(x$lifeExp<=40)#What is the proportion of countries in 1952 
#that have a life expectancy between 40 and 60 years? Hint: this is the 
#proportion that have a life expectancy less than or equal to 60 years,
#minus the proportion that have a life expectancy less than or equal to 40 years.
#[1] 0.4647887
#dat1952 = gapminder[ gapminder$year == 1952, ]
#x = dat1952$lifeExp
#mean(x <= 60) - mean(x <= 40)
x <- dat1952$lifeExp
mean(x <= 40)
prop <- function(q){# saying whenever I type prop (for proportion) identify that as 'function' and
  #(q)  read it as (any number) where q can be any integer 
  mean(x<=q)#this defines what formula to be applied in relation to q.
} #curly brackets will apply the code to all (multiple) rows in the data 'x'.
# plotting the "mean(x$lifeExp<=40)" or "mean(x <= 40)" code using a custom function where 'q' is 
# the input variable (in this case lifeExp of all countries in the year 1952 
#as x = dat1952$lifeExp) and the proportion of countries in 'x' dataset that are < or = to 'q'. 
#What the proportion here means is that 
#if you count the number of times x<=40 (no of countries < or = 40 years lifeExp in 1952) 
#and give a vector 'y'
# y<- x<=40 to it then 'sum(y, na.rm=TRUE)'counting the TRUE will give you the no of countries ie '41'
# and proportion is then dividing 41/142 = 0.2887323943661972 same as "mean(x <= 40)" or "prop(40)".
prop(40) # custom function
qs <- seq(from=min(x), to =max(x), length=20)#generates 20 random values from lowest and highest
#from vector 'x'
props <- sapply(qs, prop)#lapply - When you want to apply a 
#function to each element of a list in turn and get a list back.sapply - When you want to apply 
#a function to each element of a list in turn, but you want a vector back, rather than a list.try
#> test <-list(a=1, b=1:3, c=10:20), > lapply(test, sum) and > sapply(test, sum) to see what they do.
plot(qs, props) # plot
props <- sapply(qs, function(q)mean(x<=q))#performing in one line what we did in line 44 with {}
props# same output - it has come back with proportions of countries in 1952 below life expectancies of
# 28.80100 (7.04%), 31.10989(28.16%)....etc upto the 20th number 1.000 (100%).this is called
#an inline function or anonymous function in R, but this is still a homemade function and R has a 
#prebuilt one as below
plot(ecdf(x))
list(ecdf(x))
#next video
#http://en.wikipedia.org/wiki/File:Empirical_Rule.PNG, 
#http://en.wikipedia.org/wiki/68%E2%80%9395%E2%80%9399.7_rule
p <- dat1952$pop #Create a vector which gives the population sizes of the countries in 1952
hist(p, breaks=100)#Examine the histogram of these population sizes
#(it might help to increase the number of 'breaks')
plog <- log10(p)# made another vector plog for log10 of population sizes
hist (plog, breaks=100)# plot histogram of these values
sd(plog)#standard deviation of the log10 of the sample size of the countries in 1952? 0.7070292
sqrt(mean((plog - mean(plog))^2))# of the population 
#http://www.usablestats.com/lessons/pop 
#Answer: 
dat1952 = gapminder[ gapminder$year == 1952, ]
pop = dat1952$pop
logpop = log10(pop)
# the sample standard deviation
sd(logpop)
# the population standard deviation
sqrt(mean((logpop - mean(logpop))^2)) 
#http://en.wikipedia.org/wiki/Standard_deviation#With_sample_standard_deviation
x<- log10(pop) # create a vector x of the log10 of the 1952 population sizes
qqnorm(x)#https://intellinexus.wordpress.com/2010/11/29/creating-a-q-q-plot/
#http://onlinestatbook.com/2/advanced_graphs/q-q_plots.html
#http://commons.wikimedia.org/wiki/File:Normal_distribution_and_scales.gif
abline(0,1)# plots y=x line
meanx<- mean(x)
sdx<-sd(x)
z<- (x-meanx)/sdx # z is 
qqnorm(z)
abline(0,1)
max(z)# zscore is x-mean/sd same as what we did in line 98. max z score here is 3.03 means +3.03 
# standard deviations above mean
F<-function(q) pnorm(q, mean=mean(x), sd=sd(x)) #normal distribution cumulative density funcition
#proportion of a normal distribution which is less than or equal to 'q', for a normal with 
#a given mean and standard deviation
F(6)# proporation of countries that have a log10 population in 1952 <= 1million, log10 of 
#1 million is 6 as 10^6.
n<-length(x)#no of countries in the data to a vector 'n'
n# give the number 142
(F(7) - F(6))*n # normal distribution cumulative density function 
#(proportion) of 7 - 6 (10 million - 1 million) multiplied by number of countries 'n'.
sum(x > 6 & x <= 7) # this is the actual number in the sample
# which is 85 but he number above is from a normal distribution considering a population rather than
#a sample.
head(pnorm(x, mean=mean(x), sd=sd(x)))
mean(z)
sd(z)
head(pnorm(z))# only a list of few, try F(of the first number in x) so pnorm(z) is applying
#F function to all data compare with pnorm(z) to see all
#http://statistics.about.com/od/ProbHelpandTutorials/a/What-Is-The-Normal-Approximation-To-The-Binomial-Distribution.htm
qqnorm(x) # qq plot of x
ps <- ((1:n) - 0.5)/n # finding quantiles for the normal distribution?need to read
qnorm(ps)# find the matching quantiles from vector x in normal distribution
sort(qnorm(ps))
sort(x)
qnorm(ps[1])# finding the first quantile that matches the smalled number in 'x'
plot(qnorm(ps), sort(x))# plots the q-q plot
