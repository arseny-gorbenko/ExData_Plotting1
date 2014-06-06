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
# Construct the Plot
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
plot(final.data$Global_active_power~final.data$time, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
plot(final.data$Voltage~final.data$time, type = "l", ylab = "Voltage", 
     xlab = "datetime")
plot(final.data$Sub_metering_1~final.data$time, type = "l", ylab = "Energy sub metering", 
     xlab = "", ylim = range(final.data$Sub_metering_1[!is.na(final.data$Sub_metering_1)], 
                             final.data$Sub_metering_2[!is.na(final.data$Sub_metering_2)]))
par(new = TRUE)
plot(final.data$Sub_metering_2~final.data$time, type = "l", col = "red", ylab = "", 
     xlab = "", ylim = range(final.data$Sub_metering_1[!is.na(final.data$Sub_metering_1)], 
                             final.data$Sub_metering_2[!is.na(final.data$Sub_metering_2)]))
par(new = TRUE)
plot(final.data$Sub_metering_3~final.data$time, type = "l", col = "blue", ylab = "", 
     xlab = "", ylim = range(final.data$Sub_metering_1[!is.na(final.data$Sub_metering_1)], 
                             final.data$Sub_metering_3[!is.na(final.data$Sub_metering_3)]))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1, col = c("black", "red", "blue"), bty = "n")
plot(final.data$Global_reactive_power~final.data$time, type = "l", ylab = "Global_reactive_power", 
     xlab = "datetime")
dev.off()