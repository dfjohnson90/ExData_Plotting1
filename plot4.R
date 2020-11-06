##Checks if the file has already been dowloaded, downloads it if it hasn't been
if (!file.exists("data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data.zip", method = "curl")
  data <- unzip("data.zip")
  data <- read.table(data, sep = ";")
}
##Sets column names to variable names, subsets out for requested date range
colnames(data) = data[1,]
dateRange <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]

##Creates a new column with Date and Time combined as class = date
dateRange$datetime <- strptime(paste(dateRange$Date, dateRange$Time), format = "%d/%m/%Y %H:%M:%S")

##creates the file and sets the margins
png(filename = "plot4.png",width = 480,height = 480)
par(mfrow = c(2,2), mar = c(5,5,4,4))


##Global Active Power Plot
plot(dateRange$datetime, dateRange$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

##datetime vs voltage
plot(dateRange$datetime, dateRange$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

##datetime vs sub metering
plot(dateRange$datetime, dateRange$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dateRange$datetime, dateRange$Sub_metering_2, type = "l", col = "red")
lines(dateRange$datetime, dateRange$Sub_metering_3, type = "l", col = "blue")

## creates a legend in the top right corner
legend(("topright"), legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black","red","blue"), bty = "n", cex = 0.7)

##datetime vs Global reactive power
plot(dateRange$datetime, dateRange$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

#finalizes file
dev.off()