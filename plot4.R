setwd("C:\\BigData")
library(sqldf)
myfile <- "household_power_consumption.txt"
mysql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

meters<-read.csv.sql(file=myfile, sql=mysql, header = TRUE, sep = ";")
##meters_n1<-as.xts(read.zoo(meters))

##meters$Date<-as.Date(meters$Date, format='%d/%m/%Y')
meters$Date<-strptime(paste(meters$Date,meters$Time), format='%d/%m/%Y %H:%M:%S')
head(meters)
weekd<-weekdays(meters$Time)
meters_n<-cbind(meters, weekd)
head(meters_n)
unique(weekd)

##Plot4
png(filename="plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plot(meters$Date,meters$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(meters$Date,meters$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(meters$Date,meters$Sub_metering_1, type="n",xlab="",ylab="Energy sub metering")
lines(meters$Date,meters$Sub_metering_1,lwd=1)
lines(meters$Date,meters$Sub_metering_2,lwd=1, col="red")
lines(meters$Date,meters$Sub_metering_3,lwd=1, col="blue")
legend("topright", legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, col=c("black","red","blue"))
plot(meters$Date,meters$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
