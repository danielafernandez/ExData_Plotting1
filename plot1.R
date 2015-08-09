# plot1.R
# The code below loads data from xx, subsets the data based o a range of dates
# and generates the first graph. 
library(RCurl)
## Check if file exists in expected path, if it doesn't download it and unzip it 
if (!file.exists("household_power_consumption.txt")) {
  fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, "exdata-data-household_power_consumption.zip", method = "curl")
  unzip("exdata-data-household_power_consumption.zip", overwrite = T, exdir = ".")
}

## Read file and load it with table function
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

##convert the Date variables to Date
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")

## Subsets data based on dates conditional. 
## We will only be using data from the dates 2007-02-01 and 2007-02-02
subhpc <- subset(hpc, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
## Delete hpc to free memory, we don't need this since we have the subset we will be working with
rm(hpc)

## Plot first graph
png("plot1.png", width=480, height=480)
hist(subhpc$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")

## Export plot into .png file with size 480x480

dev.off()
