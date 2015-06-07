#Read file 
data <- read.table("household_power_consumption.txt", sep=";",  header=TRUE, as.is=TRUE)

#select the subsets to be used and replace data
loc <- grepl("^[1-2]/2/2007", data$Date)
data <- data[loc,]

#Merge Date and Time into a single vector 
new <- paste(data$Date, data$Time, sep=" ")
new <- strptime(new, format = "%d/%m/%Y %H:%M:%S")

#change Global_active_power to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

with(data, plot(new, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.copy(png, file="plot2.png")
dev.off()