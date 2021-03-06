pops<-read.csv("mice_pheno.csv") # read the file and store in 'pops'vector, this is the whole
#population which is usually not the case in real experiments
head(pops)# see the first few lines
hf <- pops [pops$Diet == "hf" & pops$Sex == "F", 3] # vector hf made from 'pops' and 
#extract from the Diet column only 'hf' but all columns & select from 'sex' column only females
# and display values of the third column which is Bodyweight.
chow <- pops [pops$Diet == "chow" & pops$Sex == "F", 3]# repeat the same for chow
mean(hf) - mean(chow)# this is the mean between hf and chow Bodyweights for females
x <- sample(hf, 12) # another vector x from hf which randomly samples 12 bodyweights (females)
y<- sample(chow, 12)#same for chow and vector y
mean (x) - mean(y)# mean for this random values which will change each time it is run
#as it is a random variable
#now to test the CLT theorem
Ns <- c(3, 5, 10, 25)# create Ns of 4 values
B <- 10000# B vector stands for 10000
res <- sapply (Ns, function(n){#create res vector to sapply Ns of 4 values as specified as function n
  sapply(1:B, function(j){#which will be sapply-'ied' 1:B (10000) times as function j
    mean(sample(hf, n)) - mean(sample(chow, n))#finally the real deal is the mean of hf - chow
  })# but each (hf and chow means) are randomly taken (sample command) n times as defined by Ns (code line 14,16)
})#http://www.dummies.com/how-to/content/how-to-create-a-function-in-r.html
#http://www.ats.ucla.edu/stat/r/library/intro_function.htm
par(mfrow=c(2,2))# we don't have rafalib as it is custom made this command is to display
#figures generated by the following commands in 2 row x 2 column format.
for (i in seq(along=Ns)){#http://www.dummies.com/how-to/content/how-to-loop-through-values-in-r.html
  title<- paste("Avg=", signif(mean(res[,i]), 3))
  title<- paste(title,"SD=", signif(sd(res[,i]), 3))
  qqnorm(res[,i], main=title)
  qqline(res[,i])
}

dat <- read.csv ("femaleMiceWeights.csv") # another vector dat
dat
control <- dat[1:12, 2]# extract first 12 rows of the second column
treatment <-dat[12+1:12, 2]# extract 12+1:12 (13:24) rows of the second column
diff<- mean(treatment) -mean(control) #vector diff is the difference in mean of these two random var
print(diff)#display diff
t.test(control, treatment) # t.test of control vs. treatment
#to see how it works we first find the sd of control
sd(control)/sqrt(length(control))
standarderror<- sqrt(var(treatment)/length(treatment) + var(control)/length(control))
standarderror
tstat<- diff/standarderror# this is the t-statistics, difference between two sample means by 
#the standard error, now the probability is
prob <- 1-pnorm(tstat)# probability of finding a value as extreme as 2.05
prob# but this is only one-tailed so to find two tailed
twotailprob<- 1-pnorm(tstat) + pnorm(-tstat)
twotailprob # this is the p-value and the value is different than the t-test function because the 
# sample size of 12 is not enough to use the CLT theorem and so the t.test function instead uses
# the t-distribution (which because even your standarderror (line 40) is a random variable, increases
# the ratio and hence gives a larger value
#), to quickly check if our sample size of 12 is approx normal
par(mfrow = c(1,1))
qqnorm(control)
qqline(control)
qqnorm(treatment)
qqline(treatment)
babies <-read.table("babies.txt", header=TRUE)
# split into two groups babies born to non-smoking mother and smoking mothers
View (babies)
bwt.nonsmoke <- babies$bwt[babies$smoke==0]
bwt.smoke <-babies$bwt[babies$smoke==1]
mean(bwt.nonsmoke)-mean(bwt.smoke)# true population diff in mean
sd(bwt.nonsmoke)
sd(bwt.smoke)
N<- 30
dat.ns<- bwt.nonsmoke[1:30]
dat.s<-bwt.smoke[1:30]
X.ns = mean(dat.ns)
sd.ns = sd(dat.ns)
X.s = mean(dat.s)
sd.s = sd(dat.s)
sd.diff = sqrt(sd.ns^2/N+sd.s^2/N)
tval = (X.ns - X.s)/sd.diff
t.test(dat.ns, dat.s)
pval = 1- pnorm(abs(tval)) + pnorm(-abs(tval))
pval
2*pnorm(-abs(tval))# this is the simplified form you can use as it is a normal distribution

