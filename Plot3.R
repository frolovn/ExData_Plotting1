library(tidyr)

##download and unzip the file
link <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.zip")){download.file(link, "household_power_consumption.zip")}  
if (!file.exists("household_power_consumption.txt")) {unzip("household_power_consumption.zip")}

##read table, split and make the header
tableFeb <- read.table("household_power_consumption.txt", skip = 66637, nrow = 2880)
tableFeb <- separate(tableFeb, V1, into = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";") 

##make required parts numeric, time and date classes
for (i in c(3:9)) { tableFeb[,i] <- as.numeric(as.character(tableFeb[,i])) }
tableFeb$Timestamp <- paste(tableFeb$Date,tableFeb$Time)
tableFeb <- tableFeb[,c(10, 3:9)]
tableFeb$Timestamp <- strptime(tableFeb$Time, "%d/%m/%Y %H:%M:%S")


##generate plot
png("Plot3.png")
plot(tableFeb$Timestamp, tableFeb$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
lines(tableFeb$Timestamp, tableFeb$Sub_metering_2, xlab="", type="l", col="red")
lines(tableFeb$Timestamp, tableFeb$Sub_metering_3, xlab="", type="l", col="blue")
legend("topright", legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"), col=c("black", "red", "blue"), lty=1)
dev.off()