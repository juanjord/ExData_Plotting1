library(lubridate)
library(dplyr)

data <- read.table("./household_power_consumption.txt", na.strings = "?", sep = ";"
                   , header = TRUE)
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Filtering the data
d1 <- as.Date("2007-02-01")
d2 <- as.Date("2007-02-02")
data2 <- data %>% filter(between(Date,d1,d2))

# Creating the plot and saving it in a png file
png(filename = "plot1.png", width = 480, height = 480)
hist(data2$Global_active_power, col = "red",
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")
dev.off()

