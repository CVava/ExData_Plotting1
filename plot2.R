
library(chron)

# read data
consumption <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

# format Date column as dates
consumption$Date <- as.Date(consumption$Date, "%d/%m/%Y")

# select only entries from 2007-02-01 and 2007-02-02
consum <- consumption[consumption$Date == "2007-02-01" | consumption$Date == "2007-02-02", ]
# add first entry beyond the usefull range to act as label
consum <- rbind(consum, consumption[consumption$Date == "2007-02-03" & consumption$Time == "00:00:00", ])

# clean some memory
rm(consumption)

# format Time column as time
consum$Time <- times(consum$Time) # strptime(consum$Time, format = "%H:%M:%S")

# change data format to numeric
consum$Global_active_power <- as.numeric(as.character(consum$Global_active_power))

# plot histogram
png("plot2.png", width=480, height=480, res=90)

# no x axil ticks and labels
plot(consum$Global_active_power, type= 'l', 
  ylab="Global Active Power (kilowatts)", xlab="", xaxt = "n")

# add x axis ticks and labels to match the model
axis(1, at = c(1, length(consum$Date)/2, length(consum$Date)), 
  labels = c(format(consum$Date[1], "%a"), 
             format(consum$Date[length(consum$Date)/2+1], "%a"), 
             format(consum$Date[length(consum$Date)], "%a")))

# close the graphing device
dev.off()
