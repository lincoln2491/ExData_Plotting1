if(!file.exists("exdata_data_household_power_consumption.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                destfile = "exdata_data_household_power_consumption.zip", method = "curl")
}
if(!file.exists("household_power_consumption.txt")){
  unzip("exdata_data_household_power_consumption.zip")
}

data = read.csv("household_power_consumption.txt", sep=";", na.strings = "?")
data = data[data$Date =="1/2/2007" | data$Date == "2/2/2007",]
data$Date = as.Date(data$Date, format = "%d/%m/%Y")
data$Global_active_power = as.numeric(as.character(data$Global_active_power))

png(filename = "plot1.png")
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()