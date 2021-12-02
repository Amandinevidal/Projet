#### --------------------------------------------- ####%
# Date : 02/12/2021
# Author : Emmanuelle, Bastien, Amandine
# email : amandine.vidal-hosteng@univ-tlse3.fr
# Encoding : UTF-8
# file : function.R

# Create all functions used in the project
#### --------------------------------------------- ####%


#' Simulate Occupancy Probability
#'
#' @param alpha # intercept
#' @param beta # linear coefficient
#' @param elev # specify elevations
#'
#' @return
#' @export
#'
#' @examples
simu_occu <- function(alpha = 0.01, beta = 0.002, elev = seq(0, 2000, 50)) {

  Lpoc <- alpha + beta*elev  + rnorm(length(elev), 0, 0.5) # create occupancy vector
  p_occu <- exp(Lpoc) / (1 + exp(Lpoc)) #
  return(list("elev" = elev, "p_occu" = p_occu))

}
