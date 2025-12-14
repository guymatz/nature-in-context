"""
Which are the main factors (human, natural) driving dissolved oxygen variability
in the canals of Padova in dry and wet weather?

E.g. light, temperature, rainfall, hydraulic gate operation and water levels, …
"""

rm(list=ls())
library(ggplot2)
library(deSolve)

setwd("/Users/gmatz/Code/unipd/nature-in-context")
# Data files
fish_data_file = 'data/data.csv'
# Read in Data
fish_data = read.csv(fish_data_file, comment.char = '#')
# Replace date strings with date objects
# data$Datetime <- as.POSIXlt(strptime(input$Datetime,format='%m/%d/%y %H:%M'))

cor(fish_data)

ggplot(data=fish_data, mapping = aes(year, ssb)) +
  geom_point()

fish_ode <- function(t, state, parms) {
  with(as.list(state), {
    dndt <- rep(0, length(state))
    # EQUATION
    dndt[1] = -k* N
    #
    return(list(dndt))
  })
}

N <- fish_data$ssb[1]
init <- c(N=N)
k <- 0.2
t = fish_data[,1]
out <- deSolve::ode(y = init, times = t, func = fish_ode, parms = NULL)
summary(out)
plot(out, type="l", xlab = "Time", ylab="Fishes")

ssb <- fish_data[, c("year", "ssb")]
print(ssb)

print(paste("RSSE:", sum((out[,2] - ssb[,2])^2)))
print("That's pretty big")
