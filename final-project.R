"""
Which are the main factors (human, natural) driving dissolved oxygen variability
in the canals of Padova in dry and wet weather?

E.g. light, temperature, rainfall, hydraulic gate operation and water levels, …
"""

library(ggplot2)
# Data files
output_file = 'data/sheets/miniDOT/piovego-parco-fistomba-station-OUTPUT.csv'
input_file = 'data/sheets/miniDOT/tronco-maestro-bastione-alicorno-station-INPUT.csv'
# Read in Data
output_complete = read.csv(output_file)
input_complete = read.csv(input_file)
# Remove records with NA
output <- na.omit(output_complete)
input <- na.omit(input_complete)
# rm unneeded data
rm(input_complete)
rm(output_complete)
# Replace date strings with date objects
input$Datetime <- as.POSIXlt(strptime(input$Datetime,format='%m/%d/%y %H:%M'))
output$Datetime <- as.POSIXlt(strptime(output$Datetime,format='%m/%d/%y %H:%M'))

ggplot(data=input, mapping = aes(WaterTemperatureInC, DOPercentSaturationPerc)) +
  geom_point()

ggplot(data=input, mapping = aes(WaterTemperatureInC, DissolvedOxygenMgpL)) +
  geom_point()


ggplot(data=input, mapping = aes(DOPercentSaturationPerc, DissolvedOxygenMgpL)) +
  geom_point()

cor(input$WaterTemperatureInC, input$DissolvedOxygenMgpL)
cor(input$WaterTemperatureInC, input$DOPercentSaturationPerc)

cor(output$WaterTemperatureInC, output$DissolvedOxygenMgpL)
cor(output$WaterTemperatureInC, output$DOPercentSaturationPerc)
