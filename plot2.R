setwd("...")
##Subset file before loading it into R using awk 
con<-pipe("awk -F';' '$1==\"1/2/2007\" || $1==\"2/2/2007\" || NR==1{print}' household_power_consumption.txt")
#load subsetted file into R from connection
data<-read.table(con, header=T, sep=";", na.strings = c("","?"))

#convert to date from character variables
data$datetime<-strptime(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S","GMT")

png("ExData_Plotting1/plot2.png",width = 480,height = 480, bg = "transparent")
plot(data$datetime,data$Global_active_power, type="l", main="", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()

