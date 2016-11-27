## plot2.R

## download data set if it is not already there
fileName <- "household_power_consumption.txt"
if (!file.exists(fileName)) {
	require(downloader)
	fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	zippedFileName <- "household_power_consumption.zip"	
	download(fileUrl, destfile = zippedFileName, mode = "wb")

	unzip(zippedFileName)
	unlink(zippedFileName)
}

## read power consumption data set
powerConsumption <- read.table(file = fileName, 
	header = TRUE, sep = ";", na.strings = "?")

## select data from 2007-02-01 and 2007-02-02 
powerConsumption <- subset(powerConsumption, 
	powerConsumption$Date %in% c("1/2/2007", "2/2/2007"))

## add date/time column
powerConsumption$Date_Time <- strptime(paste(powerConsumption$Date, 
	powerConsumption$Time), "%d/%m/%Y %H:%M:%S")

## create line chart of Global active power and save as png
png(file = "plot2.png")
Sys.setlocale("LC_TIME", "English")
with(powerConsumption, plot(Date_Time, Global_active_power, type = "l", 
	xlab = "", ylab = "Global Active Power (kilowatts)"))
curDevice = dev.off()
print("Created plot2.png")