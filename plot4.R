#Read file 
data <- read.table("household_power_consumption.txt", sep=";",  header=TRUE, as.is=TRUE)

#select the subsets to be used and replace data
loc <- grepl("^[1-2]/2/2007", data$Date)
data <- data[loc,]

#Merge Date and Time into a single vector 
new <- paste(data$Date, data$Time, sep=" ")
new <- strptime(new, format = "%d/%m/%Y %H:%M:%S")

#change Global_active_power to numeric
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)

#plot 
png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(data, plot(new, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
with(data, plot(new, Voltage, type="l", ylab="Voltage", xlab="dateTime"))
with(data, plot(new, Sub_metering_1, type="n", ylab="Energy Sub Metering", xlab=""))
with(data, plot(new, Sub_metering_1, type="n", ylab="Energy Sub Metering", xlab=""))
with(data, lines(new, Sub_metering_1, type="l",  col="black"))
with(data, lines(new, Sub_metering_2, type="l",  col="red"))
with(data, lines(new, Sub_metering_3, type="l",  col="blue"))
legend("topright", pch="____", col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
with(data, plot(new, Global_reactive_power, type="l", ylab="Global Rective Power", xlab="dateTime"))
dev.off()