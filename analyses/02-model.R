


#### Write model ----
set.seed(442)
cat("
    model {
   for (i in 1:N)  {
     for (j in 1:S){
        y[i,j]~dbern(p[i,j])
        p[i,j]<-exp(mu+beta[j]*elev[i])/(1+exp(mu+beta[j]*elev[i]))
     }
    }
    #priors
    mu~dnorm(0, taumu)
    taumu~dgamma(0.1,0.1)
    taubeta~dgamma(0.1,0.1)
    mubeta~dnorm(0, 1.0E-06)

    for (j in 1:S){
      beta[j]~dnorm(mubeta,taubeta)
    }
   }
    ", file = here::here("analyses", "model.txt"))

##### Specify data, inits & params for Jags ----

N <- nrow(oc)
S <- ncol(oc)
y <- oc
evel <- elev
mydata <- list(elev = elev,
               S = ncol(oc),
               N = nrow(oc),
               y = oc)

# list of inits

inits <- list(mu = runif(1,-10,10),
              beta = rnorm(3, mean = 0.01, sd = 0.01),
              mubeta = runif(1, -10, 10),
              taubeta = runif(1, 0, 100),
              taumu = runif(1, 0, 100))

# specify the parameters to be monitored
parameters <- c("beta[1]", "beta[2]", "beta[3]", "mu", "taumu", "taubeta")

#### Run it in rjags ----

start <- as.POSIXlt(Sys.time())

jmodel <- rjags::jags.model(here::here("analyses", "model.txt"),
                            data = mydata,
                            inits = inits,
                            n.chains = 3,
                            n.adapt = 200)

update(jmodel, n.iter=10)

jsample <- rjags::coda.samples(jmodel,
                               parameters,
                               n.iter=200,
                               thin = 5)
end <- as.POSIXlt(Sys.time())
duration <- end-start
duration


#### Save outputs ----

save(jsample,
     file=here::here("Outputs", 'model_output.Rdata'))
