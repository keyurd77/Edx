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
