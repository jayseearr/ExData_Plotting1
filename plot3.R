# plot3.R

# This project uses an electrical power consumption dataset available at the
# following link:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# As written, this code assumes that the unzipped data file 
# "household_power_consumption.txt" exists in the current working directory,
# along with this script file. If that's not the case, the following code
# can be used to download and unzip the data file on a Mac:
#
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "2Fhousehold_power_consumption.zip", method="curl")
# unzip("household_power_consumption.zip")


# If the "png" package is not installed, uncomment this line:
# install.packages("png")
library(png)

power <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = c("NA","?"))

# Get the subset of data corresponding to Feb 1 and Feb 2, 2007
dateRange <- c("2007-02-01", "2007-02-02")
data <- subset(power, as.Date(power$Date,"%d/%m/%Y") >= as.Date(min(dateRange),"%Y-%m-%d") & 
                      as.Date(power$Date,"%d/%m/%Y") <= as.Date(max(dateRange),"%Y-%m-%d"))

# Create a png device where plot will be sent:
png(filename="plot3.png", width = 480, height = 480, units = "px")

# Create line plot in the png device
x <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
plot(x, data$Sub_metering_1, type="l", 
     xlab="", ylab="Energy sub metering", col="black")
lines(x, data$Sub_metering_2, col="red")
lines(x, data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1)

# close the active (png) device
dev.off()
