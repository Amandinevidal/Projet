


###### Create occupancy probabilities
elev <- seq(0,2000,50)
p_occ1 <- simu_occu(alpha = 0.01, beta = 0.001, elev = elev)$p_occu
p_occ2 <- simu_occu(alpha = 0.01, beta = -0.001, elev = elev)$p_occu
p_occ3 <- simu_occu(alpha = 0.01, beta = -0.001, elev = elev)$p_occu
plot(p_occ1~elev) ; plot(p_occ2~elev)


to <- length(elev)
dat <- cbind(rbinom(length(p_occ1), 1, p_occ1),
            rbinom(length(p_occ2), 1, p_occ2),
            rbinom(length(p_occ3), 1, p_occ3)
)




