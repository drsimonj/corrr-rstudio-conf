############################################
#
# This script simulates data for 9 variables from three clusters:
#   3 x IQ
#   3 x R skills
#   3 x Baldness
#
# Correlations used to simulate the data are stronger within each cluster than 
# between. Baldness variables set to correlate negatively with others (which
# correlate positively)

library(MASS)

simulate_data <- function(n = 1000, r_within = .5, r_between = .32) {
  # Set up within and between cluster correlations
  within  <- matrix(r_within, nrow = 3, ncol = 3)  # Correlations within a variable cluster
  between <- matrix(r_between, nrow = 3, ncol = 3)  # Correlations between a variable cluster
  
  # Create correlation matrix
  sigma <- rbind(
    cbind( within,   between, -between),
    cbind( between,  within,  -between),
    cbind(-between, -between,  within)
  )
  
  # Set diagonal to 1
  diag(sigma) <- 1  
  
  # Simulate the data
  set.seed(242)
  d <- mvrnorm(n = 1000, mu = rep(0, ncol(sigma)), Sigma = sigma)
  d <- d + runif(length(d), -.5, .5)  # Add some noise
  d <- as.data.frame(d)
  names(d) <- paste(rep(c("IQ", "Rskill", "bald"), each = 3), 1:3, sep = "_")
  d
}