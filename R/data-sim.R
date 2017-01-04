############################################
#
# This script simulates data for 9 variables from three clusters:
#   3 x baldness
#   3 x IQ
#   3 x Tendency to lie
#
# Correlations used to simulate the data are stronger within each cluster than
# between.

library(MASS)

simulate_data <- function(n = 1000, r_within = .7, r_between = .3) {
  # Set up within and between cluster correlations
  within  <- matrix(r_within, nrow = 3, ncol = 3)  # Correlations within a variable cluster
  between <- matrix(r_between, nrow = 3, ncol = 3)  # Correlations between a variable cluster
  
  # Create correlation matrix
  sigma <- rbind(
    cbind(within, between, between),
    cbind(between, within, between),
    cbind(between, between, within)
  )
  diag(sigma) <- 1  # Diagonal of 1s
  
  # Simulate the data
  set.seed(242)
  d <- mvrnorm(n = 1000, mu = rep(0, ncol(sigma)), Sigma = sigma)
  d <- as.data.frame(d)
  names(d) <- paste(rep(c("bald", "IQ", "liar"), each = 3), 1:3, sep = "_")
  d
}