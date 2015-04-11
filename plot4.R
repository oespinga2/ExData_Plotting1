setwd("...")
##Subset file before loading it into R using awk 
con<-pipe("awk -F';' '$1==\"1/2/2007\" || $1==\"2/2/2007\" || NR==1{print}' household_power_consumption.txt")
#load subsetted file into R from connection
data<-read.table(con, header=T, sep=";", na.strings = c("","?"))

#convert to date from character variables
data$datetime<-strptime(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S","GMT")

png("ExData_Plotting1/plot4.png",width = 480,height = 480, bg = "transparent")
par(mfrow=c(2,2))
plot(data$datetime,data$Global_active_power, type="l", main="", ylab="Global Active Power", xlab="")

plot(data$datetime,data$Voltage, type="l", main="", ylab="Voltage",xlab="datetime")

plot(data$datetime,data$Sub_metering_1, type="l", main="", xlab="", ylab="Energy sub metering")
lines(data$datetime,data$Sub_metering_2,col="red")
lines(data$datetime,data$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty=1, bty = "n")

plot(data$datetime, data$Global_reactive_power, type="l", main="", ylab="Global_reactive_power",xlab="datetime")

dev.off()
