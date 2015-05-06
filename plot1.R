
library(chron)

# read data
consumption <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

# format Date column as dates
consumption$Date <- as.Date(consumption$Date, "%d/%m/%Y")

# select only entries from 2007-02-01 and 2007-02-02
consum <- consumption[consumption$Date == "2007-02-01" | consumption$Date == "2007-02-02", ]

# format Time column as time
consum$Time <- times(consum$Time) # strptime(consum$Time, format = "%H:%M:%S")

# change data format to numeric
consum$Global_active_power <- as.numeric(as.character(consum$Global_active_power))

# plot histogram
png("plot1.png", width=480, height=480, res=90)

hist(consum$Global_active_power, main = "Global Active Power", 
  col="red", xlab="Global Active Power (kilowatts)")

dev.off()
