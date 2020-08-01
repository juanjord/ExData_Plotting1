library(lubridate)
library(dplyr)

data <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";"
                   , header = TRUE)

data$Date <- as.Date(data$Date, "%d/%m/%Y")
d1 <- as.Date("2007-02-01")
d2 <- as.Date("2007-02-02")
data2 <- data %>% filter(between(Date,d1,d2))

# Create a new column for the date and time combined
data2$datetime <- as_datetime(paste(data2$Date, data2$Time))

# Margins
par(mfrow = c(2,2), mar = c(4,4,2,2))
# Plot 1
with(data2, plot(datetime, Global_active_power, type = "l", 
                 xlab = "", ylab = "Global Active Power"))

# Plot 2
with(data2, plot(datetime, Voltage, type = "l", 
                 xlab = "datetime"))

# Plot 3
with(data2, plot(datetime, Sub_metering_1, type = "l",
                 xlab = "", ylab = "Energy sub metering"))
lines(data2$datetime, data2$Sub_metering_2, col = "red",type = "l")
lines(data2$datetime, data2$Sub_metering_3, col = "blue",type = "l")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd = 2, lty = 1, col = c("black","red","blue"), bty = "n", cex = 0.8)

# Plot 4
with(data2, plot(datetime, Global_reactive_power, type = "l", 
                 xlab = "datetime"))

# Saving it in a png file
dev.copy(png, file = "plot4.png")
dev.off()

