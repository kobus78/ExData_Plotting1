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
plot(d3$dt, d3$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(d3$dt, d3$Global_active_power)

# copy to a png file
dev.copy(png, file = "./plot2.png", width = 480, height = 480)
dev.off()
