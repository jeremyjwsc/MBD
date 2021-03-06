# prostate data
install.packages("sda")
# load sda library
library("sda")

# load Singh et al (2001) data set
data(singh2002)
dim(singh2002$x) # 102 6033
hist(singh2002$x)
singh2002$y # 2 levels (healty/cancer)

n<-dim(singh2002$x)[1]
N<-dim(singh2002$x)[2]
t.val <- apply(singh2002$x,2,function(x){t.test(x=x[51:102],y=x[1:50],alternative="less",var.equal=T)$statistic})
z.val <- qnorm(pt(t.val,n-2))
hist(z.val,br=100,freq=FALSE)
u <- seq(-5,5,by=.1)
lines(u,dnorm(u),col="navy",lwd=3)

p.val <- apply(singh2002$x,2,function(x){t.test(x=x[51:102],y=x[1:50],alternative="less",var.equal=T)$p.value})
hist(p.val,br=100,freq=FALSE)
abline(h=1,col="navy",lwd=3)

# ecdf: Empirical cumulative distribution function
plot(ecdf(p.val),lwd=3)
abline(a=0,b=1,col="lightslateblue",lwd=3)

ks.test(p.val,"punif")      #  rechazamos que sean uniformes...
#####

##################
# Bonferroni

p.Bonf <- min(p.val)*N
p.Bonf
alpha=0.05
tau=alpha/N
sum(p.val<=tau) ## how many p-vals are le tau?
sum(p.adjust(sort(p.val), method="holm",N)<0.05)
sum(p.adjust(sort(p.val), method="bonferroni",N)<0.05)


