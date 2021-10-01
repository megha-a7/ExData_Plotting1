# plot4.R - Multiplot time series of global active power, voltage,
#           submetering and global reactive power

source ("fetchData.R")

dataFile.local<-"household_power_consumption.txt"

# download data from the URL provided to local folder
if (!file.exists (dataFile.local)) 
  fetchData();

# Read data, convert dates and subset on two days in February 2007
# data <- readData(dataFile.local);
data <- readData(dataFile.local);

# Open plot4.png
png("plot4.png", height=480, width=480)


# Configure a 2x2 multiplot
par(mfrow=c(2,2))

# Global Active Power plot
plot(data$DateTime, 
     data$Global_active_power, 
     pch=NA, 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
lines(data$DateTime, data$Global_active_power)

# Voltage plot
plot(data$DateTime, data$Voltage, ylab="Voltage", xlab="datetime", pch=NA)
lines(data$DateTime, data$Voltage)

# Submetering plot
plot(data$DateTime, 
     data$Sub_metering_1, 
     pch=NA, 
     xlab="", 
     ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col='red')
lines(data$DateTime, data$Sub_metering_3, col='blue')
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'),
       bty = 'n')

# Global reactive power plot
with(data, plot(DateTime, Global_reactive_power, xlab='datetime', pch=NA))
with(data, lines(DateTime, Global_reactive_power))

# Close PNG file
dev.off()