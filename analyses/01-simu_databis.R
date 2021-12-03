#### --------------------------------------------- ####%
# Date : 03/12/2021
# Author : Emmanuelle, Bastien, Amandine
# email : amandine.vidal-hosteng@univ-tlse3.fr
# Encoding : UTF-8
# file : 01-simu_databis.R
#
# Simulate presence absence data
#### --------------------------------------------- ####%


#### Set seed for reproducibility ----
set.seed(78)

#### Create occupancy probabilities ----
# Create elevation vector
elev <- seq(0,2000,50)

# Create occupancy probability species by species
p_occ1 <- simu_occu(alpha = 0.01, beta = 0.001, elev = elev)$p_occu
p_occ2 <- simu_occu(alpha = 0.01, beta = -0.001, elev = elev)$p_occu
p_occ3 <- simu_occu(alpha = 0.01, beta = -0.001, elev = elev)$p_occu
p_occ4 <- simu_occu(alpha = 0.01, beta = 0.002, elev = elev)$p_occu

#### Create presence/absence matrix ----

oc <- cbind(rbinom(length(p_occ1), 1, p_occ1),
            rbinom(length(p_occ2), 1, p_occ2),
            rbinom(length(p_occ3), 1, p_occ3),
            rbinom(length(p_occ3), 1, p_occ4)
)




