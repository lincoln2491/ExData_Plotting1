if(!file.exists("exdata_data_household_power_consumption.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                destfile = "exdata_data_household_power_consumption.zip", method = "curl")
}
if(!file.exists("household_power_consumption.txt")){
  unzip("exdata_data_household_power_consumption.zip")
}

data = read.csv("household_power_consumption.txt", sep=";", na.strings = "?")
data = data[data$Date =="1/2/2007" | data$Date == "2/2/2007",]

data$DateAndTime = strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
data$Global_active_power = as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power = as.numeric(as.character(data$Global_reactive_power))

png(filename = "plot4.png")
par(mfcol = c(2, 2))

#plot 1
plot(data$DateAndTime, data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = NA)

#plot2
plot(data$DateAndTime, data$Sub_metering_1, type = "n", ylab = "Energy sub metting", xlab = NA)
lines(data$DateAndTime, data$Sub_metering_1)
lines(data$DateAndTime, data$Sub_metering_2, col = "red")
lines(data$DateAndTime, data$Sub_metering_3, col = "blue")
legend("topright", pch = NA, lty =1, 
       col = c("black", "red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), bty = "n")

#plot3
plot(data$DateAndTime, data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

#plot4
plot(data$DateAndTime, data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()