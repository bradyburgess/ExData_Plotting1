library(data.table)
library(lubridate)
library(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power.zip", method = 'curl')
unzip("power.zip")
data <- fread("household_power_consumption.txt")
data$Date <- dmy(data$Date)
data <- filter(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")
data$date_time = ymd_hms(paste(data$Date, data$Time))  

for (i in 3:8) {
  data[, i] <- as.numeric(data[, i])
}


# Plot 2
png(filename = "plot2.png")
plot(data$date_time, data$Global_active_power, type ="n", ylab = "Global Active Power (kilowatts)", xlab = NA)
lines(data$date_time, data$Global_active_power)
dev.off()
