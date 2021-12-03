#### --------------------------------------------- ####%
# Date : 03/12/2021
# Author : Emmanuelle, Bastien, Amandine
# email : amandine.vidal-hosteng@univ-tlse3.fr
# Encoding : UTF-8
# file : 02-modelbis.R
#
# Linear model of the simulated presence/absence data
#### --------------------------------------------- ####%


#### Write model ----
set.seed(442)
cat("
    model {

      for (i in 1:N)  {

        for (j in 1:S) {
          y[i, j] ~ dbern(p[i,j])
          p[i, j] <- exp(mu + beta[j]*elev[i]) / (1 + exp(mu + beta[j]*elev[i]))
        }

      }

      #priors
      mu ~ dnorm(0, taumu)
      taumu ~ dgamma(0.1, 0.1)
      taubeta ~ dgamma(0.1, 0.1)
      mubeta ~ dnorm(0, 1.0E-06)

      for (j in 1:S) {
        beta[j] ~ dnorm(mubeta, taubeta)
      }

   }
    ", file = here::here("analyses", "modelbis.txt"))

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
              mubeta = rnorm(1, 0, 0.01))

# specify the parameters to be monitored
parameters <- c("beta[1]", "beta[2]", "beta[3]", "beta[4]","mu", "taumu", "taubeta")

#### Run it in rjags ----

start <- as.POSIXlt(Sys.time())

jmodelbis <- rjags::jags.model(here::here("analyses", "modelbis.txt"),
                            data = mydata,
                            inits = inits,
                            n.chains = 3,
                            n.adapt = 80)

update(jmodelbis, n.iter=1)

jsample <- rjags::coda.samples(jmodelbis,
                               parameters,
                               n.iter=200,
                               thin = 5)
end <- as.POSIXlt(Sys.time())
duration <- end-start
duration


#### Save outputs ----

save(jsample,
     file=here::here("Outputs", 'modelbis_output.Rdata'))


