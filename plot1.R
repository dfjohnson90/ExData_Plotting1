if (!file.exists("data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data.zip", method = "curl")
  data <- unzip("data.zip")
  data <- read.table(data, sep = ";")
}
##creates the file and sets the margins
png(filename = "plot1.png",width = 480,height = 480)
par(mfrow = c(1,1), mar = c(5,4,2,4))

colnames(data) = data[1,]
dateRange <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]

hist(as.numeric(dateRange$Global_active_power), col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#finalizes file
dev.off()