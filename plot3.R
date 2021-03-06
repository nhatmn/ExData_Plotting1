## Getting full dataset of household_power_consumption.txt
## - The dataset has 2,075,259 rows and 9 columns.
## - Missing values are coded as "?"
## - sep=';'
fullHouseholdPowerConsumptionData <- read.csv("household_power_consumption.txt", 
                                              header=T, sep=';', na.strings="?", 
                                              nrows=2075259, check.names=F, 
                                              stringsAsFactors=F, comment.char="", 
                                              quote='\"')

## Convert the Date and Time variables to Date/Time classes in R using the as.Date()
fullHouseholdPowerConsumptionData$Date <- as.Date(fullHouseholdPowerConsumptionData$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(fullHouseholdPowerConsumptionData, 
               subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Remove the full data to free that much memory.
rm(fullHouseholdPowerConsumptionData)

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 3
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
