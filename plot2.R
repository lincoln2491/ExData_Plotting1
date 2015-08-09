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

png(filename = "plot2.png")
plot(data$DateAndTime, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = NA)
dev.off()