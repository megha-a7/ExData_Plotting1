# plot3.R - Time Series of Global Active Power by Energey Submeter

source ("fetchData.R")

dataFile.local<-"household_power_consumption.txt"

# download data from the URL provided to local folder
if (!file.exists (dataFile.local)) 
  fetchData();

# Read data, convert dates and subset on two days in February 2007
# data <- readData(dataFile.local);
data <- readData(dataFile.local);


# Open plot3.pngstr
png("plot3.png", height=480, width=480)

# Build time series
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
       col = c('black', 'red', 'blue'))

# Close PNG file
dev.off()