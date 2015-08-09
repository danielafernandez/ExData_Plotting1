# plot2.R
# The code below loads data from xx, subsets the data based o a range of dates
# and generates the second graph. 
library(RCurl)
## Check if file exists in expected path, if it doesn't download it and unzip it 
if (!file.exists("household_power_consumption.txt")) {
  fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, "exdata-data-household_power_consumption.zip", method = "curl")
  unzip("exdata-data-household_power_consumption.zip", overwrite = T, exdir = ".")
}

## Read file and load it with table function
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?",check.names = F, 
                  stringsAsFactors = F, comment.char = "", quote = '\"')

##convert the Date variables to Date
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")
## Subsets data based on dates conditional. 
## We will only be using data from the dates 2007-02-01 and 2007-02-02

subhpc <- subset(hpc, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
## Delete hpc to free memory, we don't need this since we have the subset we will be working with
rm(hpc)

## Transform datetime
subhpc$DateTime <- as.POSIXct(paste(as.Date(subhpc$Date),subhpc$Time))


## Plot second graph
png("plot2.png", width=480, height=480)
plot(subhpc$Global_active_power ~ subhpc$DateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Export plot into .png file 
dev.off()
