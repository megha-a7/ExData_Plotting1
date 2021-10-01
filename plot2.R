# plot2.R - Time Series of Global Active Power

source ("fetchData.R")

dataFile.local<-"household_power_consumption.txt"

# download data from the URL provided to local folder
if (!file.exists (dataFile.local)) 
  fetchData();

# Read data, convert dates and subset on two days in February 2007
data <- readData(dataFile.local);


# Open plot2.png
png("plot2.png", height=480, width=480)

#Build time series
plot(data$DateTime, 
     data$Global_active_power, 
     pch=NA, 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
lines(data$DateTime, data$Global_active_power)

# Close PNG file
dev.off()
