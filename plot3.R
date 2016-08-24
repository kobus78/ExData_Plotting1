library(tidyr)
library(dplyr)
library(lubridate)

# read the data
d1 <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
d1 <- tbl_df(d1)

# select data for the two days we need
d2 <- d1 %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

# combine Date and Time
d3 <- unite(d2, DateTime, Date, Time, sep = " ")

# parse DateTime strings and store in dt column
d3 <- mutate(d3, dt = dmy_hms(d3$DateTime))

# plot on screen device
#par(mar = c(2, 2, 2, 8))
plot(d3$dt, d3$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(d3$dt, d3$Sub_metering_1)
lines(d3$dt, d3$Sub_metering_2, col = "red")
lines(d3$dt, d3$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"))

# copy to a png file
dev.copy(png, file = "./plot3.png", width = 480, height = 480)
dev.off()
