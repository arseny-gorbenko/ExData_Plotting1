# First I download the file from the folder and transform the dates there
# into a POSIX format
data <- read.table("C:/Users/Sony/Documents/R stuff/household_power_consumption.txt", 
                   header = TRUE, sep = ";", na.strings = "?")
data <- transform(data, time = strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
date = data$time
# Extract the required observations between 01-02-2007 and 02-02-2007
lower = strptime("2/1/2007 00:00","%m/%d/%Y %H:%M")
upper = strptime("2/2/2007 23:59","%m/%d/%Y %H:%M")
final.data <- data[date >= lower & date <= upper, ]
# Construct the Plot 1
plot(final.data$Global_active_power~final.data$time, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()
# Чт Пт and Сб is the same as Thu Fri and Sat, but I cannot
# change the language of it