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

# Creating the plot and saving it in a png file
png(filename = "plot3.png", width = 480, height = 480)
with(data2, plot(datetime, Sub_metering_1, type = "l",
                 xlab = "", ylab = "Energy sub metering"))
lines(data2$datetime, data2$Sub_metering_2, col = "red",type = "l")
lines(data2$datetime, data2$Sub_metering_3, col = "blue",type = "l")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd = 2, lty = 1, col = c("black","red","blue"))
dev.off()

