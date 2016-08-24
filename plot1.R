library(tidyr)
library(dplyr)

# read the data
d1 <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
d1 <- tbl_df(d1)

# select data for the two days we need
d2 <- d1 %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

# combine Date and Time
d3 <- unite(d2, DateTime, Date, Time, sep = " ")

# plot on screen device
hist(d3$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# copy to a png file
dev.copy(png, file = "./plot1.png", width = 480, height = 480)
dev.off()
