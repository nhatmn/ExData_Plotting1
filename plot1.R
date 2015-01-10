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

## Plot 1
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()