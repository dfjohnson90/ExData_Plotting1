##Checks if the file has already been dowloaded, downloads it if it hasn't been
if (!file.exists("data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data.zip", method = "curl")
  data <- unzip("data.zip")
  data <- read.table(data, sep = ";")
}

##creates the file and sets the margins
png(filename = "plot2.png",width = 480,height = 480)
par(mfrow = c(1,1), mar = c(4,4,4,4))

##Sets column names to variable names, subsets out for requested date range
colnames(data) = data[1,]
dateRange <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]

##Creates a new column with Date and Time combined as class = date
dateRange$datetime <- strptime(paste(dateRange$Date, dateRange$Time), format = "%d/%m/%Y %H:%M:%S")

## Plots a line graph with datetime on x-axis, power on Y
plot(dateRange$datetime, dateRange$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

#finalizes file
dev.off()