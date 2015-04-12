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

##Plot2
png(filename="plot2.png", width = 480, height = 480, bg = "white")
plot(meters$Date,meters$Global_active_power, type="l", xlab="", ylab="Global Active Power(kilowatts)")
dev.off()
