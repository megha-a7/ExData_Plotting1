# plot1.R - Histogram of Global Active Power

source ("fetchData.R")

dataFile.local<-"household_power_consumption.txt"

# download data from the URL provided to local folder
if (!file.exists (dataFile.local)) 
  fetchData();

# Read data, convert dates and subset on two days in February 2007
# data <- readData(dataFile.local);
data <- readDataOptimal(dataFile.local);

# Open plot1.png
png("plot1.png", height=480, width=480)

# Build histogram
hist(data$Global_active_power, col='red', 
     xlab = 'Global Active Power (kilowatts)',
     main = 'Global Active Power')
rug(data$Global_active_power)

# Close PNG file
dev.off()