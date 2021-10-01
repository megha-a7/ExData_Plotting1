require (data.table)
require (sqldf)
#
# download and extract the source data
# Dataset: Electric power consumption [20Mb]
# data.url = https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# data.description.source: UCI web site : "https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption"
#

fetchData <- function (data.url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip") { 
  # download the file 
  data.local <- "data.zip"    
  #download.file (data.url, data.local, method = "curl")        
  download.file (data.url, data.local) 
  
  # extract the file    
  unzip (data.local)    
  if (!file.exists ("household_power_consumption.txt"))         
    stop ("unable to extract the source data!")        
  
  # delete the zip file    
  unlink (data.local)
}


# Read data, convert dates and subset on two days in February 2007
readData <- function(path ="household_power_consumption.txt") {
  
  if (!file.exists (path))         
    stop ("file household_power_consumption.txt does not exist!")
  
  data <- read.table(path, sep=';', header=T, 
                     colClasses = c('character', 'character', 'numeric',
                                    'numeric', 'numeric', 'numeric',
                                    'numeric', 'numeric', 'numeric'),
                     na.strings='?')
  
  data$DateTime <- strptime(paste(data$Date, data$Time), 
                            "%d/%m/%Y %H:%M:%S")
  data <- subset(data, 
                 as.Date(DateTime) >= as.Date("2007-02-01") & 
                   as.Date(DateTime) <= as.Date("2007-02-02"))
  return(data);
}


# The method below is very optimal as fread provides fast reading.
# Read data, convert dates and subset on two days in February 2007
readDataOptimal <-function (path ="household_power_consumption.txt") {
  if (!file.exists (path))         
    stop ("file household_power_consumption.txt does not exist!")
  
  # note this requires data.table 
  # it reads only date column - it is pretty fast to explore)
  findRows<-fread(path, header = TRUE, select = 1)

  all<-(which(findRows$Date %in% c("1/2/2007", "2/2/2007")) )
  skipLines<- min(all)
  keepRows<- length(all)

  # Get the header
  header <-fread(path, nrows=0, na.strings='?')
  
  # Get data of interest
  data <-fread(path, skip=skipLines, nrows=keepRows, na.strings='?')
  setnames(data, names(data),names(header));
  
}


##### Note there is a problem with sql on windows 7 - need to explore further.
# Read data, convert dates and subset on two days in February 2007
# readData3 <-function (path ="household_power_consumption.txt") {
#   if (!file.exists (path))         
#     stop ("file household_power_consumption.txt does not exist!")
#   mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
#   myData<- read.csv2.sql(path,mySql)
#   
#   return (myData)
  
#}