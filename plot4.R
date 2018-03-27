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


#Plot 4

png(filename = "plot4.png")
par(mfrow = c(2, 2))
plot(data$date_time, data$Global_active_power, type ="n", ylab = "Global Active Power (kilowatts)", xlab = NA)
lines(data$date_time, data$Global_active_power)

plot(data$date_time, data$Voltage, type = "n", ylab = "Voltage", xlab = "datetime")
lines(data$date_time, data$Voltage)

plot(x = data$date_time, y = data$Sub_metering_1, type ="n", ylab = "Energy sub metering", ylim = c(0, 40), xlab = NA)
lines(data$date_time, data$Sub_metering_3, col = "black")
lines(data$date_time, data$Sub_metering_1, col = "blue")
lines(data$date_time, data$Sub_metering_2, col = "red")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

plot(data$date_time, data$Global_reactive_power, type = "n", ylab = "Global_reactive_power", xlab = "datetime")
lines(data$date_time, data$Global_reactive_power)
dev.off()

