# plot4.R

library(chron)

# read data
consumption <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

# format Date column as dates
consumption$Date <- as.Date(consumption$Date, "%d/%m/%Y")

# select only entries from 2007-02-01 and 2007-02-02
consum <- consumption[consumption$Date == "2007-02-01" | consumption$Date == "2007-02-02", ]
# add first entry beyond the usefull range to act as end label
consum <- rbind(consum, consumption[consumption$Date == "2007-02-03" & consumption$Time == "00:00:00", ])

# clean some memory
rm(consumption)

# format Time column as time
consum$Time <- times(consum$Time) # strptime(consum$Time, format = "%H:%M:%S")

# change data format to numeric
consum$Sub_metering_1 <- as.numeric(as.character(consum$Sub_metering_1))
consum$Sub_metering_2 <- as.numeric(as.character(consum$Sub_metering_2))
consum$Sub_metering_3 <- as.numeric(as.character(consum$Sub_metering_3))
consum$Global_active_power <- as.numeric(as.character(consum$Global_active_power))
consum$Global_reactive_power <- as.numeric(as.character(consum$Global_reactive_power))
consum$Voltage <- as.numeric(as.character(consum$Voltage))


# initiate graphing device
png("plot4.png", width=480, height=480, res=90)
par(mfrow=c(2, 2))                # 2x2 graphs
par(cex = 0.7)                    # smaller font fit better

### 1. plot histogram ###
# no x axil ticks and labels
plot(consum$Global_active_power, type= 'l', 
  ylab="Global Active Power", xlab="", xaxt = "n")

# add x axis ticks and labels to match the model
axis(1, at = c(1, length(consum$Date)/2, length(consum$Date)), 
  labels = c(format(consum$Date[1], "%a"), 
             format(consum$Date[length(consum$Date)/2+1], "%a"), 
             format(consum$Date[length(consum$Date)], "%a")))


### 2. plot Voltage ###
# no x axil ticks and labels
plot(consum$Voltage, type= 'l', 
  ylab="Voltage", xlab="datetime", xaxt = "n")

# add x axis ticks and labels to match the model
axis(1, at = c(1, length(consum$Date)/2, length(consum$Date)), 
  labels = c(format(consum$Date[1], "%a"), 
             format(consum$Date[length(consum$Date)/2+1], "%a"), 
             format(consum$Date[length(consum$Date)], "%a")))


### 3. Sub_metering_x ###
# no x axis ticks and labels
with(consum, plot(consum$Sub_metering_1, ylab="Energy sub metering", 
  xlab="", xaxt = "n", type = "l"), type = "n")
with(consum, points(consum$Sub_metering_2, type= 'l', col = "red", 
  xlab="", xaxt = "n"))
with(consum, points(consum$Sub_metering_3, type= 'l', col = "blue", 
  xlab="", xaxt = "n"))

# add legend
legend("topright", pch="-", col=c("black", "red", "blue"), 
  legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# add x axis ticks and labels to match the model
axis(1, at = c(1, length(consum$Date)/2, length(consum$Date)), 
  labels = c(format(consum$Date[1], "%a"), 
             format(consum$Date[length(consum$Date)/2+1], "%a"), 
             format(consum$Date[length(consum$Date)], "%a")))


### 4. Global_reactive_power ###
# no x axil ticks and labels
plot(consum$Global_reactive_power, type= 'l', 
  ylab="Global_reactive_power", xlab="datetime", xaxt = "n")

# add x axis ticks and labels to match the model
axis(1, at = c(1, length(consum$Date)/2, length(consum$Date)), 
  labels = c(format(consum$Date[1], "%a"), 
             format(consum$Date[length(consum$Date)/2+1], "%a"), 
             format(consum$Date[length(consum$Date)], "%a")))


# close the graphing device
dev.off()
