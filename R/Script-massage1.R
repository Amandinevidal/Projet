
elev<-seq(0,2000,50)

#############################
mu<-0.01
beta<-0.002
Lpoc1<-mu+beta*elev
Lpoc1
poc1<-exp(Lpoc1)/(1+exp(Lpoc1))
poc1
plot(poc1~elev)
###########################
beta2<-beta-0.0018
Lpoc2<-mu+beta2*elev

poc2<-exp(Lpoc2)/(1+exp(Lpoc2))
poc2

###########################
Lpoc3<-Lpoc2
poc3<-exp(Lpoc3)/(1+exp(Lpoc3))
poc3



#########################

to<-length(elev)
oc<-matrix(NA, nrow=to, ncol=3)

mu<-0.01
beta<-0.001
beta2<-beta-0.0018

i<-mi
i<-1
 for (i in 1: to){
    Lpoc1[i]<-mu+beta*elev[i]
    poc1[i]<-exp(Lpoc1[i])/(1+exp(Lpoc1[i]))
    oc[i,1]<-rbinom(1,1,poc1[i])
    Lpoc2[i]<-mu+beta2*elev[i]
    poc2[i]<-exp(Lpoc2[i])/(1+exp(Lpoc2[i]))
    oc[i,2]<-rbinom(1,1,poc2[i])
    poc3[i]<-exp(Lpoc2[i])/(1+exp(Lpoc2[i]))
    oc[i,3]<-rbinom(1,1,poc3[i])
   }


#########################    VERS JAGS
library(rjags)
N<-nrow(oc)
S<-ncol(oc)
y<-oc
evel<-elev
mydata <- list(elev=elev,S=S, N=N, y=y)

# list of inits

init1<-list(mu=runif(1,-10,10), beta=c(0.01,0.005,0.01),mubeta=runif(1,-10,10),taubeta=runif(1,0,100),taumu=runif(1,0,100))

init2<-list(mu=runif(1,-10,10), beta=c(0.001,0.003,0.001),mubeta=runif(1,-10,10),taubeta=runif(1,0,100),taumu=runif(1,0,100))

init3<-list(mu=runif(1,-10,10), beta=c(0.002,0.004,0.008),mubeta=runif(1,-10,10),taubeta=runif(1,0,100),taumu=runif(1,0,100))

inits <- list(init1,init2, init3)

# specify the parameters to be monitored
parameters <- c("beta[1]", "beta[2]", "beta[3]", "mu", "taumu", "taubeta")


start<-as.POSIXlt(Sys.time())

jmodel <- jags.model("model-presence.txt", data=mydata, inits, n.chains = 3,n.adapt = 200)

update(jmodel, n.iter=1000)

jsample <- coda.samples(jmodel, parameters, n.iter=2000, thin = 5)
end <-as.POSIXlt(Sys.time())
duration = end-start
duration
  

summary(jsample)

save(jsample,jmodel,duration,file='testpresence.Rdata')

#################
install.packages("MCMCvis")
library(MCMCvis)
MCMCsummary(jsample)
MCMCplot(jsample, params=c('beta', 'mu'))




